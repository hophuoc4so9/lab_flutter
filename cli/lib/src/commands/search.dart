import 'dart:async';
import 'dart:io';

import 'package:command_runner/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:wikipedia/wikipedia.dart';

class SearchCommand extends Command {
  SearchCommand({required this.logger})
      : super(
          name: 'search',
          help: 'Prints a list of links to Wikipedia articles that match the given term.',
          defaultValue: null,
          valueHelp: 'STRING',
        ) {
    addFlag(
      'im-feeling-lucky',
      help:
          'If true, prints the summary of the top article that the search returns.',
    );
  }

  final Logger logger;

  @override
  String get description => 'Search for Wikipedia articles.';

  @override
  bool get requiresArgument => true;

  @override
  FutureOr<String> run(ArgResults args) async {
    if (requiresArgument &&
        (args.commandArg == null || args.commandArg!.isEmpty)) {
      return 'Please include a search term';
    }

    final StringBuffer buffer = StringBuffer('Search results:');
    try {
      final SearchResults results = await search(args.commandArg!);

      if (args.flag('im-feeling-lucky') && results.results.isNotEmpty) {
        final String title = results.results.first.title;
        final Summary article = await getArticleSummaryByTitle(title);
        buffer.writeln('Lucky you!');
        buffer.writeln(article.titles.normalized.titleText);
        if (article.description != null) {
          buffer.writeln(article.description);
        }
        buffer.writeln(article.extract);
        buffer.writeln();
        buffer.writeln('All results:');
      }

      for (final SearchResult result in results.results) {
        buffer.writeln('${result.title} - ${result.url}');
      }
      return buffer.toString();
    } on HttpException catch (e) {
      logger
        ..warning(e.message)
        ..warning(e.uri)
        ..info(usage);
      return e.message;
    } on FormatException catch (e) {
      logger
        ..warning(e.message)
        ..warning(e.source)
        ..info(usage);
      return e.message;
    }
  }
}
