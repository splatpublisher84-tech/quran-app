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
class TranslationsVi with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsVi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key);

	late final TranslationsVi _root = this; // ignore: unused_field

	@override 
	TranslationsVi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsVi(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$tabs$vi tabs = _Translations$tabs$vi._(_root);
	@override late final _Translations$common$vi common = _Translations$common$vi._(_root);
	@override late final _Translations$onboarding$vi onboarding = _Translations$onboarding$vi._(_root);
	@override late final _Translations$quran$vi quran = _Translations$quran$vi._(_root);
	@override late final _Translations$home$vi home = _Translations$home$vi._(_root);
}

// Path: tabs
class _Translations$tabs$vi implements Translations$tabs$en {
	_Translations$tabs$vi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get home => 'Trang chủ';
	@override String get quran => 'Kinh Qur\'an';
	@override String get ayahOfDay => 'Câu kinh hôm nay';
	@override String get settings => 'Cài đặt';
}

// Path: common
class _Translations$common$vi implements Translations$common$en {
	_Translations$common$vi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get comingSoon => 'Màn hình này sẽ có trong một giai đoạn sau.';
	@override String get retry => 'Thử lại';
	@override String get cancel => 'Hủy';
	@override String get confirm => 'Xác nhận';
	@override String get close => 'Đóng';
	@override String get back => 'Quay lại';
}

// Path: onboarding
class _Translations$onboarding$vi implements Translations$onboarding$en {
	_Translations$onboarding$vi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Chào mừng';
	@override String get subtitle => 'Đọc Kinh Qur\'an, giờ cầu nguyện và nhắc nhở, kể cả khi không có mạng.';
	@override String get start => 'Bắt đầu';
}

// Path: quran
class _Translations$quran$vi implements Translations$quran$en {
	_Translations$quran$vi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kinh Qur\'an';
	@override String get searchHint => 'Tên surah hoặc 2:255';
	@override String get search => 'Tìm';
	@override String get clear => 'Xóa';
	@override String get surah => 'Surah';
	@override String get juz => 'Juz';
	@override String get saved => 'Đã lưu';
	@override String get continueReading => 'Đọc tiếp';
	@override String goTo({required Object ref}) => 'Đi tới ${ref}';
	@override String get noSurahFound => 'Không tìm thấy surah';
	@override String get noJuzFound => 'Không tìm thấy juz';
	@override String get noResults => 'Không có kết quả';
	@override String get noSaved => 'Chưa lưu câu nào';
	@override String get noSavedHint => 'Chạm một câu khi đang đọc, rồi bấm Lưu.';
	@override String get loadError => 'Không tải được Kinh Qur\'an.';
	@override String ayahCount({required Object n}) => '${n} câu';
	@override String juzTitle({required Object n}) => 'Juz ${n}';
	@override String get save => 'Lưu';
	@override String get share => 'Chia sẻ';
	@override String get shareLater => 'Chia sẻ sẽ có trong bản cập nhật sau.';
	@override String get translationLanguage => 'Ngôn ngữ bản dịch';
	@override String get textSize => 'Cỡ chữ';
	@override String get arabicTextSize => 'Cỡ chữ Arabic';
	@override String get small => 'Nhỏ';
	@override String get medium => 'Vừa';
	@override String get large => 'Lớn';
	@override String get translatorNote => 'Ghi chú của người dịch';
	@override String ayahLabel({required Object ref}) => 'Câu ${ref}';
	@override String get loading => 'Đang tải';
	@override String get languageEn => 'English';
	@override String get languageId => 'Indonesia';
	@override String get languageUr => 'Urdu';
	@override String get languageTr => 'Turkish';
}

