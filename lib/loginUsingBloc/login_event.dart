abstract class LoginEvent {}


class LoginTextChangedEvent extends LoginEvent{
  final String userNameValue;
  final String passwordValue;
  LoginTextChangedEvent({required this.userNameValue, required this.passwordValue});
}

class LoginSubmittedEvent extends LoginEvent{
  final String userNameValue;
  final String passwordValue;
  LoginSubmittedEvent({required this.userNameValue, required this.passwordValue});
}
