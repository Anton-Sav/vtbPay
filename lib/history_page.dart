import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vtb_pay_app/history_list.dart';
import 'package:vtb_pay_app/local_storage.dart';
import 'package:vtb_pay_app/utils.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopNavigator(
      child: HistoryPage(),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'История',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(255, 71, 58, 50),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, List<String>>>(
        future: MyInvoices.getAll(),
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
            return LinearProgressIndicator();
          }
          return HistoryList(snapshot.data);
        },
      ),
    );
  }
}
