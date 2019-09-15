import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtb_pay_app/invoice_bloc.dart';
import 'package:vtb_pay_app/qr_renderer.dart';
import 'package:vtb_pay_app/user_bloc.dart';
import 'package:vtb_pay_app/utils.dart';
import 'package:vtb_pay_app/design.dart';

class MakeInvoicePage extends StatelessWidget {
  final int paymentSum;

  const MakeInvoicePage({@required this.paymentSum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Общая сумма: $paymentSum руб',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontSize: 20,
              ),
            ),
          ),
          BlocProvider<InvoiceBloc>(
            builder: (context) => InvoiceBloc(totalAmount: paymentSum),
            child: BlocBuilder<InvoiceBloc, InvoiceState>(
              builder: (context, state) {
                if (state is InvoiceStateEnteringAmount) {
                  return _EnterAmount(remaining: state.remaining);
                }
                if (state is InvoiceStateSendingInvoice) {
                  return LinearProgressIndicator();
                }
                if (state is InvoiceStateShowingQr) {
                  return Column(
                    children: <Widget>[
                      Text('Платёж на ${state.amount} руб'),
                      QrRenderer(
                        address:
                            BlocProvider.of<UserBloc>(context).walletAddress,
                        amount: state.amount,
                        invoiceId: state.invoiceId,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: SizedBox(
                            width: 260,
                            height: 42,
                            child: RaisedButton(
                              color: MyColors.red,
                              child: Text(
                                'Далее',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<InvoiceBloc>(context)
                                    .dispatch(InvoiceEventNext());
                              },
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                        child: Text('Завершить'),
                        onPressed: () {
                          Nav(context).pop();
                        },
                      ),
                    ],
                  );
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EnterAmount extends StatelessWidget {
  final int remaining;

  const _EnterAmount({@required this.remaining});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Text('Осталось: $remaining руб',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontSize: 20,
          ),
        ),
        _EnterAmountForm(
          maxAmount: remaining,
          onSubmit: ({amount}) {
            BlocProvider.of<InvoiceBloc>(context).dispatch(
              InvoiceEventPay(
                address: BlocProvider.of<UserBloc>(context).walletAddress,
                amount: amount,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _EnterAmountForm extends StatefulWidget {
  final int maxAmount;
  final void Function({@required int amount}) onSubmit;

  _EnterAmountForm({@required this.maxAmount, @required this.onSubmit});

  @override
  _EnterAmountFormState createState() => _EnterAmountFormState();
}

class _EnterAmountFormState extends State<_EnterAmountForm> {
  final _formKey = GlobalKey<FormState>();

  int amount;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Сумма платежа',
                ),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите cумму';
                  }
                  final amount = int.parse(value);
                  if (amount > widget.maxAmount) {
                    return 'Сумма должна быть меньше остатка';
                  }
                  return null;
                },
                onSaved: (value) {
                  amount = int.parse(value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SizedBox(
                width: 260,
                height: 42,
                child: RaisedButton(
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
                      widget.onSubmit(amount: amount);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