// Path: home
class _Translations$home$vi implements Translations$home$en {
	_Translations$home$vi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get loadError => 'Không tải được giờ cầu nguyện.';
	@override String get itsTime => 'Đã tới giờ';
	@override String get stillTime => 'Còn giờ';
	@override String get nextPrayer => 'Giờ kế tiếp';
	@override String get prayed => 'Đã cầu nguyện';
	@override String get paused => 'Tạm dừng';
	@override String get ishaEnded => 'Đã hết giờ Isha';
	@override String get pray => 'Cầu nguyện';
	@override String get ivePrayed => 'Tôi đã cầu nguyện';
	@override String get undo => 'Hoàn tác';
	@override String marked({required Object name}) => 'Đã đánh dấu ${name}';
	@override String startedAt({required Object time}) => 'Bắt đầu ${time}';
	@override String timeLeft({required Object duration}) => 'Còn ${duration}';
	@override String inDuration({required Object duration}) => 'còn ${duration}';
	@override String nextIn({required Object duration}) => 'Giờ kế tiếp còn ${duration}';
	@override String get promptsPaused => 'Đã tạm dừng nhắc cầu nguyện';
	@override String get suhoorEnds => 'Suhoor kết thúc sau';
	@override String get finishByImsak => 'Ăn xong trước Imsak';
	@override String get fastingIftar => 'Đang nhịn. Còn tới Iftar';
	@override String get breakAtMaghrib => 'Mở bữa tại Maghrib';
	@override String get nextImsak => 'Imsak kế tiếp sau';
	@override String get suhoorBeforeDawn => 'Suhoor trước bình minh';
	@override String get estimatedTimes => 'Giờ được ước tính theo múi giờ của máy.';
	@override String get alertsOff => 'Nhắc cầu nguyện đang tắt';
	@override String get turnOn => 'Bật';
	@override String minutes({required Object n}) => '${n} phút';
	@override String hours({required Object n}) => '${n} giờ';
	@override String hoursMinutes({required Object h, required Object m}) => '${h} giờ ${m} phút';
	@override String get fajr => 'Fajr';
	@override String get dhuhr => 'Dhuhr';
	@override String get asr => 'Asr';
	@override String get maghrib => 'Maghrib';
	@override String get isha => 'Isha';
	@override String get jumuah => 'Jumu\'ah';
	@override String get imsak => 'Imsak';
	@override String get iftar => 'Iftar';
	@override String get sunriseEnds => 'Mặt trời mọc. Hết giờ Fajr';
	@override String get readKahf => 'Đọc Surah Al-Kahf';
	@override String get fridayTradition => 'Truyền thống ngày thứ Sáu';
	@override String juzToday({required Object n}) => 'Juz ${n} hôm nay';
	@override String get ramadanReading => 'Mỗi ngày một juz trong tháng';
	@override String get eidMubarak => 'Eid Mubarak';
	@override String get shareEid => 'Chia sẻ lời chúc Eid';
	@override String get allAlerts => 'Giọng Adhan và mọi nhắc nhở';
	@override String get prayLater => 'Luồng cầu nguyện sẽ có trong bản cập nhật sau.';
	@override String get alertsLater => 'Nhắc cầu nguyện sẽ có trong bản cập nhật sau.';
	@override String get debugClock => 'Đồng hồ gỡ lỗi';
	@override String get debugEarlier => 'Ngày trước';
	@override String get debugLater => 'Ngày sau';
	@override String get debugDevice => 'Dùng giờ máy';
	@override String get previewLive => 'Thật';
	@override String get previewFriday => 'Thứ Sáu';
	@override String get previewRamadan => 'Ramadan';
	@override String get previewEid => 'Eid';
	@override String get mon => 'T2';
	@override String get tue => 'T3';
	@override String get wed => 'T4';
	@override String get thu => 'T5';
	@override String get fri => 'T6';
	@override String get sat => 'T7';
	@override String get sun => 'CN';
	@override String get month1 => 'Th1';
	@override String get month2 => 'Th2';
	@override String get month3 => 'Th3';
	@override String get month4 => 'Th4';
	@override String get month5 => 'Th5';
	@override String get month6 => 'Th6';
	@override String get month7 => 'Th7';
	@override String get month8 => 'Th8';
	@override String get month9 => 'Th9';
	@override String get month10 => 'Th10';
	@override String get month11 => 'Th11';
	@override String get month12 => 'Th12';
	@override String get muharram => 'Muharram';
	@override String get safar => 'Safar';
	@override String get rabiAwwal => 'Rabi al-Awwal';
	@override String get rabiThani => 'Rabi al-Thani';
	@override String get jumadaUla => 'Jumada al-Ula';
	@override String get jumadaThani => 'Jumada al-Thani';
	@override String get rajab => 'Rajab';
	@override String get shaban => 'Shaban';
	@override String get ramadan => 'Ramadan';
	@override String get shawwal => 'Shawwal';
	@override String get dhulQadah => 'Dhul Qadah';
	@override String get dhulHijjah => 'Dhul Hijjah';
}

