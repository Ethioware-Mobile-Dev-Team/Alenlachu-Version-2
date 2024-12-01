import 'package:app/screens/client_screens/client_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/screens/common_screens/registration_option_screen.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>{
  final List<Map<String, String>> emotions = [
    {'emoji': '😇', 'name': 'joy'.tr},
    {'emoji': '😢', 'name': 'sadness'.tr},
    {'emoji': '😡', 'name': 'anger'.tr},
    {'emoji': '😰', 'name': 'anxiety'.tr},
    {'emoji': '🥱', 'name': 'boredom'.tr},
    {'emoji': '😤', 'name': 'frustration'.tr},
    {'emoji': '😎', 'name': 'confidence'.tr},
    {'emoji': '🤯', 'name': 'overwhelmed'.tr},
    {'emoji': '🤗', 'name': 'affection'.tr},
    {'emoji': '😴', 'name': 'tiredness'.tr},
    {'emoji': '🫣', 'name': 'embarrassment'.tr},
    {'emoji': '😐', 'name': 'neutrality'.tr},
  ];
  String ? selectedEmotion;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
      if (state is AppStarted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const RegistrationOptionScreen()),
              (Route<dynamic> route) => false,
        );
      }
    },
    builder: (BuildContext context, AuthenticationState state) {
    if (state is Authenticating) {
    return const Processing();
    }
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome to Alenilachu".tr, style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: emotions.length,
                      itemBuilder: (context, index) {
                        final emotion = emotions[index];
                        final isSelected = selectedEmotion == emotion['name'];
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedEmotion = emotion['name'];
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: isSelected
                                          ? appTheme.primaryColor
                                          : Colors.grey[300]!,
                                      width: 5
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      emotions[index]['emoji']!,
                                      style: const TextStyle(fontSize: 30),),
                                    const SizedBox(height: 5,),
                                    Text(
                                        emotions[index]['name']!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                            fontSize: 14
                                        )
                                    )
                                  ],
                                )));
                      }
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedEmotion == null) {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  AlertDialog(
                                    title: Text("No emotions selected".tr),
                                    content: Text(
                                        "Please select an emotion".tr),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text("Ok".tr))
                                    ],
                                  )
                          );
                        }
                        else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (
                                    context) => const ClientLandingPage()),
                                (Route<dynamic> route) => false,
                          );
                        };
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: appTheme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                      child: Text(
                        "Go to home".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16
                        ),
                      ),
                    )
                )
              ],
            ),
          )
      );
    }
    )
    );}
}
