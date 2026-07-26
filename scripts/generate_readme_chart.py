#!/usr/bin/env python3
"""
generate_readme_chart.py

Scans every .sql file in Problems/, detects which SQL technique each
solution primarily relies on (by pattern-matching the query text, not
the filename), tallies the results, and rewrites the "Technique
Breakdown" section of README.md with an up-to-date Mermaid pie chart.

Usage:
    python3 scripts/generate_readme_chart.py

Run this any time you add, edit, or remove a .sql file in Problems/.
Nothing is hand-maintained -- the chart is always derived from the
actual query text on disk.
"""

import re
import sys
from pathlib import Path
from collections import Counter

REPO_ROOT = Path(__file__).resolve().parent.parent
PROBLEMS_DIR = REPO_ROOT / "Problems"
README_PATH = REPO_ROOT / "README.md"

# Markers that wrap each auto-generated block in README.md.
# Everything between a pair of markers gets replaced on each run.
TECHNIQUE_START = "<!-- TECHNIQUE_CHART_START -->"
TECHNIQUE_END = "<!-- TECHNIQUE_CHART_END -->"

ID_LIST_START = "<!-- ID_LIST_START -->"
ID_LIST_END = "<!-- ID_LIST_END -->"

# ---------------------------------------------------------------------------
# Detection rules, in priority order.
#
# A single query can match several categories (e.g. a query with both a
# JOIN and a window function). Priority order decides which one "wins"
# as that file's primary/dominant technique -- roughly most-advanced or
# most-defining construct first. This mirrors how you'd naturally
# describe the query's main idea if asked "what's this solution about?"
# ---------------------------------------------------------------------------
RULES = [
    ("Window functions (RANK/DENSE_RANK/ROW_NUMBER/LAG/LEAD)",
     re.compile(r"\b(over\s*\(|dense_rank\s*\(|row_number\s*\(|rank\s*\(|lag\s*\(|lead\s*\()", re.I)),

    ("CTE (WITH ... AS)",
     re.compile(r"^\s*with\b", re.I | re.M)),

    ("Subqueries (EXISTS / correlated)",
     re.compile(r"\b(not\s+exists|exists\s*\(|in\s*\(\s*select)", re.I)),

    ("JOIN (LEFT/CROSS/self-join/USING)",
     re.compile(r"\b(left\s+join|cross\s+join|inner\s+join|join\b|delete\s+from\s+\w+\s+\w*\s*using)", re.I)),

    ("CASE WHEN", re.compile(r"\bcase\s+when\b", re.I)),

    ("GROUP BY / HAVING", re.compile(r"\bgroup\s+by\b", re.I)),

    ("Regex / pattern matching (~, SIMILAR TO, REGEXP)",
     re.compile(r"(~\s*'|~\*|similar\s+to|regexp_like|regexp_matches|regexp_replace)", re.I)),

    ("Other (COALESCE/IFNULL, UNION, string functions, etc.)",
     re.compile(r"\b(coalesce|ifnull|union|char_length|to_char|substring|split_part)\b", re.I)),
]

FALLBACK_LABEL = "Other (COALESCE/IFNULL, UNION, string functions, etc.)"


def classify(sql_text: str) -> str:
    """Return the highest-priority matching technique label for a query."""
    for label, pattern in RULES:
        if pattern.search(sql_text):
            return label
    return FALLBACK_LABEL


def strip_sql_comments(sql_text: str) -> str:
    """Remove -- line comments and /* */ block comments before matching,
    so commented-out alternate solutions don't skew detection."""
    sql_text = re.sub(r"/\*.*?\*/", "", sql_text, flags=re.S)
    sql_text = re.sub(r"--.*", "", sql_text)
    return sql_text


def collect_counts_and_ids():
    """Returns (Counter of label -> count, dict of label -> sorted list of
    problem IDs). One pass over Problems/, so classification and ID
    extraction always stay in sync with each other."""
    counts = Counter()
    ids_by_label: dict[str, list[int]] = {}

    if not PROBLEMS_DIR.exists():
        print(f"error: {PROBLEMS_DIR} not found", file=sys.stderr)
        sys.exit(1)

    sql_files = sorted(PROBLEMS_DIR.glob("*.sql"))
    if not sql_files:
        print(f"error: no .sql files found in {PROBLEMS_DIR}", file=sys.stderr)
        sys.exit(1)

    for path in sql_files:
        raw = path.read_text(encoding="utf-8")
        active_sql = strip_sql_comments(raw)
        # If stripping comments removed everything (e.g. a fully
        # commented-out draft), fall back to the raw text so the file
        # still gets classified instead of silently skipped.
        label = classify(active_sql if active_sql.strip() else raw)
        counts[label] += 1

        match = PROBLEM_ID_RE.match(path.stem)
        if match:
            ids_by_label.setdefault(label, []).append(int(match.group(1)))
        else:
            # Filename doesn't start with a number -- still counted
            # above, just has no ID to list here.
            ids_by_label.setdefault(label, [])

    for label in ids_by_label:
        ids_by_label[label].sort()

    return counts, ids_by_label


