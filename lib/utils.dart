import 'package:flutter/material.dart';

class Nav {
  final NavigatorState _navigatorState;

  Nav(BuildContext context) : _navigatorState = Navigator.of(context);

  @optionalTypeArgs
  Future<T> push<T extends Object>(Widget page) {
    return _navigatorState.push(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  @optionalTypeArgs
  Future<T> pushBuilder<T extends Object>(
      Widget Function(BuildContext) pageBuilder) {
    return _navigatorState.push(
      MaterialPageRoute(
        builder: pageBuilder,
      ),
    );
  }

  @optionalTypeArgs
  Future<T> replace<T extends Object>(Widget page) {
    return _navigatorState.pushReplacement(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  @optionalTypeArgs
  bool pop<T extends Object>([T result]) {
    return _navigatorState.pop(result);
  }
}
