import 'dart:async';
import 'dart:io';

import 'package:command_runner/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:wikipedia/wikipedia.dart';

class GetArticleCommand extends Command {
  GetArticleCommand({required this.logger})
      : super(
          name: 'article',
          help: 'Gets an article by exact canonical wikipedia title.',
          defaultValue: 'cat',
          valueHelp: 'STRING',
        );

  final Logger logger;

  @override
  String get description => 'Read an article from Wikipedia';

  @override
  FutureOr<String> run(ArgResults args) async {
    try {
      final String title = args.commandArg ?? defaultValue as String;
      final List<Article> articles = await getArticleByTitle(title);
      if (articles.isEmpty) {
        throw ArgumentsException(
          'No article found for title: $title',
          usage,
        );
      }

      final Article article = articles.first;
      final StringBuffer buffer =
          StringBuffer('\n=== ${article.title.titleText} ===\n\n');
      buffer.write(article.extract.split(' ').take(500).join(' '));
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
