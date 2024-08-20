import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conta/config/routes/router.dart';
import 'package:conta/screens/login/bloc/login_bloc.dart';
import 'package:local_auth/local_auth.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});
  static const String _urlAsset = "assets/images/bgimg1.png";
  static const String _buttonText = "ACESSAR";

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(InitialScreen._urlAsset, height: 200),
            const SizedBox(height: 20),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Falha ao realizar login"),
                    ),
                  );
                }
                if (state.status == LoginStatus.success) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.home,
                    (Route<dynamic> route) => false,
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () async {
                    NavigatorState navigator = Navigator.of(context);
                    if (state.user == null ||
                        state.user!.username.isEmpty ||
                        state.user!.password.isEmpty) {
                      navigator.pushNamed(Routes.login);
                      return;
                    }
                    LoginBloc loginBloc = context.read<LoginBloc>();
                    try {
                      final bool didAuthenticate = await auth.authenticate(
                        localizedReason:
                            'Autentique-se para acessar o aplicativo',
                        options:
                            const AuthenticationOptions(useErrorDialogs: false),
                      );
                      if (didAuthenticate) {
                        loginBloc.add(
                          PerformLoginEvent(
                            username: state.user!.username,
                            password: state.user!.password,
                          ),
                        );
                      }
                    } catch (e) {
                      navigator.pushNamed(Routes.login);
                    }
                  },
                  child: const Text(InitialScreen._buttonText),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
