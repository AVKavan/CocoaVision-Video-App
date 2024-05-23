
class LanguageModel {
  final int id;
  final String languageName;
  final String languageCode;
  final String countryCode;
  LanguageModel(this.id, this.languageName, this.languageCode, this.countryCode);


  static List<LanguageModel> languageList = [
      LanguageModel(1, "English", "en", "US"),
      LanguageModel(2, "ಕನ್ನಡ", "kn", "IN"),
      LanguageModel(3, "తెలుగు", "te", "IN"),
    ];

}
