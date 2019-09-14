import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtb_pay_app/repository_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _LoginForm(
          onSubmit: ({String walletAddress}) {
            BlocProvider.of<RepositoryBloc>(context)
                .dispatch(RepositoryEventLogIn(walletAddress: walletAddress));
          },
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  final void Function({@required String walletAddress}) onSubmit;

  _LoginForm({@required this.onSubmit});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String walletAddress;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Адрес кошелька',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Введите адрес';
              }
              if (value.length != 10) {
                return 'Длина адреса должна быть 10 символов';
              }
              return null;
            },
            onSaved: (value) {
              walletAddress = value;
            },
          ),
          SizedBox(height: 8),
          Center(
            child: RaisedButton(
              child: Text('Войти'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  widget.onSubmit(walletAddress: walletAddress);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

