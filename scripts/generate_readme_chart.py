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

# Markers that wrap the auto-generated block in README.md.
# Everything between these two lines gets replaced on each run.
START_MARKER = "<!-- TECHNIQUE_CHART_START -->"
END_MARKER = "<!-- TECHNIQUE_CHART_END -->"

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


def collect_counts() -> Counter:
    counts = Counter()
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

    return counts


def render_mermaid_block(counts: Counter) -> str:
    total = sum(counts.values())
    lines = [START_MARKER, "", "## Technique Breakdown", ""]
    lines.append(
        f"Primary technique per solution, auto-detected from the query text "
        f"in `Problems/*.sql` ({total} files). Regenerate with "
        f"`python3 scripts/generate_readme_chart.py` after adding or editing a solution."
    )
    lines.append("")
    lines.append("```mermaid")
    lines.append("pie showData")
    lines.append(f"    title Techniques used across {total} solutions")
    for label, count in counts.most_common():
        lines.append(f'    "{label}" : {count}')
    lines.append("```")
    lines.append("")
    lines.append(END_MARKER)
    return "\n".join(lines)


def update_readme(new_block: str) -> None:
    if not README_PATH.exists():
        print(f"error: {README_PATH} not found", file=sys.stderr)
        sys.exit(1)

    content = README_PATH.read_text(encoding="utf-8")

    if START_MARKER in content and END_MARKER in content:
        pattern = re.compile(
            re.escape(START_MARKER) + r".*?" + re.escape(END_MARKER),
            re.S,
        )
        content = pattern.sub(new_block, content)
    else:
        # First run: no markers yet. Insert the block right before
        # "## Notes" if that section exists, otherwise append at the end.
        if "## Notes" in content:
            content = content.replace("## Notes", new_block + "\n\n## Notes", 1)
        else:
            content = content.rstrip() + "\n\n" + new_block + "\n"

    README_PATH.write_text(content, encoding="utf-8")


def main() -> None:
    counts = collect_counts()
    block = render_mermaid_block(counts)
    update_readme(block)

    print("Technique breakdown updated:")
    total = sum(counts.values())
    for label, count in counts.most_common():
        pct = round(count / total * 100)
        print(f"  {count:>3} ({pct:>3}%)  {label}")


if __name__ == "__main__":
    main()