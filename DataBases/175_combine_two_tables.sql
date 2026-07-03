select p.firstName as firstName, p.lastName as lastName, a.city, a.state
from person p
left join address a on p.personId = a.personId

/*
I used left join cause of question want this from us : "If the address of a personId is not present in the Address table, report null instead."
LEFT JOIN keeps every row from the left table (person) regardless of match, and fills unmatched right-table (address) columns with NULL, that's why i used it.
*/