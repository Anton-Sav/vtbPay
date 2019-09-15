import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vtb_pay_app/design.dart';
import 'package:vtb_pay_app/make_invoice_page.dart';
import 'package:vtb_pay_app/utils.dart';

class InvoiceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopNavigator(
      child: InvoicePage(),
    );
  }
}

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final _formKey = GlobalKey<FormState>();

  int paymentSum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            '¥EEZY PAY',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              color: Color.fromRGBO(255, 71, 58, 50),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child:  Container(
            child: SizedBox(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image(
                        image: AssetImage('assets/invoice.jpg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:6.0, horizontal: 16.0),
                      child: Text(
                        'Поделить\nсчет',
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      child: Text(
                        'Invoice',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          color: Color.fromRGBO(	212, 212, 212, 50),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'RUB',
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
                          paymentSum = int.parse(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                      child: Text(
                        'Введите общую сумму\n счета',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          color: Color.fromRGBO(	212, 212, 212, 50),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: SizedBox(
                          width: 260,
                          height: 42,
                          child:RaisedButton(
                            color: MyColors.red,
                            child: Text(
                              'Собрать деньги',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                Nav(context).push(
                                  MakeInvoicePage(
                                    paymentSum: paymentSum,
                                  ),
                                );
                              }
                            },
                          ) ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
