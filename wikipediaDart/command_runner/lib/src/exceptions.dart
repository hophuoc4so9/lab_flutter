class ArgumentsException extends FormatException{
  final String? command;

  final String? argumentName;
  ArgumentsException(
    super.message,
    [this.command, this.argumentName,super.source,super.offset,
    ]);
  @override
  String toString() {
    // TODO: implement toString
    return 'ArgumentException: $message';
  }
}