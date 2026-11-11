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
	late final Translations$home$en home = Translations$home$en._(_root);
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

// Path: home
class Translations$home$en {
	Translations$home$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Prayer times could not be loaded.'
	String get loadError => 'Prayer times could not be loaded.';

	/// en: 'It's time'
	String get itsTime => 'It\'s time';

	/// en: 'Still time'
	String get stillTime => 'Still time';

	/// en: 'Next prayer'
	String get nextPrayer => 'Next prayer';

	/// en: 'Prayed'
	String get prayed => 'Prayed';

	/// en: 'Paused'
	String get paused => 'Paused';

	/// en: 'Isha has ended'
	String get ishaEnded => 'Isha has ended';

	/// en: 'Pray'
	String get pray => 'Pray';

	/// en: 'I've prayed'
	String get ivePrayed => 'I\'ve prayed';

	/// en: 'Undo'
	String get undo => 'Undo';

	/// en: '$name marked as prayed'
	String marked({required Object name}) => '${name} marked as prayed';

	/// en: 'Started $time'
	String startedAt({required Object time}) => 'Started ${time}';

	/// en: '$duration left'
	String timeLeft({required Object duration}) => '${duration} left';

	/// en: 'in $duration'
	String inDuration({required Object duration}) => 'in ${duration}';

	/// en: 'Next prayer in $duration'
	String nextIn({required Object duration}) => 'Next prayer in ${duration}';

	/// en: 'Prayer prompts are paused'
	String get promptsPaused => 'Prayer prompts are paused';

	/// en: 'Suhoor ends in'
	String get suhoorEnds => 'Suhoor ends in';

	/// en: 'Finish eating by Imsak'
	String get finishByImsak => 'Finish eating by Imsak';

	/// en: 'Fasting. Iftar in'
	String get fastingIftar => 'Fasting. Iftar in';

	/// en: 'Break your fast at Maghrib'
	String get breakAtMaghrib => 'Break your fast at Maghrib';

	/// en: 'Next Imsak in'
	String get nextImsak => 'Next Imsak in';

	/// en: 'Suhoor before dawn'
	String get suhoorBeforeDawn => 'Suhoor before dawn';

	/// en: 'Times are estimated from your time zone.'
	String get estimatedTimes => 'Times are estimated from your time zone.';

	/// en: 'Prayer alerts are off'
	String get alertsOff => 'Prayer alerts are off';

	/// en: 'Turn on'
	String get turnOn => 'Turn on';

	/// en: '$n min'
	String minutes({required Object n}) => '${n} min';

	/// en: '$n h'
	String hours({required Object n}) => '${n} h';

	/// en: '$h h $m min'
	String hoursMinutes({required Object h, required Object m}) => '${h} h ${m} min';

	/// en: 'Fajr'
	String get fajr => 'Fajr';

	/// en: 'Dhuhr'
	String get dhuhr => 'Dhuhr';

	/// en: 'Asr'
	String get asr => 'Asr';

	/// en: 'Maghrib'
	String get maghrib => 'Maghrib';

	/// en: 'Isha'
	String get isha => 'Isha';

	/// en: 'Jumu'ah'
	String get jumuah => 'Jumu\'ah';

	/// en: 'Imsak'
	String get imsak => 'Imsak';

	/// en: 'Iftar'
	String get iftar => 'Iftar';

	/// en: 'Sunrise. Fajr ends'
	String get sunriseEnds => 'Sunrise. Fajr ends';

	/// en: 'Read Surah Al-Kahf'
	String get readKahf => 'Read Surah Al-Kahf';

	/// en: 'A Friday tradition'
	String get fridayTradition => 'A Friday tradition';

	/// en: 'Juz $n today'
	String juzToday({required Object n}) => 'Juz ${n} today';

	/// en: 'One juz a day through the month'
	String get ramadanReading => 'One juz a day through the month';

	/// en: 'Eid Mubarak'
	String get eidMubarak => 'Eid Mubarak';

	/// en: 'Share an Eid greeting'
	String get shareEid => 'Share an Eid greeting';

	/// en: 'Adhan voice and all alerts'
	String get allAlerts => 'Adhan voice and all alerts';

	/// en: 'The prayer flow arrives in a later update.'
	String get prayLater => 'The prayer flow arrives in a later update.';

	/// en: 'Prayer alerts arrive in a later update.'
	String get alertsLater => 'Prayer alerts arrive in a later update.';

	/// en: 'Debug clock'
	String get debugClock => 'Debug clock';

	/// en: 'Previous day'
	String get debugEarlier => 'Previous day';

	/// en: 'Next day'
	String get debugLater => 'Next day';

	/// en: 'Use device time'
	String get debugDevice => 'Use device time';

	/// en: 'Live'
	String get previewLive => 'Live';

	/// en: 'Friday'
	String get previewFriday => 'Friday';

	/// en: 'Ramadan'
	String get previewRamadan => 'Ramadan';

	/// en: 'Eid'
	String get previewEid => 'Eid';

	/// en: 'Mon'
	String get mon => 'Mon';

	/// en: 'Tue'
	String get tue => 'Tue';

	/// en: 'Wed'
	String get wed => 'Wed';

	/// en: 'Thu'
	String get thu => 'Thu';

	/// en: 'Fri'
	String get fri => 'Fri';

	/// en: 'Sat'
	String get sat => 'Sat';

	/// en: 'Sun'
	String get sun => 'Sun';

	/// en: 'Jan'
	String get month1 => 'Jan';

	/// en: 'Feb'
	String get month2 => 'Feb';

