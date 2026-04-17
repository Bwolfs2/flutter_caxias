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
