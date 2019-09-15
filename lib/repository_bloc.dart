import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:vtb_pay_app/local_storage.dart';
import 'package:vtb_pay_app/network.dart';

@immutable
abstract class RepositoryEvent {}

class _RepositoryEventInit extends RepositoryEvent {}

class RepositoryEventLogIn extends RepositoryEvent {
  final String walletAddress;

  RepositoryEventLogIn({@required this.walletAddress});
}

class RepositoryEventLogOut extends RepositoryEvent {}

@immutable
abstract class RepositoryState {}

class RepositoryStateLoading extends RepositoryState {}

class RepositoryStateUnauthorised extends RepositoryState {}

class RepositoryStateLoggedIn extends RepositoryState {
  final String walletAddress;
  final String session;

  RepositoryStateLoggedIn({
    @required this.walletAddress,
    @required this.session,
  });
}

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  RepositoryBloc() {
    dispatch(_RepositoryEventInit());
  }

  @override
  RepositoryState get initialState => RepositoryStateLoading();

  @override
  Stream<RepositoryState> mapEventToState(RepositoryEvent event) async* {
    if (event is _RepositoryEventInit) {
      yield RepositoryStateLoading();
      if (await WalletAddress.exists()) {
        final walletAddress = await WalletAddress.load();
        final session = await makeSession(address: walletAddress);
        yield RepositoryStateLoggedIn(
          walletAddress: walletAddress,
          session: session,
        );
      } else {
        yield RepositoryStateUnauthorised();
      }
    }
    if (event is RepositoryEventLogIn) {
      yield RepositoryStateLoading();
      await WalletAddress.save(event.walletAddress);
      final session = await makeSession(address: event.walletAddress);
      yield RepositoryStateLoggedIn(
        walletAddress: event.walletAddress,
        session: session,
      );
    }
    if (event is RepositoryEventLogOut) {
      yield RepositoryStateLoading();
      await WalletAddress.delete();
      yield RepositoryStateUnauthorised();
    }
  }
}
