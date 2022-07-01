import 'package:bloc_demo/loginUsingBloc/login_event.dart';
import 'package:bloc_demo/loginUsingBloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginTextChangedEvent>((event, emit) {
      if (event.userNameValue == "") {
        emit(LoginErrorState("Please enter username"));
      } else if (event.passwordValue == "" || event.passwordValue.length <= 1) {
        emit(LoginErrorState("Please enter password"));
      } else {
        LoginSuccessfullyState();
      }
    });

    on<LoginSubmittedEvent>((event, emit) {
      print('Hello object');
      emit(LoginSuccessfullyMessageState());
    });
  }
}
