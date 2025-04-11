
#To extract error:
  awk '/ERROR/ {print toupper(substr($0, index($0, "ERROR")))}' system.log
# 1.	-F',' → Specifies comma as the field separator.
#	2.	$3 == "Engineering" → Filters lines where the third column (Department) is “Engineering”.
#	3.	print $2 → Extracts the second column (Name).
#	4.	sort → Sorts the names alphabetically.

#By using the grep and tr
  grep 'ERROR' system.log | sed 's/.*ERROR: /ISSUE:WQ: /' | tr '[:lower:]' '[:upper:]'
# 1.	grep 'ERROR' system.log' → Selects lines with "ERROR".
#	2.	sed 's/.*ERROR: /ERROR: /' → Removes everything before "ERROR: ".
#	3.	tr '[:lower:]' '[:upper:]' → Converts to uppercase.
