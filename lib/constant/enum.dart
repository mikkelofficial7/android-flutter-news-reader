import 'package:flutter_news_reader/constant/language.dart';

enum NewsCategory {
  hotnews(newTab, "general"),
  finance(financeTab, "finance"),
  politic(politicTab, "politic"),
  education(educationTab, "education"),
  technology(technologyTab, "technology"),
  health(healthTab, "health"),
  sports(sportTab, "sport");

  final String tabCategory;
  final String query;

  const NewsCategory(this.tabCategory, this.query);
}
