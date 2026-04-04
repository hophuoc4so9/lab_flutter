import 'package:cli/cli.dart';
import 'package:command_runner/command_runner.dart';

void main(List<String> arguments) async {
  final errorLogger = initFileLogger('errors');

  final runner = CommandRunner(
    onOutput: (Object output) async {
      await write(output.toString());
    },
    onError: (Object error) {
      if (error is Error) {
        errorLogger.severe('[Error] ${error.toString()}\n${error.stackTrace}');
        throw error;
      }

      if (error is Exception) {
        errorLogger.warning(error.toString());
      }
    },
  )
    ..addCommand(HelpCommand())
    ..addCommand(SearchCommand(logger: errorLogger))
    ..addCommand(GetArticleCommand(logger: errorLogger));

  await runner.run(arguments);
}