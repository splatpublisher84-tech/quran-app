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
	@override String get title => 'Selamat datang';
	@override String get subtitle => 'Baca Al-Qur\'an, waktu salat, dan pengingat, bahkan tanpa internet.';
	@override String get start => 'Mulai';
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
			'onboarding.title' => 'Selamat datang',
			'onboarding.subtitle' => 'Baca Al-Qur\'an, waktu salat, dan pengingat, bahkan tanpa internet.',
			'onboarding.start' => 'Mulai',
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
			_ => null,
		};
	}
}
