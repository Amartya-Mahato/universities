import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universities/logic/bloc/auth_bloc.dart';
import 'package:universities/logic/event/auth_event.dart';
import 'package:universities/logic/state/auth_state.dart';

String? email;
String? pass;

enum Type { isName, isEmail, isPass }

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100, bottom: 100),
                child: Text(
                  'Login/Register',
                  style: TextStyle(fontSize: 40),
                ),
              ),
              _textField(
                  context: context,
                  hintText: 'Email',
                  icon: const Icon(Icons.mail_rounded),
                  type: Type.isEmail),
              _textField(
                  context: context,
                  hintText: 'Password',
                  icon: const Icon(Icons.password_rounded),
                  type: Type.isPass),
              _confirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(
      {required BuildContext context,
      required String hintText,
      required Icon icon,
      required Type type}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (authContext, state) {
          return TextField(
            keyboardType:
                type == Type.isEmail ? TextInputType.emailAddress : null,
            onChanged: (value) {
              if (type == Type.isEmail) {
                email = value;
              } else if (type == Type.isPass) {
                pass = value;
              }
            },
            decoration: InputDecoration(
              prefixIcon: icon,
              hintText: hintText,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 5.0,
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget _confirmButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (authContext, state) {
        _checker(state, authContext);
      },
      builder: (authContext, state) {
        return state == const AuthStateLoading(email: null)
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  if (email != null &&
                      pass != null &&
                      email!.isNotEmpty &&
                      pass!.isNotEmpty) {
                    authContext
                        .read<AuthBloc>()
                        .add(AuthEventLogIn(email: email!, password: pass!));
                  } else {
                    ScaffoldMessenger.of(authContext).showSnackBar(
                        const SnackBar(
                            content: Text('Fields can not be empty')));
                  }
                },
                child: const Text('Confirm'));
      },
    );
  }

  void _checker(AuthState state, BuildContext authContext) {
    if (state == AuthStateLogedIn(email: email)) {
      ScaffoldMessenger.of(authContext)
          .showSnackBar(const SnackBar(content: Text('Successful')));

      Future.delayed(const Duration(seconds: 1));

      SharedPreferences.getInstance().then((value) {
        value.setString('email', email!);
      });

      Navigator.pushNamedAndRemoveUntil(authContext, '/formPage', ((route) => false));
    } else if (state == AuthStateRegisterd(email: email)) {
      ScaffoldMessenger.of(authContext)
          .showSnackBar(const SnackBar(content: Text('Successful')));

      Future.delayed(const Duration(seconds: 1));

      SharedPreferences.getInstance().then((value) {
        value.setString('email', email!);
      });

      Navigator.pushNamedAndRemoveUntil(authContext, '/formPage', ((route) => false));
    } else if (state == const AuthStateLogInFailed(email: null)) {
      if (email != null &&
          pass != null &&
          email!.isNotEmpty &&
          pass!.isNotEmpty) {
        authContext
            .read<AuthBloc>()
            .add(AuthEventRegister(email: email!, password: pass!));
      } else {
        ScaffoldMessenger.of(authContext).showSnackBar(
            const SnackBar(content: Text('Fields can not be empty')));
      }
    } else if (state == const AuthStateRegisterFailed(email: null)) {
      ScaffoldMessenger.of(authContext)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }
}
