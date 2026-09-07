
import 'package:flutter/material.dart';


import '../PageCross/CrossPage.dart';
import '../PageCross/ObstaclePage.dart';
import '../PageCross/PushupPage.dart';
import '../PageCross/StreetPage.dart';
import 'ProfilePage.dart';
import 'SettingsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  int clickCount = 0;



  late List<Widget> pages = [

    // HOME PAGE
    ListView(
      padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
      children: [

        exerciseCard("Cross system", "assets/iamg6.png", CrossPage()),
        const SizedBox(height: 20),

        exerciseCard("Street Workout", "assets/iamg5.png",
            StreetPage(title: null, image: null, description: null, bodyImage: null)),
        const SizedBox(height: 20),

        exerciseCard("Obstacle course", "assets/iamg3.png",
            ObstaclePage(title: null, image: null, description: null, bodyImage: null)),
        const SizedBox(height: 20),

        exerciseCard("weekly program", "assets/iamg4.png", PushupPage()),
      ],
    ),

    // SETTINGS PAGE
    const SettingsPage(),

    // PROFILE PAGE
    const ProfilePage(),

  ];

  get UnityAds => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1C1F2A),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },



        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

        ],

      ),
    );
  }

  Widget exerciseCard(String title, String image, Widget page) {
    return GestureDetector(
      onTap: () {

        clickCount++;

        if (clickCount % 3 == 0) {

          UnityAds.showVideoAd(
            placementId: "Interstitial_Android",

            onComplete: (placementId) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },

            onSkipped: (placementId) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
          );

        } else {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );

        }

      },
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.3),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }


}

