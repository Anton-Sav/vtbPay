import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final _formKey = GlobalKey<FormState>();

  String aaa, bbb;

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
              keyboardType: TextInputType.number,
              onSaved: (value) {
                aaa = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Введите количество людей"),
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              onSaved: (value) {
                bbb = value;
              },
            ),
            RaisedButton(
              child: Text('ccc'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(aaa + '@' + bbb)));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
