import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtb_pay_app/invoice_bloc.dart';
import 'package:vtb_pay_app/qr_renderer.dart';
import 'package:vtb_pay_app/user_bloc.dart';
import 'package:vtb_pay_app/utils.dart';

class MakeInvoicePage extends StatelessWidget {
  final int paymentSum;

  const MakeInvoicePage({@required this.paymentSum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MakeInvoicePage'),
      ),
      body: Column(
        children: <Widget>[
          Text('Общая сумма: $paymentSum руб'),
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
                        address: BlocProvider.of<UserBloc>(context).walletAddress,
                        amount: state.amount,
                        invoiceId: state.invoiceId,
                      ),
                      RaisedButton(
                        child: Text('Далее'),
                        onPressed: () {
                          BlocProvider.of<InvoiceBloc>(context)
                              .dispatch(InvoiceEventNext());
                        },
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
        Text('Осталось: $remaining руб'),
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
          Center(
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
          RaisedButton(
            child: Text('Сгенерировать QR-код'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                widget.onSubmit(amount: amount);
              }
            },
          ),
        ],
      ),
    );
  }
}