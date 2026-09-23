String shortDate(DateTime d) => '${d.month}/${d.day}';
int tripDays(DateTime s, DateTime e) => e.difference(s).inDays + 1;
