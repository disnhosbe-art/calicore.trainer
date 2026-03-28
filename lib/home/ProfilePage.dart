import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController pushController = TextEditingController();
  TextEditingController pullController = TextEditingController();
  TextEditingController plankController = TextEditingController();

  String name = "";
  String level = "";

  Widget customField(TextEditingController controller, String hint, {bool number = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  void calculateLevel() {

    int push = int.tryParse(pushController.text) ?? 0;
    int pull = int.tryParse(pullController.text) ?? 0;
    int plank = int.tryParse(plankController.text) ?? 0;

    if (push < 15 && pull < 5 && plank < 40) {
      level = "Beginner 🟢";
    } else if (push < 35 && pull < 10 && plank < 90) {
      level = "Intermediate 🟡";
    } else {
      level = "Advanced 🔴";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,



      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 100),

            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage("assets/iamg2.png"),
              backgroundColor: Colors.transparent,
            ),

            const SizedBox(height: 30),

            customField(nameController, "Your Name"),
            const SizedBox(height: 20),

            customField(pushController, "Max Push-ups", number: true),
            const SizedBox(height: 20),

            customField(pullController, "Max Pull-ups", number: true),
            const SizedBox(height: 20),

            customField(plankController, "Plank seconds", number: true),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal:40,vertical:15),
              ),
              onPressed: () {

                setState(() {

                  name = nameController.text;

                  calculateLevel();

                });

              },
              child: const Text("Check My Level"),
            ),

            const SizedBox(height: 30),

            if(level.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1F2A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    Text(
                      "Welcome $name",
                      style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height:10),

                    Text(
                      "Your Level",
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize:16
                      ),
                    ),

                    const SizedBox(height:5),

                    Text(
                      level,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize:22,
                          fontWeight: FontWeight.bold
                      ),
                    )

                  ],
                ),
              )

          ],
        ),
      ),
    );
  }
}