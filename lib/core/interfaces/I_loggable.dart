// ignore_for_file: file_names

import 'package:logging/logging.dart';

mixin ILoggable<T> {
  static Logger logName(String name) => Logger(name);

  void Function(Object?, [Object?, StackTrace?]) get shout {
    return logName('$runtimeType').shout;
  }

  void Function(Object?, [Object?, StackTrace?]) get severe {
    return logName('$runtimeType').severe;
  }

  void Function(Object?, [Object?, StackTrace?]) get warning {
    return logName('$runtimeType').warning;
  }

  void Function(Object?, [Object?, StackTrace?]) get info {
    return logName('$runtimeType').info;
  }

  void Function(Object?, [Object?, StackTrace?]) get config {
    return logName('$runtimeType').config;
  }

  void Function(Object?, [Object?, StackTrace?]) get fine {
    return logName('$runtimeType').fine;
  }

  void Function(Object?, [Object?, StackTrace?]) get finer {
    return logName('$runtimeType').finer;
  }

  void Function(Object?, [Object?, StackTrace?]) get finest {
    return logName('$runtimeType').finest;
  }
}
