import 'package:app/screens/client_screens/client_landing_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final List<Map<String, String>> emotions = [
    {'emoji': '😇', 'name': 'Joy'},
    {'emoji': '😢', 'name': 'Sadness'},
    {'emoji': '😡', 'name': 'Anger'},
    {'emoji': '😰', 'name': 'Anxiety'},
    {'emoji': '🥱', 'name': 'Boredom'},
    {'emoji': '😍', 'name': 'Love'},
    {'emoji': '😤', 'name': 'Frustration'},
    {'emoji': '🤔', 'name': 'Curiosity'},
    {'emoji': '😎', 'name': 'Confidence'},
    {'emoji': '🤯', 'name': 'Overwhelmed'},
    {'emoji': '🤗', 'name': 'Affection'},
    {'emoji': '😴', 'name': 'Tiredness'},
    {'emoji': '🫣', 'name': 'Embarrassment'},
    {'emoji': '😐', 'name': 'Neutrality'},
    {'emoji': '🤩', 'name': 'Excitement'},
    {'emoji': '🤝', 'name': 'Connection'},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[50],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to Alenlachu", style: TextStyle(fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: emotions.length,
                    itemBuilder: (context, index) {
                      return Column(
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
                                  color: Colors.black54
                              )
                          )
                        ],
                      );
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClientLandingPage()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent, 
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      )
                    ),
                    child: const Text(
                      "Go to home",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
              )
              )],
          ),
        )
    );
  }
}