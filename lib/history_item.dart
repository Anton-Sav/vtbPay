import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtb_pay_app/data.dart';
import 'package:vtb_pay_app/network.dart';
import 'package:vtb_pay_app/user_bloc.dart';

class HistoryItem extends StatelessWidget {
  final String id;

  const HistoryItem(this.id);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<InvoiceStatus>(
      future: getInvoiceStatus(
        fpsId: BlocProvider.of<UserBloc>(context).data.session,
//        fpsId: 'd36dd20a-78ff-42a4-973c-3ccc935fae86',
        invoiceNumber: id,
        recipientWalletAddress:
            BlocProvider.of<UserBloc>(context).data.walletAddress,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (kDebugMode) {
            throw snapshot.error;
          }
          return Text(
            snapshot.error.toString(),
            style: TextStyle(color: Colors.red),
          );
        }
        if (!snapshot.hasData) {
          return LinearProgressIndicator(
              backgroundColor: Colors.red,
          );
        }
        return _Item(snapshot.data);
      },
    );
  }
}

class _Item extends StatelessWidget {
  final InvoiceStatus data;

  const _Item(this.data);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.description),
      subtitle: Text('State: ${data.state}'),
    );
  }
}
