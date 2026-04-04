// TODO: Put public facing types in this file.

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:command_runner/src/arguments.dart';
import 'package:command_runner/src/exceptions.dart';

/// Checks if you are awesome. Spoiler: you are.
class CommandRunner {
  CommandRunner({this.onOutput,this.onError});
  final Map<String, Command> _commands = <String, Command>{};
  
  FutureOr<void> Function(Object)? onOutput;
  FutureOr<void> Function(Object)? onError;

  UnmodifiableSetView<Command> get commands =>
      UnmodifiableSetView(<Command>{..._commands.values});

  Future<void> run(List<String> inputs) async {
    try {
      final ArgResults results = parse(inputs);
      if (results.command != null) {
        Object? output = await results.command!.run(results);
        if(onOutput != null)
        {
          await onOutput!(output.toString());
        } 
        else
        {
          print(output.toString());
        }
      }
    } on Exception catch (ex) {
      if (onError == null) {
        rethrow;
      } else {
        onError!(ex);
      }
    }
  }

  ArgResults parse(List<String> inputs) {
    final ArgResults results = ArgResults();
    if (inputs.isEmpty) {
      return results;
    }

    if (_commands.containsKey(inputs.first)) {
      results.command = _commands[inputs.first];
      inputs = inputs.sublist(1);
    } else {
      throw ArgumentsException(
        'The first word of input must be a command',
        null,
        inputs.first,
      );
    }

    if (results.command != null &&
        inputs.isNotEmpty &&
        _commands.containsKey(inputs.first)) {
      throw ArgumentsException(
        'Input can only contain one command. Got ${inputs.first} and ${results.command!.name}',
        null,
        inputs.first,
      );
    }

    final Map<Option, Object?> inputOptions = {};
    int i = 0;
    while (i < inputs.length) {
      if (inputs[i].startsWith('-')) {
        final String base = _removeDash(inputs[i]);

        final Option option = results.command!.options.firstWhere(
          (option) => option.name == base || option.abbr == base,
          orElse: () {
            throw ArgumentsException(
              'Unknown option ${inputs[i]}',
              results.command!.name,
              inputs[i],
            );
          },
        );

        if (option.type == OptionType.flag) {
          inputOptions[option] = true;
          i++;
          continue;
        }

        if (i + 1 >= inputs.length) {
          throw ArgumentsException(
            'Option ${option.name} requires an argument',
            results.command!.name,
            option.name,
          );
        }
        if (inputs[i + 1].startsWith('-')) {
          throw ArgumentsException(
            'Option ${option.name} requires an argument, but got another option ${inputs[i + 1]}',
            results.command!.name,
            option.name,
          );
        }

        inputOptions[option] = inputs[i + 1];
        i += 2;
        continue;
      }

      if (results.commandArg != null && results.commandArg!.isNotEmpty) {
        throw ArgumentsException(
          'Command can only have up to one argument',
          results.command!.name,
          inputs[i],
        );
      }
      results.commandArg = inputs[i];
      i++;
    }

    results.options = inputOptions;
    return results;
  }

  String _removeDash(String input) {
    if (input.startsWith('--')) {
      return input.substring(2);
    }
    if (input.startsWith('-')) {
      return input.substring(1);
    }
    return input;
  }

  void addCommand(Command command) {
    _commands[command.name] = command;
    command.runner = this;
  }

  String get usage {
    final String exeFile = Platform.script.path.split('/').last;
    return 'Usage: dart bin/$exeFile <command> [commandArg?] [...options?]';
  }
}
