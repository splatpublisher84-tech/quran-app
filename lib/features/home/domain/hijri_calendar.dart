import 'umm_al_qura_data.dart';

/// A Hijri date. [month] is 1 (Muharram) through 12 (Dhul Hijjah).
class HijriDate {
  const HijriDate({required this.year, required this.month, required this.day});

  final int year;
  final int month;
  final int day;

  bool get isRamadan => month == 9;

  bool get isEidAlFitr => month == 10 && day == 1;

  bool get isEidAlAdha => month == 12 && day == 10;

  @override
  bool operator ==(Object other) =>
      other is HijriDate &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() => '$year-$month-$day';
}

/// Umm al-Qura date for a civil [year]/[month]/[day].
///
/// Inside Muharram 1356 through Dhul Hijjah 1500 this is the Saudi tabular
/// calendar. Outside that range it falls back to the 30-year arithmetic
/// calendar so a date is always defined.
HijriDate hijriFromCivil(int year, int month, int day) {
  return hijriFromJdn(_gregorianToJdn(year, month, day));
}

HijriDate hijriFromJdn(int jdn) {
  final mjdn = jdn - 2400000;
  final cumulative = _cumulative;
  if (mjdn < cumulative.first || mjdn >= cumulative.last) {
    return _arithmeticFromJdn(jdn);
  }
  var index = 1;
  while (index < cumulative.length && cumulative[index] <= mjdn) {
    index++;
  }
  final totalMonths = index + 16260;
  final cycles = (totalMonths - 1) ~/ 12;
  final hy = cycles + 1;
  final hm = totalMonths - 12 * cycles;
  final hd = mjdn - cumulative[index - 1] + 1;
  return HijriDate(year: hy, month: hm, day: hd);
}

int hijriToJdn(HijriDate date) {
  if (date.year < ummAlQuraStartYear ||
      date.year >
          ummAlQuraStartYear + (ummAlQuraMonthLengths.length ~/ 12) - 1) {
    return _arithmeticToJdn(date);
  }
  final index = (date.year - 1) * 12 + date.month - 16260;
  final mjdn = date.day + _cumulative[index - 1] - 1;
  return mjdn + 2400000;
}

HijriDate shiftHijri(HijriDate date, int days) {
  if (days == 0) return date;
  return hijriFromJdn(hijriToJdn(date) + days);
}

/// The Islamic day changes at Maghrib. [adjustment] is the user offset of
/// -1, 0 or 1 day, applied after that rollover.
HijriDate displayedHijri({
  required DateTime civil,
  required int minuteOfDay,
  required int maghribMinute,
  required int adjustment,
}) {
  final base = hijriFromCivil(civil.year, civil.month, civil.day);
  final delta = adjustment + (minuteOfDay >= maghribMinute ? 1 : 0);
  return shiftHijri(base, delta);
}

int _gregorianToJdn(int year, int month, int day) {
  var d =
      _div((year + _div(month - 8, 6) + 100100) * 1461, 4) +
      _div(153 * _mod(month + 9, 12) + 2, 5) +
      day -
      34840408;
  d = d - _div(_div(year + 100100 + _div(month - 8, 6), 100) * 3, 4) + 752;
  return d;
}

/// JS `~~` division for the positive numbers this calendar uses.
int _div(int a, int b) => a ~/ b;

int _mod(int a, int b) => a - _div(a, b) * b;

List<int>? _cumulativeCache;

List<int> get _cumulative {
  final cached = _cumulativeCache;
  if (cached != null) return cached;
  final values = List<int>.filled(ummAlQuraMonthLengths.length + 1, 0);
  var sum = ummAlQuraEpochMjdn;
  values[0] = sum;
  for (var i = 0; i < ummAlQuraMonthLengths.length; i++) {
    sum += ummAlQuraMonthLengths[i];
    values[i + 1] = sum;
  }
  return _cumulativeCache = values;
}

/// Arithmetic (tabular) Hijri, used only outside the Umm al-Qura table.
/// Epoch: civil 16 July 622 is 1 Muharram 1.
HijriDate _arithmeticFromJdn(int jdn) {
  final days = jdn - 1948440 + 10632;
  final year = _div(days * 30, 10631);
  // Walk months of the 30-year cycle from a nearby year start.
  final start = _arithmeticToJdn(HijriDate(year: year, month: 1, day: 1));
  var cursor = start;
  var y = year;
  var m = 1;
  while (jdn >= cursor + _arithmeticMonthLength(y, m)) {
    cursor += _arithmeticMonthLength(y, m);
    m++;
    if (m > 12) {
      m = 1;
      y++;
    }
  }
  return HijriDate(year: y, month: m, day: jdn - cursor + 1);
}

int _arithmeticToJdn(HijriDate date) {
  // 1 Muharram 1 AH = JDN 1948440.
  var jdn = 1948439;
  for (var y = 1; y < date.year; y++) {
    jdn += _arithmeticLeap(y) ? 355 : 354;
  }
  for (var m = 1; m < date.month; m++) {
    jdn += _arithmeticMonthLength(date.year, m);
  }
  return jdn + date.day;
}

bool _arithmeticLeap(int year) {
  const leaps = {2, 5, 7, 10, 13, 16, 18, 21, 24, 26, 29};
  return leaps.contains(year % 30);
}

int _arithmeticMonthLength(int year, int month) {
  if (month.isOdd) return 30;
  if (month == 12 && _arithmeticLeap(year)) return 30;
  return 29;
}
