import 'package:calicore/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  String gender = "Choose Gender";
  String birthDate = "Date of Birth";
  String weight = "";
  String height = "";

  @override
  Widget build(BuildContext context) {

    double avatarSize = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      body: SafeArea(
        child: SingleChildScrollView( // 🔥 حل scroll
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                const SizedBox(height: 40),

                /// IMAGE
                CircleAvatar(
                  radius: avatarSize,
                  backgroundImage: const AssetImage("assets/iamg2.png"),
                  backgroundColor: Colors.transparent,
                ),

                const SizedBox(height: 25),

                const Text(
                  "Let’s complete your profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "It will help us to know more about you!",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 25),

                /// GENDER
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text("Male"),
                              onTap: () {
                                setState(() {
                                  gender = "Male";
                                });
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text("Female"),
                              onTap: () {
                                setState(() {
                                  gender = "Female";
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: buildField(Icons.person_outline, gender),
                ),

                const SizedBox(height: 15),

                /// DATE
                GestureDetector(
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );

                    if (date != null) {
                      setState(() {
                        birthDate =
                        "${date.day}/${date.month}/${date.year}";
                      });
                    }
                  },
                  child: buildField(Icons.calendar_today_outlined, birthDate),
                ),

                const SizedBox(height: 15),

                /// WEIGHT
                TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: inputStyle("Your Weight (KG)"),
                  onChanged: (value) => weight = value,
                ),

                const SizedBox(height: 15),

                /// HEIGHT
                TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: inputStyle("Your Height (CM)"),
                  onChanged: (value) => height = value,
                ),

                const SizedBox(height: 30),

                /// NEXT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {

                      print(gender);
                      print(birthDate);
                      print(weight);
                      print(height);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFD54F), Color(0xFFFFB300)],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(IconData icon, String text) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F2A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down, color: Colors.orange),
        ],
      ),
    );
  }

  InputDecoration inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: const Color(0xFF1C1F2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}