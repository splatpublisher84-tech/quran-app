///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsId with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsId({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.id,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <id>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key);

	late final TranslationsId _root = this; // ignore: unused_field

	@override 
	TranslationsId $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsId(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$tabs$id tabs = _Translations$tabs$id._(_root);
	@override late final _Translations$common$id common = _Translations$common$id._(_root);
	@override late final _Translations$onboarding$id onboarding = _Translations$onboarding$id._(_root);
	@override late final _Translations$quran$id quran = _Translations$quran$id._(_root);
	@override late final _Translations$home$id home = _Translations$home$id._(_root);
	@override late final _Translations$alerts$id alerts = _Translations$alerts$id._(_root);
}

// Path: tabs
class _Translations$tabs$id implements Translations$tabs$en {
	_Translations$tabs$id._(this._root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get home => 'Beranda';
	@override String get quran => 'Al-Qur\'an';
	@override String get ayahOfDay => 'Ayat hari ini';
	@override String get settings => 'Pengaturan';
}

// Path: common
class _Translations$common$id implements Translations$common$en {
	_Translations$common$id._(this._root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get comingSoon => 'Layar ini akan hadir pada tahap berikutnya.';
	@override String get retry => 'Coba lagi';
	@override String get cancel => 'Batal';
	@override String get confirm => 'Konfirmasi';
	@override String get close => 'Tutup';
	@override String get back => 'Kembali';
}

// Path: onboarding
class _Translations$onboarding$id implements Translations$onboarding$en {
	_Translations$onboarding$id._(this._root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Waktu salat, Al-Qur\'an, dan tiga ayat setiap hari';
	@override String get quiet => 'Tenang sejak awal. Tanpa iklan saat salat atau saat membaca.';
	@override String get start => 'Mulai';
	@override String get locationTitle => 'Waktu salat untuk tempat Anda';
	@override String get locationBody => 'Lokasi tetap di perangkat ini. Aplikasi hanya memakainya untuk menghitung waktu salat.';
	@override String get useLocation => 'Gunakan lokasi saya';
	@override String get notNow => 'Nanti saja';
	@override String get alertsTitle => 'Jangan lewatkan waktu salat';
	@override String get alertsBody => 'Pengingat singkat di setiap waktu salat. Anda bisa mengubahnya di Pengaturan.';
	@override String get turnOnAlerts => 'Nyalakan pengingat salat';
	@override String get bismillah => 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
}

// Path: quran
class _Translations$quran$id implements Translations$quran$en {
	_Translations$quran$id._(this._root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Al-Qur\'an';
	@override String get searchHint => 'Nama surah atau 2:255';
	@override String get search => 'Cari';
	@override String get clear => 'Hapus';
	@override String get surah => 'Surah';
	@override String get juz => 'Juz';
	@override String get saved => 'Tersimpan';
	@override String get continueReading => 'Lanjut membaca';
	@override String goTo({required Object ref}) => 'Buka ${ref}';
	@override String get noSurahFound => 'Surah tidak ditemukan';
	@override String get noJuzFound => 'Juz tidak ditemukan';
	@override String get noResults => 'Tidak ada hasil';
	@override String get noSaved => 'Belum ada ayat tersimpan';
	@override String get noSavedHint => 'Ketuk ayat saat membaca, lalu Simpan.';
	@override String get loadError => 'Al-Qur\'an tidak dapat dimuat.';
	@override String ayahCount({required Object n}) => '${n} ayat';
	@override String juzTitle({required Object n}) => 'Juz ${n}';
	@override String get save => 'Simpan';
	@override String get share => 'Bagikan';
	@override String get shareLater => 'Berbagi akan hadir pada pembaruan berikutnya.';
	@override String get translationLanguage => 'Bahasa terjemahan';
	@override String get textSize => 'Ukuran teks';
	@override String get arabicTextSize => 'Ukuran teks Arab';
	@override String get small => 'Kecil';
	@override String get medium => 'Sedang';
	@override String get large => 'Besar';
	@override String get translatorNote => 'Catatan penerjemah';
	@override String ayahLabel({required Object ref}) => 'Ayat ${ref}';
	@override String get loading => 'Memuat';
	@override String get languageEn => 'English';
	@override String get languageId => 'Indonesia';
	@override String get languageUr => 'Urdu';
	@override String get languageTr => 'Turkish';
}

// Path: home
class _Translations$home$id implements Translations$home$en {
	_Translations$home$id._(this._root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get loadError => 'Waktu salat tidak dapat dimuat.';
	@override String get itsTime => 'Sudah masuk waktu';
	@override String get stillTime => 'Masih ada waktu';
	@override String get nextPrayer => 'Salat berikutnya';
	@override String get prayed => 'Sudah salat';
	@override String get paused => 'Dijeda';
	@override String get ishaEnded => 'Waktu Isya telah berakhir';
	@override String get pray => 'Salat';
	@override String get ivePrayed => 'Saya sudah salat';
	@override String get undo => 'Urungkan';
	@override String marked({required Object name}) => '${name} ditandai sudah salat';
	@override String startedAt({required Object time}) => 'Mulai ${time}';
	@override String timeLeft({required Object duration}) => 'Sisa ${duration}';
	@override String inDuration({required Object duration}) => 'dalam ${duration}';
	@override String nextIn({required Object duration}) => 'Salat berikutnya dalam ${duration}';
	@override String get promptsPaused => 'Pengingat salat dijeda';
	@override String get suhoorEnds => 'Sahur berakhir dalam';
	@override String get finishByImsak => 'Selesaikan makan sebelum Imsak';
	@override String get fastingIftar => 'Berpuasa. Iftar dalam';
	@override String get breakAtMaghrib => 'Berbuka saat Magrib';
	@override String get nextImsak => 'Imsak berikutnya dalam';
	@override String get suhoorBeforeDawn => 'Sahur sebelum fajar';
	@override String get estimatedTimes => 'Waktu diperkirakan dari zona waktu perangkat.';
	@override String get alertsOff => 'Pengingat salat mati';
	@override String get turnOn => 'Nyalakan';
	@override String minutes({required Object n}) => '${n} mnt';
	@override String hours({required Object n}) => '${n} jam';
	@override String hoursMinutes({required Object h, required Object m}) => '${h} jam ${m} mnt';
	@override String get fajr => 'Subuh';
	@override String get dhuhr => 'Zuhur';
	@override String get asr => 'Asar';
	@override String get maghrib => 'Magrib';
	@override String get isha => 'Isya';
	@override String get jumuah => 'Jumat';
	@override String get imsak => 'Imsak';
	@override String get iftar => 'Iftar';
	@override String get sunriseEnds => 'Matahari terbit. Subuh berakhir';
	@override String get readKahf => 'Baca Surah Al-Kahf';
	@override String get fridayTradition => 'Tradisi hari Jumat';
	@override String juzToday({required Object n}) => 'Juz ${n} hari ini';
	@override String get ramadanReading => 'Satu juz sehari sepanjang bulan';
	@override String get eidMubarak => 'Eid Mubarak';
	@override String get shareEid => 'Bagikan ucapan Eid';
	@override String get allAlerts => 'Suara adzan dan semua pengingat';
	@override String get prayLater => 'Alur salat hadir pada pembaruan berikutnya.';
	@override String get alertsLater => 'Pengingat salat hadir pada pembaruan berikutnya.';
	@override String get debugClock => 'Jam debug';
	@override String get debugEarlier => 'Hari sebelumnya';
	@override String get debugLater => 'Hari berikutnya';
	@override String get debugDevice => 'Pakai waktu perangkat';
	@override String get previewLive => 'Live';
	@override String get previewFriday => 'Jumat';
	@override String get previewRamadan => 'Ramadan';
	@override String get previewEid => 'Eid';
	@override String get mon => 'Sen';
	@override String get tue => 'Sel';
	@override String get wed => 'Rab';
	@override String get thu => 'Kam';
	@override String get fri => 'Jum';
	@override String get sat => 'Sab';
	@override String get sun => 'Min';
	@override String get month1 => 'Jan';
	@override String get month2 => 'Feb';
	@override String get month3 => 'Mar';
	@override String get month4 => 'Apr';
	@override String get month5 => 'Mei';
	@override String get month6 => 'Jun';
	@override String get month7 => 'Jul';
	@override String get month8 => 'Agu';
	@override String get month9 => 'Sep';
	@override String get month10 => 'Okt';
	@override String get month11 => 'Nov';
	@override String get month12 => 'Des';
	@override String get muharram => 'Muharram';
	@override String get safar => 'Safar';
	@override String get rabiAwwal => 'Rabiul Awal';
	@override String get rabiThani => 'Rabiul Akhir';
	@override String get jumadaUla => 'Jumadil Awal';
	@override String get jumadaThani => 'Jumadil Akhir';
	@override String get rajab => 'Rajab';
	@override String get shaban => 'Syaban';
	@override String get ramadan => 'Ramadan';
	@override String get shawwal => 'Syawal';
	@override String get dhulQadah => 'Zulkaidah';
	@override String get dhulHijjah => 'Zulhijah';
}

// Path: alerts
class _Translations$alerts$id implements Translations$alerts$en {
	_Translations$alerts$id._(this._root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pengingat salat';
	@override String get offNotice => 'Notifikasi mati untuk aplikasi ini.';
	@override String get turnOn => 'Nyalakan';
	@override String get allFive => 'Kelima waktu';
	@override String get eachPrayer => 'Setiap waktu';
	@override String get voice => 'Suara adzan';
	@override String get makkah => 'Makkah';
	@override String get madinah => 'Madinah';
	@override String get alAqsa => 'Al-Aqsa';
	@override String get adhan => 'Adzan';
	@override String get notify => 'Ingatkan';
	@override String get off => 'Mati';
	@override String get adhanHelp => 'Memutar panggilan salat yang singkat';
	@override String get notifyHelp => 'Banner dengan suara singkat';
	@override String get offHelp => 'Tidak ada pengingat. Waktunya tetap tampil di sini';
	@override String get pause => 'Jeda pengingat salat';
	@override String get pauseHelp => 'Menyembunyikan Pray dan pengingat untuk sementara';
	@override String get jumuah => 'Pengingat Jumat';
	@override String get jumuahHelp => '30 menit sebelum Dzuhur pada hari Jumat';
	@override String get lead => 'Menit sebelumnya';
	@override String get leadOnTime => 'Tepat waktu';
	@override String leadMinutes({required Object n}) => '${n} mnt';
	@override String itsTime({required Object name}) => 'Waktunya ${name}';
	@override String get dailyTitle => 'Ayat hari ini';
	@override String get dailyBody => 'Tiga ayat hari ini sudah siap';
	@override String get suhoorTitle => 'Sahur';
	@override String get suhoorBody => 'Sahur segera berakhir';
	@override String get iftarTitle => 'Berbuka';
	@override String get iftarBody => 'Waktunya berbuka';
	@override String get jumuahTitle => 'Jumat';
	@override String get jumuahBody => 'Jumat 30 menit lagi';
	@override String get channelSalah => 'Pengingat salat';
	@override String get channelAdhan => 'Adzan';
	@override String get channelDaily => 'Ayat hari ini';
	@override String get channelSuhoor => 'Sahur';
	@override String get channelIftar => 'Berbuka';
	@override String get channelJumuah => 'Jumat';
}

/// The flat map containing all translations for locale <id>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsId {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'tabs.home' => 'Beranda',
			'tabs.quran' => 'Al-Qur\'an',
			'tabs.ayahOfDay' => 'Ayat hari ini',
			'tabs.settings' => 'Pengaturan',
			'common.comingSoon' => 'Layar ini akan hadir pada tahap berikutnya.',
			'common.retry' => 'Coba lagi',
			'common.cancel' => 'Batal',
			'common.confirm' => 'Konfirmasi',
			'common.close' => 'Tutup',
			'common.back' => 'Kembali',
			'onboarding.title' => 'Waktu salat, Al-Qur\'an, dan tiga ayat setiap hari',
			'onboarding.quiet' => 'Tenang sejak awal. Tanpa iklan saat salat atau saat membaca.',
			'onboarding.start' => 'Mulai',
			'onboarding.locationTitle' => 'Waktu salat untuk tempat Anda',
			'onboarding.locationBody' => 'Lokasi tetap di perangkat ini. Aplikasi hanya memakainya untuk menghitung waktu salat.',
			'onboarding.useLocation' => 'Gunakan lokasi saya',
			'onboarding.notNow' => 'Nanti saja',
			'onboarding.alertsTitle' => 'Jangan lewatkan waktu salat',
			'onboarding.alertsBody' => 'Pengingat singkat di setiap waktu salat. Anda bisa mengubahnya di Pengaturan.',
			'onboarding.turnOnAlerts' => 'Nyalakan pengingat salat',
			'onboarding.bismillah' => 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
			'quran.title' => 'Al-Qur\'an',
			'quran.searchHint' => 'Nama surah atau 2:255',
			'quran.search' => 'Cari',
			'quran.clear' => 'Hapus',
			'quran.surah' => 'Surah',
			'quran.juz' => 'Juz',
			'quran.saved' => 'Tersimpan',
			'quran.continueReading' => 'Lanjut membaca',
			'quran.goTo' => ({required Object ref}) => 'Buka ${ref}',
			'quran.noSurahFound' => 'Surah tidak ditemukan',
			'quran.noJuzFound' => 'Juz tidak ditemukan',
			'quran.noResults' => 'Tidak ada hasil',
			'quran.noSaved' => 'Belum ada ayat tersimpan',
			'quran.noSavedHint' => 'Ketuk ayat saat membaca, lalu Simpan.',
			'quran.loadError' => 'Al-Qur\'an tidak dapat dimuat.',
			'quran.ayahCount' => ({required Object n}) => '${n} ayat',
			'quran.juzTitle' => ({required Object n}) => 'Juz ${n}',
			'quran.save' => 'Simpan',
			'quran.share' => 'Bagikan',
			'quran.shareLater' => 'Berbagi akan hadir pada pembaruan berikutnya.',
			'quran.translationLanguage' => 'Bahasa terjemahan',
			'quran.textSize' => 'Ukuran teks',
			'quran.arabicTextSize' => 'Ukuran teks Arab',
			'quran.small' => 'Kecil',
			'quran.medium' => 'Sedang',
			'quran.large' => 'Besar',
			'quran.translatorNote' => 'Catatan penerjemah',
			'quran.ayahLabel' => ({required Object ref}) => 'Ayat ${ref}',
			'quran.loading' => 'Memuat',
			'quran.languageEn' => 'English',
			'quran.languageId' => 'Indonesia',
			'quran.languageUr' => 'Urdu',
			'quran.languageTr' => 'Turkish',
			'home.loadError' => 'Waktu salat tidak dapat dimuat.',
			'home.itsTime' => 'Sudah masuk waktu',
			'home.stillTime' => 'Masih ada waktu',
			'home.nextPrayer' => 'Salat berikutnya',
			'home.prayed' => 'Sudah salat',
			'home.paused' => 'Dijeda',
			'home.ishaEnded' => 'Waktu Isya telah berakhir',
			'home.pray' => 'Salat',
			'home.ivePrayed' => 'Saya sudah salat',
			'home.undo' => 'Urungkan',
			'home.marked' => ({required Object name}) => '${name} ditandai sudah salat',
			'home.startedAt' => ({required Object time}) => 'Mulai ${time}',
			'home.timeLeft' => ({required Object duration}) => 'Sisa ${duration}',
			'home.inDuration' => ({required Object duration}) => 'dalam ${duration}',
			'home.nextIn' => ({required Object duration}) => 'Salat berikutnya dalam ${duration}',
			'home.promptsPaused' => 'Pengingat salat dijeda',
			'home.suhoorEnds' => 'Sahur berakhir dalam',
			'home.finishByImsak' => 'Selesaikan makan sebelum Imsak',
			'home.fastingIftar' => 'Berpuasa. Iftar dalam',
			'home.breakAtMaghrib' => 'Berbuka saat Magrib',
			'home.nextImsak' => 'Imsak berikutnya dalam',
			'home.suhoorBeforeDawn' => 'Sahur sebelum fajar',
			'home.estimatedTimes' => 'Waktu diperkirakan dari zona waktu perangkat.',
			'home.alertsOff' => 'Pengingat salat mati',
			'home.turnOn' => 'Nyalakan',
			'home.minutes' => ({required Object n}) => '${n} mnt',
			'home.hours' => ({required Object n}) => '${n} jam',
			'home.hoursMinutes' => ({required Object h, required Object m}) => '${h} jam ${m} mnt',
			'home.fajr' => 'Subuh',
			'home.dhuhr' => 'Zuhur',
			'home.asr' => 'Asar',
			'home.maghrib' => 'Magrib',
			'home.isha' => 'Isya',
			'home.jumuah' => 'Jumat',
			'home.imsak' => 'Imsak',
			'home.iftar' => 'Iftar',
			'home.sunriseEnds' => 'Matahari terbit. Subuh berakhir',
			'home.readKahf' => 'Baca Surah Al-Kahf',
			'home.fridayTradition' => 'Tradisi hari Jumat',
			'home.juzToday' => ({required Object n}) => 'Juz ${n} hari ini',
			'home.ramadanReading' => 'Satu juz sehari sepanjang bulan',
			'home.eidMubarak' => 'Eid Mubarak',
			'home.shareEid' => 'Bagikan ucapan Eid',
			'home.allAlerts' => 'Suara adzan dan semua pengingat',
			'home.prayLater' => 'Alur salat hadir pada pembaruan berikutnya.',
			'home.alertsLater' => 'Pengingat salat hadir pada pembaruan berikutnya.',
			'home.debugClock' => 'Jam debug',
			'home.debugEarlier' => 'Hari sebelumnya',
			'home.debugLater' => 'Hari berikutnya',
			'home.debugDevice' => 'Pakai waktu perangkat',
			'home.previewLive' => 'Live',
			'home.previewFriday' => 'Jumat',
			'home.previewRamadan' => 'Ramadan',
			'home.previewEid' => 'Eid',
			'home.mon' => 'Sen',
			'home.tue' => 'Sel',
			'home.wed' => 'Rab',
			'home.thu' => 'Kam',
			'home.fri' => 'Jum',
			'home.sat' => 'Sab',
			'home.sun' => 'Min',
			'home.month1' => 'Jan',
			'home.month2' => 'Feb',
			'home.month3' => 'Mar',
			'home.month4' => 'Apr',
			'home.month5' => 'Mei',
			'home.month6' => 'Jun',
			'home.month7' => 'Jul',
			'home.month8' => 'Agu',
			'home.month9' => 'Sep',
			'home.month10' => 'Okt',
			'home.month11' => 'Nov',
			'home.month12' => 'Des',
			'home.muharram' => 'Muharram',
			'home.safar' => 'Safar',
			'home.rabiAwwal' => 'Rabiul Awal',
			'home.rabiThani' => 'Rabiul Akhir',
			'home.jumadaUla' => 'Jumadil Awal',
			'home.jumadaThani' => 'Jumadil Akhir',
			'home.rajab' => 'Rajab',
			'home.shaban' => 'Syaban',
			'home.ramadan' => 'Ramadan',
			'home.shawwal' => 'Syawal',
			'home.dhulQadah' => 'Zulkaidah',
			'home.dhulHijjah' => 'Zulhijah',
			'alerts.title' => 'Pengingat salat',
			'alerts.offNotice' => 'Notifikasi mati untuk aplikasi ini.',
			'alerts.turnOn' => 'Nyalakan',
			'alerts.allFive' => 'Kelima waktu',
			'alerts.eachPrayer' => 'Setiap waktu',
			'alerts.voice' => 'Suara adzan',
			'alerts.makkah' => 'Makkah',
			'alerts.madinah' => 'Madinah',
			'alerts.alAqsa' => 'Al-Aqsa',
			'alerts.adhan' => 'Adzan',
			'alerts.notify' => 'Ingatkan',
			'alerts.off' => 'Mati',
			'alerts.adhanHelp' => 'Memutar panggilan salat yang singkat',
			'alerts.notifyHelp' => 'Banner dengan suara singkat',
			'alerts.offHelp' => 'Tidak ada pengingat. Waktunya tetap tampil di sini',
			'alerts.pause' => 'Jeda pengingat salat',
			'alerts.pauseHelp' => 'Menyembunyikan Pray dan pengingat untuk sementara',
			'alerts.jumuah' => 'Pengingat Jumat',
			'alerts.jumuahHelp' => '30 menit sebelum Dzuhur pada hari Jumat',
			'alerts.lead' => 'Menit sebelumnya',
			'alerts.leadOnTime' => 'Tepat waktu',
			'alerts.leadMinutes' => ({required Object n}) => '${n} mnt',
			'alerts.itsTime' => ({required Object name}) => 'Waktunya ${name}',
			'alerts.dailyTitle' => 'Ayat hari ini',
			'alerts.dailyBody' => 'Tiga ayat hari ini sudah siap',
			'alerts.suhoorTitle' => 'Sahur',
			'alerts.suhoorBody' => 'Sahur segera berakhir',
			'alerts.iftarTitle' => 'Berbuka',
			'alerts.iftarBody' => 'Waktunya berbuka',
			'alerts.jumuahTitle' => 'Jumat',
			'alerts.jumuahBody' => 'Jumat 30 menit lagi',
			'alerts.channelSalah' => 'Pengingat salat',
			'alerts.channelAdhan' => 'Adzan',
			'alerts.channelDaily' => 'Ayat hari ini',
			'alerts.channelSuhoor' => 'Sahur',
			'alerts.channelIftar' => 'Berbuka',
			'alerts.channelJumuah' => 'Jumat',
			_ => null,
		};
	}
}
