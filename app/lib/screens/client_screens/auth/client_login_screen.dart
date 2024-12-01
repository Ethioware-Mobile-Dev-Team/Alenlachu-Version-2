import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/client_screens/client_landing_page.dart';
import 'package:app/screens/client_screens/main/splash_screen.dart';
import 'package:app/widgets/client/auth/client_login_form.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ClientLoginScreen extends StatefulWidget {
  const ClientLoginScreen({super.key});

  @override
  State<ClientLoginScreen> createState() => _ClientLoginScreenState();
}

class _ClientLoginScreenState extends State<ClientLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedAsClient) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashScreen()),
              (Route<dynamic> route) => false,
            );
          } else if (state is UnauthenticatedClient) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is Authenticating) {
            return const Processing();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 50, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.35,
                    width: size.width,
                    child: Image.asset('assets/images/welcome.png'),
                  ),
                  Text(
                    'welcome'.tr,
                    style: appTheme.textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const ClientLoginForm(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
