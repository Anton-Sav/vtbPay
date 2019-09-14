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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '¥EEZY PAY',
          style: TextStyle(
            fontSize: 20,
            height: 1.5,
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(255, 71, 58, 50),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,

      ),
      body: SizedBox(
        child: Form(
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
      )
    );
  }
}
