import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/features/home/domain/prayer_math.dart';
import 'package:quran_app/features/prayer_alerts/domain/alert_codec.dart';
import 'package:quran_app/features/prayer_alerts/domain/alert_settings.dart';
import 'package:quran_app/features/prayer_alerts/domain/plan_alerts.dart';
import 'package:quran_app/features/prayer_alerts/domain/voice_catalog.dart';

DayTimes _times({int? imsak}) => DayTimes(
  fajr: parseClock('04:22'),
  sunrise: parseClock('05:39'),
  dhuhr: parseClock('11:30'),
  asr: parseClock('14:50'),
  maghrib: parseClock('17:22'),
  isha: parseClock('18:35'),
  imsak: imsak,
);

AlertDay _day(DateTime date, {bool ramadan = false}) => AlertDay(
  date: date,
  times: _times(imsak: ramadan ? parseClock('04:12') : null),
  ramadan: ramadan,
);

void main() {
  final tuesday = DateTime(2026, 10, 27);
  final wednesday = DateTime(2026, 10, 28);
  final now = DateTime(2026, 10, 27, 10);

  List<PlannedAlert> plan({
    PrayerAlertSettings settings = const PrayerAlertSettings(),
    bool granted = true,
    DateTime? at,
    List<AlertDay>? days,
    int? maxPending,
    bool soundsBundled = false,
  }) {
    return planAlerts(
      now: at ?? now,
      days: days ?? [_day(tuesday), _day(wednesday)],
      settings: settings,
      notificationsGranted: granted,
      maxPending: maxPending ?? maxPendingAlerts,
      soundsBundled: soundsBundled,
    );
  }

  test('adhan uses the voice channel and skips prayers already passed', () {
    final planned = plan();
    final todayFajr = planned.where(
      (alert) => alert.prayer == PrayerId.fajr && alert.when.day == 27,
    );
    final todayDhuhr = planned.firstWhere(
      (alert) => alert.prayer == PrayerId.dhuhr && alert.when.day == 27,
    );
    expect(todayFajr, isEmpty);
    expect(todayDhuhr.channelId, 'adhan_makkah_v1');
    expect(todayDhuhr.soundResource, isNull);
    expect(todayDhuhr.when, DateTime(2026, 10, 27, 11, 30));
  });

  test('notify and off map to their own channels', () {
    final planned = plan(
      settings: const PrayerAlertSettings(
        fajr: AlertMode.notify,
        dhuhr: AlertMode.off,
        voice: AdhanVoice.madinah,
      ),
      at: DateTime(2026, 10, 27, 3),
    );
    final fajr = planned.firstWhere((alert) => alert.prayer == PrayerId.fajr);
    expect(fajr.channelId, AdhanVoiceCatalog.notifyChannelId);
    expect(planned.where((alert) => alert.prayer == PrayerId.dhuhr), isEmpty);
    final asr = planned.firstWhere((alert) => alert.prayer == PrayerId.asr);
    expect(asr.channelId, 'adhan_madinah_v1');
  });

  test('a bundled clip names the raw resource', () {
    final planned = plan(soundsBundled: true);
    final dhuhr = planned.firstWhere((alert) => alert.prayer == PrayerId.dhuhr);
    expect(dhuhr.soundResource, 'adhan_makkah');
  });

  test('offset, pause, disabled and denied produce the right set', () {
    final shifted = plan(
      settings: const PrayerAlertSettings().withOffset(PrayerId.dhuhr, -10),
    );
    expect(
      shifted.firstWhere((alert) => alert.prayer == PrayerId.dhuhr).when,
      DateTime(2026, 10, 27, 11, 20),
    );
    final late = plan(
      settings: const PrayerAlertSettings().withOffset(PrayerId.dhuhr, 10),
    );
    expect(
      late.firstWhere((alert) => alert.prayer == PrayerId.dhuhr).when,
      DateTime(2026, 10, 27, 11, 30),
    );
    expect(
      plan(settings: const PrayerAlertSettings(promptsPaused: true)),
      isEmpty,
    );
    expect(plan(settings: const PrayerAlertSettings(enabled: false)), isEmpty);
    expect(plan(granted: false), isEmpty);
  });

  test('the cap keeps the soonest alerts', () {
    final planned = plan(maxPending: 1);
    expect(planned, hasLength(1));
    expect(planned.single.when, DateTime(2026, 10, 27, 11, 30));
  });

  test('ramadan adds suhoor and iftar, Friday adds the early jumuah', () {
    final friday = DateTime(2026, 10, 30);
    final planned = plan(
      at: DateTime(2026, 10, 30, 3),
      settings: const PrayerAlertSettings(jumuahEarly: true),
      days: [_day(friday, ramadan: true)],
    );
    expect(
      planned.where((alert) => alert.kind == AlertKind.suhoor).single.when,
      DateTime(2026, 10, 30, 4, 12),
    );
    expect(
      planned.where((alert) => alert.kind == AlertKind.iftar).single.when,
      DateTime(2026, 10, 30, 17, 22),
    );
    expect(
      planned.where((alert) => alert.kind == AlertKind.jumuah).single.when,
      DateTime(2026, 10, 30, 11),
    );
    expect(
      planned.where((alert) => alert.kind == AlertKind.jumuah).single.channelId,
      AdhanVoiceCatalog.jumuahChannelId,
    );
  });

  test('a saved offset snaps to a lead mark', () {
    expect(clampAlertOffset(12), 0);
    expect(clampAlertOffset(-7), -5);
    expect(clampAlertOffset(-30), -30);
    expect(clampAlertOffset(-40), -30);
  });

  test('settings round trip through the preference encoding', () {
    const original = PrayerAlertSettings(
      fajr: AlertMode.notify,
      asrOffset: -5,
      voice: AdhanVoice.alAqsa,
      jumuahEarly: true,
      enabled: false,
      dailyAyahSlot: DailyAyahSlot.afterMaghrib,
    );
    final encoded = encodeAlertSettings(original);
    final decoded = decodeAlertSettings(encoded);
    expect(decoded.fajr, AlertMode.notify);
    expect(decoded.asrOffset, -5);
    expect(decoded.voice, AdhanVoice.alAqsa);
    expect(decoded.jumuahEarly, isTrue);
    expect(decoded.enabled, isFalse);
    expect(decoded.dailyAyahSlot, DailyAyahSlot.afterMaghrib);
  });
}
