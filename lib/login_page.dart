import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtb_pay_app/assets.dart';
import 'package:vtb_pay_app/design.dart';
import 'package:vtb_pay_app/repository_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.theme),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              Text(
                '¥EEZY\nPAY',
                style: TextStyle(
                  fontSize: 50,
                  height: 1.3,
                  fontFamily: fontFamilyMontserrat,
                  color: Color.fromRGBO(255, 248, 248, 50),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              _LoginForm(
                onSubmit: ({String walletAddress}) {
                  BlocProvider.of<RepositoryBloc>(context).dispatch(
                      RepositoryEventLogIn(walletAddress: walletAddress));
                },
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
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
          Center(
            child: TextFormField(
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  fontFamily: fontFamilyMontserrat,
                  fontSize: 12,
                  color: Colors.black,
                ),
                hintText: 'Адрес кошелька',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
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
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 54,
            width: double.infinity,
            child: RaisedButton(
              color: MyColors.red,
              child: Text(
                'Войти',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: fontFamilyMontserrat,
                  fontSize: 12,
                ),
              ),
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
