import 'package:calicore/home/ExercisePage.dart';
import 'package:flutter/material.dart';




class CrossPage extends StatefulWidget {
  const CrossPage({super.key});

  @override
  State<CrossPage> createState() => _CrossPageState();
}

class _CrossPageState extends State<CrossPage> {

  List<Map<String, String>> exercises = [

    {
      "title": "Incline pull-up",
      "image": "assets/fix1.png",
      "description": "Strengthens choulder muscles and elbow flexors",
      "bodyImage": "assets/body1.png",
    },

    {
      "title": "One-arm pull-up",
      "image": "assets/fxe9.png",
      "description": "Good for core, shoulder and arm muscles",
      "bodyImage": "assets/body1.png",
    },

    {
      "title": "Biceps curl",
      "image": "assets/fxe2.png",
      "description": "Strengthens elbows flexors",
      "bodyImage": "assets/body2.png",
    },

    {
      "title": "Bulgarian split squat",
      "image": "assets/fxe8.png",
      "description": "For strong quads and gultes plus balance",
      "bodyImage": "assets/body8.png",
    },

    {
      "title": "Inverted crunches push-up",
      "image": "assets/fxe5.png",
      "description": "For strong core, chest and arms",
      "bodyImage": "assets/body6.png",
    },

    {
      "title": "Inverted crunches push-up",
      "image": "assets/fxe4.png",
      "description": "For strong core, chest and arms",
      "bodyImage": "assets/body5.png",
    },

    {
      "title": "Reverse flyes",
      "image": "assets/fxe6.png",
      "description": "Trains back muscles",
      "bodyImage": "assets/body9.png",
    },

    {
      "title": "Squat",
      "image": "assets/fxe7.png",
      "description": "For strong legs - with support",
      "bodyImage": "assets/body10.png",
    },

    {
      "title": "Triceps press",
      "image": "assets/fxe3.png",
      "description": "Good for strong triceps",
      "bodyImage": "assets/body11.png",
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
            "Cross System",
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