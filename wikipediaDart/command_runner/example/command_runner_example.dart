import 'dart:async';

import 'package:command_runner/command_runner.dart';

class PrettyEcho extends Command{
  PrettyEcho() : super(name: '', help: '', defaultValue: '', valueHelp: '') {
    addFlag(
      'blue-only',
      abbr: 'b',
      help: 'When true, this command will only print blue text',
    );
  }
  @override
  String get name => 'echo';
  @override 
  bool get requiresArgument => true;


  @override
  // TODO: implement description
  String get description => "Print input, colorful!";
  @override
  String get help => "Echos a string provided as an argument with ANSI coloring";
  @override
  FutureOr<Object?> run(Arguments args) {
    final ArgResults results = args as ArgResults;
    if (results.commandArg == null) {
      throw ArgumentsException(
        'This command requires an argument',
        name,
      );
    }
    List<String> prettyWords = [];

    var words = results.commandArg!.split(' ');
    for (var i = 0; i < words.length; i++) {
      var word = words[i];
      switch (i % 3) {
        case 0:
          prettyWords.add(word.titleText);
          break;
        case 1:
          prettyWords.add(word.errorText);
          break;
        case 2:
          prettyWords.add(word.instructionText);
          break;
      }
    }
    return prettyWords.join(' ');
  }

  

}

void main(List<String> arguments) {
  final runner = CommandRunner()..addCommand(PrettyEcho());

  runner.run(arguments);
}