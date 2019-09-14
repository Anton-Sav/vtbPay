import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vtb_pay_app/make_invoice_page.dart';
import 'package:vtb_pay_app/utils.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final _formKey = GlobalKey<FormState>();

  String aaa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InvoicePage'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Введите общую сумму счёта',
              ),
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Введите сумму';
                }
                return null;
              },
              onSaved: (value) {
                aaa = value;
              },
            ),
            RaisedButton(
              child: Text('Собрать деньги'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  int paymentSum = int.parse(aaa);
                  Nav(context).push(
                    MakeInvoicePage(
                      paymentSum: paymentSum,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
