[2025-03-27 10:15:32] ERROR: Disk space low
[2025-03-27 10:16:45] INFO: User logged in
[2025-03-27 10:17:10] WARNING: High memory usage detected
[2025-03-27 10:18:20] ERROR: Network unreachable
[2025-03-27 10:19:05] INFO: Scheduled job started
[2025-03-27 10:20:30] WARNING: CPU temperature high
[2025-03-27 10:21:15] ERROR: Failed to start service


To extract error:
  awk '/ERROR/ {print toupper(substr($0, index($0, "ERROR")))}' system.log
# 1.	-F',' → Specifies comma as the field separator.
#	2.	$3 == "Engineering" → Filters lines where the third column (Department) is “Engineering”.
#	3.	print $2 → Extracts the second column (Name).
#	4.	sort → Sorts the names alphabetically.

By using the grep and tr
  grep 'ERROR' system.log | sed 's/.*ERROR: /ERROR: /' | tr '[:lower:]' '[:upper:]'
# 1.	grep 'ERROR' system.log' → Selects lines with "ERROR".
#	2.	sed 's/.*ERROR: /ERROR: /' → Removes everything before "ERROR: ".
#	3.	tr '[:lower:]' '[:upper:]' → Converts to uppercase.

Output
  ERROR: DISK SPACE LOW
  ERROR: NETWORK UNREACHABLE
  ERROR: FAILED TO START SERVICE
