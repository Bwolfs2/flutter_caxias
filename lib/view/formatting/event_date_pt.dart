/// Short Portuguese day + month label (e.g. `10 MAI`) for event chips.
String formatEventDayMonthPt(DateTime utcDate) {
  const List<String> months = <String>[
    'JAN',
    'FEV',
    'MAR',
    'ABR',
    'MAI',
    'JUN',
    'JUL',
    'AGO',
    'SET',
    'OUT',
    'NOV',
    'DEZ',
  ];
  final DateTime local = utcDate.toLocal();
  return '${local.day} ${months[local.month - 1]}';
}

/// Month abbreviation + day number for the circular date badge on event cards.
({String monthAbbrev, String dayText}) eventDateBadgeParts(DateTime utcDate) {
  const List<String> months = <String>[
    'JAN',
    'FEV',
    'MAR',
    'ABR',
    'MAI',
    'JUN',
    'JUL',
    'AGO',
    'SET',
    'OUT',
    'NOV',
    'DEZ',
  ];
  final DateTime local = utcDate.toLocal();
  return (
    monthAbbrev: months[local.month - 1],
    dayText: '${local.day}',
  );
}
