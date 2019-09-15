import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:vtb_pay_app/repository_bloc.dart';

@immutable
abstract class UserEvent {}

@immutable
class UserState {}

class UserBloc extends Bloc<UserEvent, UserState> {
  final RepositoryStateLoggedIn data;

  UserBloc(this.data);

  @override
  UserState get initialState => UserState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {}
}
