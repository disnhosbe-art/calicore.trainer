import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _Notifications();
}

class _Notifications extends State<Notifications> {

  bool notifications = false;

  Widget section(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
            style: TextStyle(color: Colors.white),
            "Notifications"

        ),
        iconTheme: const IconThemeData(color: Colors.orange),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          section([

            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.notifications, color: Colors.white),
              ),

              title: const Text(
                "Notifications",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),

              trailing: Switch(
                value: notifications,
                activeThumbColor: Colors.orange,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),
            ),

          ])

        ],
      ),
    );
  }
}