# Matches the leading problem number in a filename, e.g. "1084" from
# "1084_sales_analysis_III.sql". Filenames that don't start with digits
# are skipped for ID-listing purposes (still counted in the technique tally).
PROBLEM_ID_RE = re.compile(r"^(\d+)_")


def render_id_list_block(ids_by_label: dict, technique_order: list) -> str:
    """Renders one bullet per technique, each showing its problem count
    and the exact LeetCode IDs classified under it -- in the same
    most-common-first order as the pie chart, so the two sections read
    together consistently."""
    total = sum(len(ids) for ids in ids_by_label.values())
    lines = [ID_LIST_START, "", "## Problems by Technique", ""]
    lines.append(
        f"Which exact problem IDs were classified under each technique above "
        f"({total} files). Also auto-generated by "
        f"`python3 scripts/generate_readme_chart.py`."
    )
    lines.append("")
    for label in technique_order:
        ids = ids_by_label.get(label, [])
        if not ids:
            continue
        id_list = ", ".join(str(i) for i in ids)
        lines.append(f"- **{label}** [{len(ids)}]: {id_list}")
    lines.append("")
    lines.append(ID_LIST_END)
    return "\n".join(lines)


def render_mermaid_block(start_marker, end_marker, heading, intro, chart_title, items) -> str:
    """items: iterable of (label, count) pairs, already in the order
    they should appear in the legend/slices."""
    total = sum(count for _, count in items)
    lines = [start_marker, "", heading, "", intro.format(total=total), "", "```mermaid", "pie showData",
             f"    title {chart_title.format(total=total)}"]
    for label, count in items:
        lines.append(f'    "{label}" : {count}')
    lines.append("```")
    lines.append("")
    lines.append(end_marker)
    return "\n".join(lines)


def update_block(content: str, start_marker: str, end_marker: str, new_block: str, anchor_heading: str = None) -> str:
    if start_marker in content and end_marker in content:
        pattern = re.compile(re.escape(start_marker) + r".*?" + re.escape(end_marker), re.S)
        return pattern.sub(new_block, content)

    # First run for this block: no markers yet. Insert right before the
    # given anchor heading if it exists, otherwise append at the end.
    if anchor_heading and anchor_heading in content:
        return content.replace(anchor_heading, new_block + "\n\n" + anchor_heading, 1)
    return content.rstrip() + "\n\n" + new_block + "\n"


def main() -> None:
    technique_counts, ids_by_label = collect_counts_and_ids()
    technique_order = [label for label, _ in technique_counts.most_common()]

    technique_block = render_mermaid_block(
        TECHNIQUE_START, TECHNIQUE_END,
        heading="## Technique Breakdown",
        intro=(
            "Primary technique per solution, auto-detected from the query text in "
            "`Problems/*.sql` ({total} files). Regenerate with "
            "`python3 scripts/generate_readme_chart.py` after adding or editing a solution."
        ),
        chart_title="Techniques used across {total} solutions",
        items=technique_counts.most_common(),
    )

    id_list_block = render_id_list_block(ids_by_label, technique_order)

    if not README_PATH.exists():
        print(f"error: {README_PATH} not found", file=sys.stderr)
        sys.exit(1)

    content = README_PATH.read_text(encoding="utf-8")
    content = update_block(content, TECHNIQUE_START, TECHNIQUE_END, technique_block, anchor_heading="## Notes")
    content = update_block(content, ID_LIST_START, ID_LIST_END, id_list_block, anchor_heading="## Notes")
    README_PATH.write_text(content, encoding="utf-8")

    print("Technique breakdown updated:")
    total = sum(technique_counts.values())
    for label, count in technique_counts.most_common():
        pct = round(count / total * 100)
        print(f"  {count:>3} ({pct:>3}%)  {label}")

    print("\nProblem IDs per technique:")
    for label in technique_order:
        ids = ids_by_label.get(label, [])
        print(f"  {label}: {ids}")


if __name__ == "__main__":
    main()