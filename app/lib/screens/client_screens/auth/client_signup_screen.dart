import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/client_screens/client_landing_page.dart';
import 'package:app/screens/client_screens/main/client_home_screen.dart';
import 'package:app/widgets/client/auth/client_signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientSignupScreen extends StatefulWidget {
  const ClientSignupScreen({super.key});

  @override
  State<ClientSignupScreen> createState() => _ClientSignupScreenState();
}

class _ClientSignupScreenState extends State<ClientSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedAsClient) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const ClientLandingPage()),
              (Route<dynamic> route) => false,
            );
          } else if (state is UnauthenticatedClient) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 50, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Let's Get Started!",
                  style: appTheme.textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 35,
                ),
                const ClientSignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
