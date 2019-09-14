import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';

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

  RepositoryStateLoggedIn({@required this.walletAddress});
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
      await Future.delayed(Duration(seconds: 1));
      yield RepositoryStateUnauthorised(); // TODO fetch wallet_address from local storage
    }
    if (event is RepositoryEventLogIn) {
      yield RepositoryStateLoading();
      await Future.delayed(Duration(seconds: 1));
      yield RepositoryStateLoggedIn(walletAddress: event.walletAddress);
    }
    if (event is RepositoryEventLogOut) {
      yield RepositoryStateLoading();
      await Future.delayed(Duration(seconds: 1));
      yield RepositoryStateUnauthorised();
    }
  }
}
