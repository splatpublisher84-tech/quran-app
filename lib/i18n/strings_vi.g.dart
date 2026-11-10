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
			_ => null,
		};
	}
}
