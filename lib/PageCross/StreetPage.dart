import 'package:calicore/home/ExercisePage.dart';
import 'package:flutter/material.dart';


class StreetPage extends StatefulWidget {
  const StreetPage({super.key, required title, required image, required description, required bodyImage});

  @override
  State<StreetPage> createState() => _CrossPageState();
}

class _CrossPageState extends State<StreetPage> {

  List<Map<String, String>> exercises = [

    {
      "title": "Pull-up",
      "image": "assets/22f.png",
      "description": "For strong legs -back and biceps",
      "bodyImage": "assets/body1.png",
    },

    {
      "title": "Chin-up",
      "image": "assets/44.png",
      "description": "For strong legs -back and biceps",
      "bodyImage": "assets/body1.png",
    },

    {
      "title": "Muscle-up",
      "image": "assets/33.png",
      "description": "Hard exercise for all upper-body muscles",
      "bodyImage": "assets/22fby.png",
    },

    {
      "title": "Knee raises",
      "image": "assets/77.png",
      "description": "Good for lower part of abdominal mus",
      "bodyImage": "assets/8877.png",
    },

    {
      "title": "Leg raises",
      "image": "assets/88.png",
      "description": "Good for lower part of abdominal mus",
      "bodyImage": "assets/8877.png",
    },




  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.orange),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          const Text(
            "Street Workout",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),

          const SizedBox(height: 30),


          ...List.generate(

              exercises.length, (index) {
            return exerciseCard(exercises[index], index);
          }),

        ],
      ),
    );
  }
  List<int> rating = [0,0,0,0,0,0,0,0,0];

  Widget exerciseCard(Map exercise, int index) {
    return Container(

      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: const Color(0xFF1C1F2A),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
          )
        ],
      ),

      child: Column(
        children: [

          ListTile(

            leading: const Icon(
              Icons.fitness_center,
              color: Colors.orange,
              size: 28,
            ),

            title: Text(
              exercise["title"]!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.orange,
              size: 18,
            ),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExercisePage(
                    title: exercise["title"]!,
                    image: exercise["image"]!,
                    description: exercise["description"]!,
                    bodyImage: exercise["bodyImage"]!,
                  ),
                ),
              );
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (starIndex) {
              return IconButton(

                icon: Icon(
                  Icons.star,
                  color: starIndex < rating[index]
                      ? Colors.orange
                      : Colors.black26,
                ),

                onPressed: () {
                  setState(() {
                    rating[index] = starIndex + 1;
                  });
                },

              );
            }),
          )

        ],
      ),
    );
  }
}