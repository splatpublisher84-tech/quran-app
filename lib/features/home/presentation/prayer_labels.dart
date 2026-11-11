import '../../../i18n/strings.g.dart';
import '../domain/prayer_math.dart';

const Map<PrayerId, String> prayerArabic = {
  PrayerId.fajr: 'الفجر',
  PrayerId.dhuhr: 'الظهر',
  PrayerId.asr: 'العصر',
  PrayerId.maghrib: 'المغرب',
  PrayerId.isha: 'العشاء',
};

String prayerLabel(Translations t, PrayerId id, {required bool jumuah}) {
  if (jumuah && id == PrayerId.dhuhr) return t.home.jumuah;
  return switch (id) {
    PrayerId.fajr => t.home.fajr,
    PrayerId.dhuhr => t.home.dhuhr,
    PrayerId.asr => t.home.asr,
    PrayerId.maghrib => t.home.maghrib,
    PrayerId.isha => t.home.isha,
  };
}

String formatDuration(Translations t, int minutes) {
  final safe = minutes < 0 ? 0 : minutes;
  final hours = safe ~/ 60;
  final mins = safe % 60;
  if (hours == 0) return t.home.minutes(n: mins);
  if (mins == 0) return t.home.hours(n: hours);
  return t.home.hoursMinutes(h: hours, m: mins);
}

String formatCivilDate(Translations t, DateTime date) {
  const weekdays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
  final weekday = switch (weekdays[date.weekday - 1]) {
    'mon' => t.home.mon,
    'tue' => t.home.tue,
    'wed' => t.home.wed,
    'thu' => t.home.thu,
    'fri' => t.home.fri,
    'sat' => t.home.sat,
    'sun' => t.home.sun,
    _ => t.home.mon,
  };
  final month = switch (date.month) {
    1 => t.home.month1,
    2 => t.home.month2,
    3 => t.home.month3,
    4 => t.home.month4,
    5 => t.home.month5,
    6 => t.home.month6,
    7 => t.home.month7,
    8 => t.home.month8,
    9 => t.home.month9,
    10 => t.home.month10,
    11 => t.home.month11,
    _ => t.home.month12,
  };
  return '$weekday, ${date.day} $month';
}

String formatHijri(Translations t, int month, int day) {
  final name = switch (month) {
    1 => t.home.muharram,
    2 => t.home.safar,
    3 => t.home.rabiAwwal,
    4 => t.home.rabiThani,
    5 => t.home.jumadaUla,
    6 => t.home.jumadaThani,
    7 => t.home.rajab,
    8 => t.home.shaban,
    9 => t.home.ramadan,
    10 => t.home.shawwal,
    11 => t.home.dhulQadah,
    _ => t.home.dhulHijjah,
  };
  return '$day $name';
}
