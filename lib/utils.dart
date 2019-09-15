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

class SmartScroll extends StatelessWidget {
  final Widget child;

  const SmartScroll({@required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: child,
            ),
          ),
        );
      },
    );
  }
}


class PopNavigator extends StatefulWidget {
  final Widget child;

  const PopNavigator({@required this.child});

  @override
  _PopNavigatorState createState() => _PopNavigatorState();
}

class _PopNavigatorState extends State<PopNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) {
              return widget.child;
            },
          );
        },
      ),
      onWillPop: () async {
        return !await _navigatorKey.currentState.maybePop();
      },
    );
  }
}
