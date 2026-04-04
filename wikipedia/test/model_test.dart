import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:wikipedia/wikipedia.dart';

const String dartLangSummaryJson = './test/test_data/dart_lang_summary.json';
const String catExtractJson = './test/test_data/cat_extract.json';
const String openSearchResponse = './test/test_data/open_search_response.json';

void main() {
  group('deserialize example JSON responses from wikipedia API', () {
    test('deserialize Dart Programming Language page summary example data from '
        'json file into a Summary object', () async {
      final String pageSummaryInput =
          await File(dartLangSummaryJson).readAsString();
      final Map<String, Object?> pageSummaryMap =
          jsonDecode(pageSummaryInput) as Map<String, Object?>;
      final Summary summary = Summary.fromJson(pageSummaryMap);
      expect(summary.titles.canonical, 'Dart_(programming_language)');
    });

    test('deserialize Cat article example data from json file into '
        'an Article object', () async {
      final String articleJson = await File(catExtractJson).readAsString();
      final Map<String, Object?> articleMap =
          jsonDecode(articleJson) as Map<String, Object?>;
      final List<Article> articles = Article.listFromJson(articleMap);
      expect(articles.first.title.toLowerCase(), 'cat');
    });

    test('deserialize Open Search results example data from json file '
        'into an SearchResults object', () async {
      final String resultsString =
          await File(openSearchResponse).readAsString();
      final List<Object?> resultsAsList =
          jsonDecode(resultsString) as List<Object?>;
      final SearchResults results = SearchResults.fromJson(resultsAsList);
      expect(results.results.length, greaterThan(1));
    });
  });

  group('live wikipedia api', () {
    test('getRandomArticleSummary returns non-empty summary', () async {
      final Summary summary = await getRandomArticleSummary();
      expect(summary.pageid, greaterThan(0));
      expect(summary.titles.canonical, isNotEmpty);
      expect(summary.extract, isNotEmpty);
    });

    test('getArticleSummaryByTitle returns Dart summary', () async {
      final Summary summary =
          await getArticleSummaryByTitle('Dart_(programming_language)');
      expect(summary.pageid, greaterThan(0));
      expect(summary.titles.canonical, contains('Dart'));
      expect(summary.extract.toLowerCase(), contains('programming'));
    });

    test('search returns results for dart', () async {
      final SearchResults results = await search('dart');
      expect(results.searchTerm?.toLowerCase(), 'dart');
      expect(results.results, isNotEmpty);
      expect(results.results.first.title, isNotEmpty);
      expect(results.results.first.url, contains('wikipedia.org'));
    });

    test('getArticleByTitle returns cat article content', () async {
      final List<Article> articles = await getArticleByTitle('Cat');
      expect(articles, isNotEmpty);
      expect(articles.first.title.toLowerCase(), contains('cat'));
      expect(articles.first.extract, isNotEmpty);
    });
  });
}
