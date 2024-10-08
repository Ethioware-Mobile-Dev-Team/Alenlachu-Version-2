import 'dart:developer';

import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/core/app.dart';
import 'package:app/core/language/language_manager.dart';
import 'package:app/firebase_options.dart';
import 'package:app/services/common/authentication_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final Locale? lang = await LanguageManager.getPreferredLanguage();
    runApp(BlocProvider(
      create: (context) => AuthenticationCubit(
        authenticationService: AuthenticationService(),
      ),
      child: MainApp(
        lang: lang,
      ),
    ));
  } catch (e) {
    log(e.toString());
  }
}
