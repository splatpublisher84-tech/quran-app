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
			_ => null,
		};
	}
}
