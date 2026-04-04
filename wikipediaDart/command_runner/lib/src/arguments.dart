import 'dart:async';
import 'dart:collection';

import 'package:command_runner/command_runner.dart';

enum OptionType {flag, option}


abstract class Arguments {
  String get name;
  String? get help;

  Object? get defaultValue;
  String? get valueHelp;

  String? get usage;

}

class Option extends Arguments{
 
  @override
  final String name;
  
  final OptionType type;

  @override
  final String? help;

  final String? abbr;

  @override
  final String? defaultValue;

  @override
  final String? valueHelp;
  
  @override
  String get usage{
    if(abbr != null)
    {
      return '-$abbr,--$name: $help';
    }
    return '--$name: $help';
  }
  Option(this.name,{required this.type,this.help,this.abbr,this.defaultValue,this.valueHelp,});
}

abstract class Command extends Arguments{
  
  @override
  final String name;
  
  String get description;

  bool get requiresArgument =>false;
  late CommandRunner runner;

  @override
  final String? help;


  @override
  final String? defaultValue;

  @override
  final String? valueHelp;
  
  final List<Option> _options = [];

  Command({required this.name, required this.help, required this.defaultValue, required this.valueHelp});

  UnmodifiableSetView<Option> get options => UnmodifiableSetView(_options.toSet());

  void addFlag(String name, {String? help, String? abbr, String? valueHelp})
  {
    _options.add(
      Option(name, help: help,abbr: abbr,valueHelp: valueHelp,type: OptionType.flag),
    );

  }
  void addOption(String name, {String? help, String? abbr, String? valueHelp})
  {
    _options.add(
      Option(name, help: help,abbr: abbr,valueHelp: valueHelp,type: OptionType.option),
    );

  }

  FutureOr<Object?> run(ArgResults args);
  
  @override
  // TODO: implement usage
  String? get usage 
  {
    return '$name: $description';
  }

}

class ArgResults extends Arguments {
  Command? command;
  String? commandArg;
  Map<Option, Object?> options ={};
  bool flag(String name){
    for( var option in options.keys.where( (option) => option.type == OptionType.flag) )
    {
      if(option.name == name)
      {
        return options[option] as bool;
      }
    }
    return false;
  }

  bool hasOption(String name)
  {
    return options.keys.any((option)=> option.name == name);

  }

  ({Option option, Object? input}) getOption(String name)
  {
    var mapEntry = options.entries.firstWhere((entry) => entry.key.name==name || entry.key.abbr == name );
    return (option: mapEntry.key , input: mapEntry.value);
  }
  
  @override
  // TODO: implement defaultValue
  Object? get defaultValue => throw UnimplementedError();
  
  @override
  // TODO: implement help
  String? get help => throw UnimplementedError();
  
  @override
  // TODO: implement name
  String get name => throw UnimplementedError();
  
  @override
  // TODO: implement usage
  String? get usage => throw UnimplementedError();
  
  @override
  // TODO: implement valueHelp
  String? get valueHelp => throw UnimplementedError();
}
