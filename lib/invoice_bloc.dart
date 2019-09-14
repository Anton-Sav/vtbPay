import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:vtb_pay_app/network.dart';

@immutable
abstract class InvoiceEvent {}

class InvoiceEventPay extends InvoiceEvent {
  final String address;
  final int amount;

  InvoiceEventPay({@required this.address, @required this.amount});
}

class InvoiceEventNext extends InvoiceEvent {}

@immutable
abstract class InvoiceState {
  final int remaining;

  InvoiceState({@required this.remaining});
}

class InvoiceStateEnteringAmount extends InvoiceState {
  InvoiceStateEnteringAmount({@required int remaining})
      : super(remaining: remaining);
}

class InvoiceStateSendingInvoice extends InvoiceState {
  InvoiceStateSendingInvoice({@required int remaining})
      : super(remaining: remaining);}

class InvoiceStateShowingQr extends InvoiceState {
  final int amount;

  InvoiceStateShowingQr({@required int remaining, @required this.amount})
      : super(remaining: remaining);
}

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final int totalAmount;

  InvoiceBloc({@required this.totalAmount});

  @override
  InvoiceState get initialState =>
      InvoiceStateEnteringAmount(remaining: totalAmount);

  @override
  Stream<InvoiceState> mapEventToState(InvoiceEvent event) async* {
    if (event is InvoiceEventPay) {
      final remaining = currentState.remaining - event.amount;
      yield InvoiceStateSendingInvoice(
        remaining: remaining,
      );
      await makeInvoice(
        recipientWalletId: event.address,
        paymentAmount: event.amount,
        description: 'test invoice',
      );
      yield InvoiceStateShowingQr(
        remaining: remaining,
        amount: event.amount,
      );
    }
    if (event is InvoiceEventNext) {
      yield InvoiceStateEnteringAmount(
        remaining: currentState.remaining,
      );
    }
  }
}
