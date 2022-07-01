import 'package:bloc_demo/loginUsingBloc/login_bloc.dart';
import 'package:bloc_demo/loginUsingBloc/login_event.dart';
import 'package:bloc_demo/loginUsingBloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(const MyAppScreen());
}

bool isChecked = false;

class MyAppScreen extends StatefulWidget {
  const MyAppScreen({Key? key}) : super(key: key);

  @override
  MyAppScreenState createState() => MyAppScreenState();
}

class MyAppScreenState extends State<MyAppScreen> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const SignInClass(),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}

class SignInClass extends StatefulWidget {
  const SignInClass({Key? key}) : super(key: key);

  @override
  State<SignInClass> createState() => _SignInClassState();
}

class _SignInClassState extends State<SignInClass> {
  final controllerEmailId = TextEditingController();
  final controllerPassword = TextEditingController();
  final FocusNode focusNodeEmailId = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginErrorState) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.strErrorMessage,
                                      style: const TextStyle(
                                          fontSize: 18.0, color: Colors.teal),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.teal),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              cursorColor: Colors.teal,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              focusNode: focusNodeEmailId,
                              controller: controllerEmailId,
                              onChanged: (text) {
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoginTextChangedEvent(
                                        passwordValue: controllerPassword.text,
                                        userNameValue: controllerEmailId.text));
                              },
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.blueGrey),
                              decoration: const InputDecoration(
                                hintText: "Type here",
                                hintStyle:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Password",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.teal),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            child: TextField(
                              cursorColor: Colors.teal,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              focusNode: focusNodePassword,
                              controller: controllerPassword,
                              onChanged: (text) {
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoginTextChangedEvent(
                                        passwordValue: controllerPassword.text,
                                        userNameValue: controllerEmailId.text));
                              },
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.blueGrey),
                              decoration: const InputDecoration(
                                hintText: "Type here",
                                hintStyle:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    value: isChecked,
                                    onChanged: (bool? value) {},
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Remember Me',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                    //                child: new Row(
                                  ),
                                ],
                              )),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginSuccessfullyMessageState) {
                                print('objectasssssss');
                              }
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 20, right: 20),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: OutlinedButton(
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.teal,
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.blue,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    onPressed: () async {
                                      BlocProvider.of<LoginBloc>(context)
                                          .add(LoginSubmittedEvent());
                                      /*if (controllerEmailId.text.isEmpty) {
                                    showToast("Please enter email",
                                        duration: Toast.lengthShort,
                                        gravity: Toast.bottom);
                                  } else if (controllerPassword.text.isEmpty) {
                                    showToast("Please enter password",
                                        duration: Toast.lengthShort,
                                        gravity: Toast.bottom);
                                  } else if (controllerEmailId.text ==
                                      "radhika" &&
                                      controllerPassword.text == "123") {
                                    await sharedPreferencesUtils.setBoolean(
                                        isUserLogin, true);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const ListViewScreen()),
                                    );
                                  } else {
                                    showToast("Incorrect username or password",
                                        duration: Toast.lengthShort,
                                        gravity: Toast.bottom);
                                  }
                                */
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 0, right: 0),
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'By logging in you agree to '),
                                    TextSpan(
                                        text: 'Terms & Conditions',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ]),
                              //                child: new Row(
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  String? get emailValidation {
    final textEmail = controllerEmailId.value.text;
    if (textEmail.isEmpty) {
      return 'Please enter email';
    }
    return null;
  }

  String? get passwordValidation {
    final textPassword = controllerPassword.value.text;
    if (textPassword.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.grey;
  }
  return Colors.grey;
}
