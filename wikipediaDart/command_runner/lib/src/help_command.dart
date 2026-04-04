import 'dart:async';
import 'dart:developer';

import 'package:command_runner/command_runner.dart';
import 'package:command_runner/src/arguments.dart';
import 'package:command_runner/src/console.dart';
class HelpCommand extends Command {
  HelpCommand() : super(name: '', help: '', defaultValue: '', valueHelp: '') 
  {
    addFlag(
      'verbose',
      abbr: 'v',
      help: 
        "When true, this command will print each command and its options",
    );
    addOption(
      'command',
      abbr: 'v',
      help: 
        "When a command is passed as a argument, print only that command's verbose usage",
    );
  }
  
  @override
  // TODO: implement name
  String get name => "help";

  @override
  // TODO: implement description
  String get description => 'Prints usage information to the command line.';

  @override
  // TODO: implement help
  String? get help => 'Prints usage information.';

  @override
  FutureOr<Object?> run(ArgResults args)  async {
    final buffer = StringBuffer();
    buffer.write(runner.usage.titleText);

    if(args.flag('verbose')){
      for( var cmd in runner.commands)
      {
        buffer.write(_renderCommand(cmd));

      }

    }
    if(args.hasOption('command'))
    {
      var (:option, :input) = args.getOption('command');
      
      var cmd = runner.commands.firstWhere(
        (cmd) => cmd.name == input, 
        orElse: () => throw ArgumentsException('Input ${args.commandArg} is not a known command'));
      return _renderCommand(cmd); 
    }
    for (var cmd in runner.commands)
    {
      buffer.writeln('${cmd.usage}');
    }
    return buffer.toString();
  }
}

String _renderCommand(Command cmd)
{
  final indent = ' ' * 10;
  final buffer = StringBuffer();  
  buffer.write(cmd.name.instructionText);
  buffer.write('$indent${cmd.help}');

  if(cmd.valueHelp != null)
  {
    buffer.writeln('\n$indent [Argument] Required ${cmd.requiresArgument}, Type: ${cmd.valueHelp}. Default: ${cmd.defaultValue ?? 'None'} ');
  }
  buffer.writeln('$indent Options:');
  for(var option in cmd.options)
  {
    buffer.writeln('$indent ${option.usage}');
  }
  return buffer.toString();

}