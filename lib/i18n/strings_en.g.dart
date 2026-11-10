///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$tabs$en tabs = Translations$tabs$en._(_root);
	late final Translations$common$en common = Translations$common$en._(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en._(_root);
	late final Translations$quran$en quran = Translations$quran$en._(_root);
}

// Path: tabs
class Translations$tabs$en {
	Translations$tabs$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Quran'
	String get quran => 'Quran';

	/// en: 'Ayah of the day'
	String get ayahOfDay => 'Ayah of the day';

	/// en: 'Settings'
	String get settings => 'Settings';
}

// Path: common
class Translations$common$en {
	Translations$common$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This screen arrives in a later milestone.'
	String get comingSoon => 'This screen arrives in a later milestone.';

	/// en: 'Try again'
	String get retry => 'Try again';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Back'
	String get back => 'Back';
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome'
	String get title => 'Welcome';

	/// en: 'Read the Quran, prayer times and reminders, even offline.'
	String get subtitle => 'Read the Quran, prayer times and reminders, even offline.';

	/// en: 'Get started'
	String get start => 'Get started';
}

// Path: quran
class Translations$quran$en {
	Translations$quran$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Quran'
	String get title => 'Quran';

	/// en: 'Surah name or 2:255'
	String get searchHint => 'Surah name or 2:255';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'Surah'
	String get surah => 'Surah';

	/// en: 'Juz'
	String get juz => 'Juz';

	/// en: 'Saved'
	String get saved => 'Saved';

	/// en: 'Continue reading'
	String get continueReading => 'Continue reading';

	/// en: 'Go to $ref'
	String goTo({required Object ref}) => 'Go to ${ref}';

	/// en: 'No surah found'
	String get noSurahFound => 'No surah found';

	/// en: 'No juz found'
	String get noJuzFound => 'No juz found';

	/// en: 'No results'
	String get noResults => 'No results';

	/// en: 'No saved ayahs yet'
	String get noSaved => 'No saved ayahs yet';

	/// en: 'Tap an ayah while reading, then Save.'
	String get noSavedHint => 'Tap an ayah while reading, then Save.';

	/// en: 'The Quran could not be loaded.'
	String get loadError => 'The Quran could not be loaded.';

	/// en: '$n ayahs'
	String ayahCount({required Object n}) => '${n} ayahs';

	/// en: 'Juz $n'
	String juzTitle({required Object n}) => 'Juz ${n}';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Share'
	String get share => 'Share';

	/// en: 'Sharing arrives in a later update.'
	String get shareLater => 'Sharing arrives in a later update.';

	/// en: 'Translation language'
	String get translationLanguage => 'Translation language';

	/// en: 'Text size'
	String get textSize => 'Text size';

	/// en: 'Arabic text size'
	String get arabicTextSize => 'Arabic text size';

	/// en: 'Small'
	String get small => 'Small';

	/// en: 'Medium'
	String get medium => 'Medium';

	/// en: 'Large'
	String get large => 'Large';

	/// en: 'Translator's note'
	String get translatorNote => 'Translator\'s note';

	/// en: 'Ayah $ref'
	String ayahLabel({required Object ref}) => 'Ayah ${ref}';

	/// en: 'Loading'
	String get loading => 'Loading';

	/// en: 'English'
	String get languageEn => 'English';

	/// en: 'Indonesia'
	String get languageId => 'Indonesia';

	/// en: 'Urdu'
	String get languageUr => 'Urdu';

	/// en: 'Turkish'
	String get languageTr => 'Turkish';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'tabs.home' => 'Home',
			'tabs.quran' => 'Quran',
			'tabs.ayahOfDay' => 'Ayah of the day',
			'tabs.settings' => 'Settings',
			'common.comingSoon' => 'This screen arrives in a later milestone.',
			'common.retry' => 'Try again',
			'common.cancel' => 'Cancel',
			'common.confirm' => 'Confirm',
			'common.close' => 'Close',
			'common.back' => 'Back',
			'onboarding.title' => 'Welcome',
			'onboarding.subtitle' => 'Read the Quran, prayer times and reminders, even offline.',
			'onboarding.start' => 'Get started',
			'quran.title' => 'Quran',
			'quran.searchHint' => 'Surah name or 2:255',
			'quran.search' => 'Search',
			'quran.clear' => 'Clear',
			'quran.surah' => 'Surah',
			'quran.juz' => 'Juz',
			'quran.saved' => 'Saved',
			'quran.continueReading' => 'Continue reading',
			'quran.goTo' => ({required Object ref}) => 'Go to ${ref}',
			'quran.noSurahFound' => 'No surah found',
			'quran.noJuzFound' => 'No juz found',
			'quran.noResults' => 'No results',
			'quran.noSaved' => 'No saved ayahs yet',
			'quran.noSavedHint' => 'Tap an ayah while reading, then Save.',
			'quran.loadError' => 'The Quran could not be loaded.',
			'quran.ayahCount' => ({required Object n}) => '${n} ayahs',
			'quran.juzTitle' => ({required Object n}) => 'Juz ${n}',
			'quran.save' => 'Save',
			'quran.share' => 'Share',
			'quran.shareLater' => 'Sharing arrives in a later update.',
			'quran.translationLanguage' => 'Translation language',
			'quran.textSize' => 'Text size',
			'quran.arabicTextSize' => 'Arabic text size',
			'quran.small' => 'Small',
			'quran.medium' => 'Medium',
			'quran.large' => 'Large',
			'quran.translatorNote' => 'Translator\'s note',
			'quran.ayahLabel' => ({required Object ref}) => 'Ayah ${ref}',
			'quran.loading' => 'Loading',
			'quran.languageEn' => 'English',
			'quran.languageId' => 'Indonesia',
			'quran.languageUr' => 'Urdu',
			'quran.languageTr' => 'Turkish',
			_ => null,
		};
	}
}
