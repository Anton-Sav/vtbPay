import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtb_pay_app/login_page.dart';
import 'package:vtb_pay_app/repository_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VTBPayApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _SwitchPage(),
    );
  }
}

class _SwitchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RepositoryBloc>(
      builder: (context) => RepositoryBloc(),
      child: BlocBuilder<RepositoryBloc, RepositoryState>(
        builder: (context, state) {
          if (state is RepositoryStateLoading) {
            return _LoadingPage();
          }
          if (state is RepositoryStateUnauthorised) {
            return LoginPage();
          }
          if (state is RepositoryStateLoggedIn) {
            return _TabsPage();
          }
          return null;
        }
      ),
    );
  }
}

class _LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading'),
      ),
      body: Center(
        child: LinearProgressIndicator(),
      ),
    );
  }
}

class _TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabs'),
      ),
      body: Center(
        child: Text('TODO'),
      ),
    );
  }
}
