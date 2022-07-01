abstract class LoginState{}

class LoginInitialState extends LoginState{}

class LoginSuccessfullyState extends LoginState{}

class LoginSuccessfullyMessageState extends LoginState{
  LoginSuccessfullyMessageState();
}

class LoginErrorState extends LoginState{
  final String strErrorMessage;
  LoginErrorState(this.strErrorMessage);
}

class GetLoggedInUserValuesState extends LoginState{
  final String userName;
  final String password;
  GetLoggedInUserValuesState(this.userName, this.password);
}