	/// en: 'Mar'
	String get month3 => 'Mar';

	/// en: 'Apr'
	String get month4 => 'Apr';

	/// en: 'May'
	String get month5 => 'May';

	/// en: 'Jun'
	String get month6 => 'Jun';

	/// en: 'Jul'
	String get month7 => 'Jul';

	/// en: 'Aug'
	String get month8 => 'Aug';

	/// en: 'Sep'
	String get month9 => 'Sep';

	/// en: 'Oct'
	String get month10 => 'Oct';

	/// en: 'Nov'
	String get month11 => 'Nov';

	/// en: 'Dec'
	String get month12 => 'Dec';

	/// en: 'Muharram'
	String get muharram => 'Muharram';

	/// en: 'Safar'
	String get safar => 'Safar';

	/// en: 'Rabi al-Awwal'
	String get rabiAwwal => 'Rabi al-Awwal';

	/// en: 'Rabi al-Thani'
	String get rabiThani => 'Rabi al-Thani';

	/// en: 'Jumada al-Ula'
	String get jumadaUla => 'Jumada al-Ula';

	/// en: 'Jumada al-Thani'
	String get jumadaThani => 'Jumada al-Thani';

	/// en: 'Rajab'
	String get rajab => 'Rajab';

	/// en: 'Shaban'
	String get shaban => 'Shaban';

	/// en: 'Ramadan'
	String get ramadan => 'Ramadan';

	/// en: 'Shawwal'
	String get shawwal => 'Shawwal';

	/// en: 'Dhul Qadah'
	String get dhulQadah => 'Dhul Qadah';

	/// en: 'Dhul Hijjah'
	String get dhulHijjah => 'Dhul Hijjah';
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
			'home.loadError' => 'Prayer times could not be loaded.',
			'home.itsTime' => 'It\'s time',
			'home.stillTime' => 'Still time',
			'home.nextPrayer' => 'Next prayer',
			'home.prayed' => 'Prayed',
			'home.paused' => 'Paused',
			'home.ishaEnded' => 'Isha has ended',
			'home.pray' => 'Pray',
			'home.ivePrayed' => 'I\'ve prayed',
			'home.undo' => 'Undo',
			'home.marked' => ({required Object name}) => '${name} marked as prayed',
			'home.startedAt' => ({required Object time}) => 'Started ${time}',
			'home.timeLeft' => ({required Object duration}) => '${duration} left',
			'home.inDuration' => ({required Object duration}) => 'in ${duration}',
			'home.nextIn' => ({required Object duration}) => 'Next prayer in ${duration}',
			'home.promptsPaused' => 'Prayer prompts are paused',
			'home.suhoorEnds' => 'Suhoor ends in',
			'home.finishByImsak' => 'Finish eating by Imsak',
			'home.fastingIftar' => 'Fasting. Iftar in',
			'home.breakAtMaghrib' => 'Break your fast at Maghrib',
			'home.nextImsak' => 'Next Imsak in',
			'home.suhoorBeforeDawn' => 'Suhoor before dawn',
			'home.estimatedTimes' => 'Times are estimated from your time zone.',
			'home.alertsOff' => 'Prayer alerts are off',
			'home.turnOn' => 'Turn on',
			'home.minutes' => ({required Object n}) => '${n} min',
			'home.hours' => ({required Object n}) => '${n} h',
			'home.hoursMinutes' => ({required Object h, required Object m}) => '${h} h ${m} min',
			'home.fajr' => 'Fajr',
			'home.dhuhr' => 'Dhuhr',
			'home.asr' => 'Asr',
			'home.maghrib' => 'Maghrib',
			'home.isha' => 'Isha',
			'home.jumuah' => 'Jumu\'ah',
			'home.imsak' => 'Imsak',
			'home.iftar' => 'Iftar',
			'home.sunriseEnds' => 'Sunrise. Fajr ends',
			'home.readKahf' => 'Read Surah Al-Kahf',
			'home.fridayTradition' => 'A Friday tradition',
			'home.juzToday' => ({required Object n}) => 'Juz ${n} today',
			'home.ramadanReading' => 'One juz a day through the month',
			'home.eidMubarak' => 'Eid Mubarak',
			'home.shareEid' => 'Share an Eid greeting',
			'home.allAlerts' => 'Adhan voice and all alerts',
			'home.prayLater' => 'The prayer flow arrives in a later update.',
			'home.alertsLater' => 'Prayer alerts arrive in a later update.',
			'home.debugClock' => 'Debug clock',
			'home.debugEarlier' => 'Previous day',
			'home.debugLater' => 'Next day',
			'home.debugDevice' => 'Use device time',
			'home.previewLive' => 'Live',
			'home.previewFriday' => 'Friday',
			'home.previewRamadan' => 'Ramadan',
			'home.previewEid' => 'Eid',
			'home.mon' => 'Mon',
			'home.tue' => 'Tue',
			'home.wed' => 'Wed',
			'home.thu' => 'Thu',
			'home.fri' => 'Fri',
			'home.sat' => 'Sat',
			'home.sun' => 'Sun',
			'home.month1' => 'Jan',
			'home.month2' => 'Feb',
			'home.month3' => 'Mar',
			'home.month4' => 'Apr',
			'home.month5' => 'May',
			'home.month6' => 'Jun',
			'home.month7' => 'Jul',
			'home.month8' => 'Aug',
			'home.month9' => 'Sep',
			'home.month10' => 'Oct',
			'home.month11' => 'Nov',
			'home.month12' => 'Dec',
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