/// The flat map containing all translations for locale <vi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsVi {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'tabs.home' => 'Trang chủ',
			'tabs.quran' => 'Kinh Qur\'an',
			'tabs.ayahOfDay' => 'Câu kinh hôm nay',
			'tabs.settings' => 'Cài đặt',
			'common.comingSoon' => 'Màn hình này sẽ có trong một giai đoạn sau.',
			'common.retry' => 'Thử lại',
			'common.cancel' => 'Hủy',
			'common.confirm' => 'Xác nhận',
			'common.close' => 'Đóng',
			'common.back' => 'Quay lại',
			'onboarding.title' => 'Chào mừng',
			'onboarding.subtitle' => 'Đọc Kinh Qur\'an, giờ cầu nguyện và nhắc nhở, kể cả khi không có mạng.',
			'onboarding.start' => 'Bắt đầu',
			'quran.title' => 'Kinh Qur\'an',
			'quran.searchHint' => 'Tên surah hoặc 2:255',
			'quran.search' => 'Tìm',
			'quran.clear' => 'Xóa',
			'quran.surah' => 'Surah',
			'quran.juz' => 'Juz',
			'quran.saved' => 'Đã lưu',
			'quran.continueReading' => 'Đọc tiếp',
			'quran.goTo' => ({required Object ref}) => 'Đi tới ${ref}',
			'quran.noSurahFound' => 'Không tìm thấy surah',
			'quran.noJuzFound' => 'Không tìm thấy juz',
			'quran.noResults' => 'Không có kết quả',
			'quran.noSaved' => 'Chưa lưu câu nào',
			'quran.noSavedHint' => 'Chạm một câu khi đang đọc, rồi bấm Lưu.',
			'quran.loadError' => 'Không tải được Kinh Qur\'an.',
			'quran.ayahCount' => ({required Object n}) => '${n} câu',
			'quran.juzTitle' => ({required Object n}) => 'Juz ${n}',
			'quran.save' => 'Lưu',
			'quran.share' => 'Chia sẻ',
			'quran.shareLater' => 'Chia sẻ sẽ có trong bản cập nhật sau.',
			'quran.translationLanguage' => 'Ngôn ngữ bản dịch',
			'quran.textSize' => 'Cỡ chữ',
			'quran.arabicTextSize' => 'Cỡ chữ Arabic',
			'quran.small' => 'Nhỏ',
			'quran.medium' => 'Vừa',
			'quran.large' => 'Lớn',
			'quran.translatorNote' => 'Ghi chú của người dịch',
			'quran.ayahLabel' => ({required Object ref}) => 'Câu ${ref}',
			'quran.loading' => 'Đang tải',
			'quran.languageEn' => 'English',
			'quran.languageId' => 'Indonesia',
			'quran.languageUr' => 'Urdu',
			'quran.languageTr' => 'Turkish',
			'home.loadError' => 'Không tải được giờ cầu nguyện.',
			'home.itsTime' => 'Đã tới giờ',
			'home.stillTime' => 'Còn giờ',
			'home.nextPrayer' => 'Giờ kế tiếp',
			'home.prayed' => 'Đã cầu nguyện',
			'home.paused' => 'Tạm dừng',
			'home.ishaEnded' => 'Đã hết giờ Isha',
			'home.pray' => 'Cầu nguyện',
			'home.ivePrayed' => 'Tôi đã cầu nguyện',
			'home.undo' => 'Hoàn tác',
			'home.marked' => ({required Object name}) => 'Đã đánh dấu ${name}',
			'home.startedAt' => ({required Object time}) => 'Bắt đầu ${time}',
			'home.timeLeft' => ({required Object duration}) => 'Còn ${duration}',
			'home.inDuration' => ({required Object duration}) => 'còn ${duration}',
			'home.nextIn' => ({required Object duration}) => 'Giờ kế tiếp còn ${duration}',
			'home.promptsPaused' => 'Đã tạm dừng nhắc cầu nguyện',
			'home.suhoorEnds' => 'Suhoor kết thúc sau',
			'home.finishByImsak' => 'Ăn xong trước Imsak',
			'home.fastingIftar' => 'Đang nhịn. Còn tới Iftar',
			'home.breakAtMaghrib' => 'Mở bữa tại Maghrib',
			'home.nextImsak' => 'Imsak kế tiếp sau',
			'home.suhoorBeforeDawn' => 'Suhoor trước bình minh',
			'home.estimatedTimes' => 'Giờ được ước tính theo múi giờ của máy.',
			'home.alertsOff' => 'Nhắc cầu nguyện đang tắt',
			'home.turnOn' => 'Bật',
			'home.minutes' => ({required Object n}) => '${n} phút',
			'home.hours' => ({required Object n}) => '${n} giờ',
			'home.hoursMinutes' => ({required Object h, required Object m}) => '${h} giờ ${m} phút',
			'home.fajr' => 'Fajr',
			'home.dhuhr' => 'Dhuhr',
			'home.asr' => 'Asr',
			'home.maghrib' => 'Maghrib',
			'home.isha' => 'Isha',
			'home.jumuah' => 'Jumu\'ah',
			'home.imsak' => 'Imsak',
			'home.iftar' => 'Iftar',
			'home.sunriseEnds' => 'Mặt trời mọc. Hết giờ Fajr',
			'home.readKahf' => 'Đọc Surah Al-Kahf',
			'home.fridayTradition' => 'Truyền thống ngày thứ Sáu',
			'home.juzToday' => ({required Object n}) => 'Juz ${n} hôm nay',
			'home.ramadanReading' => 'Mỗi ngày một juz trong tháng',
			'home.eidMubarak' => 'Eid Mubarak',
			'home.shareEid' => 'Chia sẻ lời chúc Eid',
			'home.allAlerts' => 'Giọng Adhan và mọi nhắc nhở',
			'home.prayLater' => 'Luồng cầu nguyện sẽ có trong bản cập nhật sau.',
			'home.alertsLater' => 'Nhắc cầu nguyện sẽ có trong bản cập nhật sau.',
			'home.debugClock' => 'Đồng hồ gỡ lỗi',
			'home.debugEarlier' => 'Ngày trước',
			'home.debugLater' => 'Ngày sau',
			'home.debugDevice' => 'Dùng giờ máy',
			'home.previewLive' => 'Thật',
			'home.previewFriday' => 'Thứ Sáu',
			'home.previewRamadan' => 'Ramadan',
			'home.previewEid' => 'Eid',
			'home.mon' => 'T2',
			'home.tue' => 'T3',
			'home.wed' => 'T4',
			'home.thu' => 'T5',
			'home.fri' => 'T6',
			'home.sat' => 'T7',
			'home.sun' => 'CN',
			'home.month1' => 'Th1',
			'home.month2' => 'Th2',
			'home.month3' => 'Th3',
			'home.month4' => 'Th4',
			'home.month5' => 'Th5',
			'home.month6' => 'Th6',
			'home.month7' => 'Th7',
			'home.month8' => 'Th8',
			'home.month9' => 'Th9',
			'home.month10' => 'Th10',
			'home.month11' => 'Th11',
			'home.month12' => 'Th12',
			'home.muharram' => 'Muharram',
			'home.safar' => 'Safar',
			'home.rabiAwwal' => 'Rabi al-Awwal',
			'home.rabiThani' => 'Rabi al-Thani',
			'home.jumadaUla' => 'Jumada al-Ula',
			'home.jumadaThani' => 'Jumada al-Thani',
			'home.rajab' => 'Rajab',
			'home.shaban' => 'Shaban',
			'home.ramadan' => 'Ramadan',
			'home.shawwal' => 'Shawwal',
			'home.dhulQadah' => 'Dhul Qadah',
			'home.dhulHijjah' => 'Dhul Hijjah',
			_ => null,
		};
	}
}
