import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientEmotionalState extends StatefulWidget {
  const ClientEmotionalState({super.key});

  @override
  State<ClientEmotionalState> createState() => _ClientEmotionalStateState();
}

class _ClientEmotionalStateState extends State<ClientEmotionalState> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              buildCard('assets/images/sad.png', Colors.red.withOpacity(0.5),
                  () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  "I'm sorry to hear that you're feeling sad. Hope things get better soon.",
                  maxLines: 10,
                )));
              }),
              const SizedBox(
                height: 5,
              ),
              Text(
                'sad'.tr,
                style: appTheme.textTheme.bodySmall,
              )
            ],
          ),
          Column(
            children: [
              buildCard(
                  'assets/images/confused.png', Colors.yellow.withOpacity(0.5),
                  () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("It's okay to have a neutral day. Take care!",
                        maxLines: 10)));
              }),
              const SizedBox(
                height: 5,
              ),
              Text(
                'normal'.tr,
                style: appTheme.textTheme.bodySmall,
              )
            ],
          ),
          Column(
            children: [
              buildCard(
                  'assets/images/gestures.png', Colors.grey.withOpacity(0.5),
                  () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Glad to know you're feeling happy!",
                        maxLines: 10)));
              }),
              const SizedBox(
                height: 5,
              ),
              Text(
                'happy'.tr,
                style: appTheme.textTheme.bodySmall,
              )
            ],
          ),
          Column(
            children: [
              buildCard(
                  'assets/images/laughing.png', Colors.blue.withOpacity(0.5),
                  () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text("It's great to see you so happy!", maxLines: 10)));
              }),
              const SizedBox(
                height: 5,
              ),
              Text(
                'excited'.tr,
                style: appTheme.textTheme.bodySmall,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildCard(String image, Color color, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Image.asset(image),
      ),
    );
  }
}
