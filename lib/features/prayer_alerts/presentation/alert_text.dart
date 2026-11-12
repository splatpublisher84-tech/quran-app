import '../../../i18n/strings.g.dart';
import '../../home/domain/prayer_math.dart';
import '../domain/alert_settings.dart';
import '../domain/plan_alerts.dart';

AlertText describeAlert(PlannedAlert alert, Translations t) {
  final name = _name(t, alert);
  final (title, body, channel) = switch (alert.kind) {
    AlertKind.salah => (
      name,
      t.alerts.itsTime(name: name),
      _salahChannel(t, alert),
    ),
    AlertKind.dailyAyah => (
      t.alerts.dailyTitle,
      t.alerts.dailyBody,
      t.alerts.channelDaily,
    ),
    AlertKind.suhoor => (
      t.alerts.suhoorTitle,
      t.alerts.suhoorBody,
      t.alerts.channelSuhoor,
    ),
    AlertKind.iftar => (
      t.alerts.iftarTitle,
      t.alerts.iftarBody,
      t.alerts.channelIftar,
    ),
    AlertKind.jumuah => (
      t.alerts.jumuahTitle,
      t.alerts.jumuahBody,
      t.alerts.channelJumuah,
    ),
  };
  return AlertText(title: title, body: body, channelName: channel);
}

String _salahChannel(Translations t, PlannedAlert alert) {
  if (alert.mode == AlertMode.adhan && alert.voice != null) {
    return '${t.alerts.channelAdhan}, ${voiceLabel(t, alert.voice!)}';
  }
  return t.alerts.channelSalah;
}

String voiceLabel(Translations t, AdhanVoice voice) => switch (voice) {
  AdhanVoice.makkah => t.alerts.makkah,
  AdhanVoice.madinah => t.alerts.madinah,
  AdhanVoice.alAqsa => t.alerts.alAqsa,
};

String modeLabel(Translations t, AlertMode mode) => switch (mode) {
  AlertMode.adhan => t.alerts.adhan,
  AlertMode.notify => t.alerts.notify,
  AlertMode.off => t.alerts.off,
};

String modeHelp(Translations t, AlertMode mode) => switch (mode) {
  AlertMode.adhan => t.alerts.adhanHelp,
  AlertMode.notify => t.alerts.notifyHelp,
  AlertMode.off => t.alerts.offHelp,
};

String leadLabel(Translations t, int minutesBefore) {
  if (minutesBefore == 0) return t.alerts.leadOnTime;
  return t.alerts.leadMinutes(n: minutesBefore);
}

String _name(Translations t, PlannedAlert alert) {
  final prayer = alert.prayer;
  if (prayer == null) return t.alerts.title;
  final jumuah =
      prayer == PrayerId.dhuhr && alert.when.weekday == DateTime.friday;
  if (jumuah) return t.home.jumuah;
  return switch (prayer) {
    PrayerId.fajr => t.home.fajr,
    PrayerId.dhuhr => t.home.dhuhr,
    PrayerId.asr => t.home.asr,
    PrayerId.maghrib => t.home.maghrib,
    PrayerId.isha => t.home.isha,
  };
}
