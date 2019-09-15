import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtb_pay_app/design.dart';
import 'package:vtb_pay_app/repository_bloc.dart';
import 'package:vtb_pay_app/user_bloc.dart';
import 'package:vtb_pay_app/utils.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopNavigator(
      child: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('П Р О Ф И Л Ь'),
      body: ListView(
        children: <Widget>[
          _WalletAddress(),
          Divider(height: 0),
          _Logout(),
          Divider(height: 0),
        ],
      ),
    );
  }
}

class _WalletAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final walletAddress = BlocProvider.of<UserBloc>(context).data.walletAddress;
    return ListTile(
      title: Text('Адрес кошелька'),
      subtitle: Text(walletAddress),
      trailing: Icon(Icons.content_copy),
      onTap: () {
        Clipboard.setData(
          ClipboardData(
            text: walletAddress,
          ),
        );
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Адрес скопирован'),
          ),
        );
      },
    );
  }
}

class _Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Выйти'),
      onTap: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Выйти из аккаунта?'),
              content: Text('Данные вашего кошелька будут удалены с устройства'),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.blue,
                  child: Text('ОТМЕНА'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  textColor: Colors.red,
                  child: Text('ВЫЙТИ'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );
        if (result != null && result) {
          BlocProvider.of<RepositoryBloc>(context)
              .dispatch(RepositoryEventLogOut());
        }
      },
    );
  }
}

