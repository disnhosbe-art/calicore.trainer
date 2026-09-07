import 'package:calicore/home/ExercisePage.dart';
import 'package:flutter/material.dart';


class ObstaclePage extends StatefulWidget {
  const ObstaclePage({super.key, required title, required image, required description, required bodyImage});

  @override
  State<ObstaclePage> createState() => _CrossPageState();
}

class _CrossPageState extends State<ObstaclePage> {

  List<Map<String, String>> exercises = [

    {
      "title": "Hurdles run",
      "image": "assets/11.png",
      "description": "Coordination and cardio",
      "bodyImage": "assets/body3.png",
    },

    {
      "title": "Hurdles jump",
      "image": "assets/11.png",
      "description": "Coordination and cardio",
      "bodyImage": "assets/body3.png",
    },

    {
      "title": "Hurdles crawl",
      "image": "assets/66.png",
      "description": "Coordination and cardio",
      "bodyImage": "assets/body6.png",
    },

    {
      "title": "Turbo challenger",
      "image": "assets/55.png",
      "description": "For strong upper- back and biceps",
      "bodyImage": "assets/body1.png",
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
            "Obstacle curse",
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
  List<int> rating = [0,0,0,0,];

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