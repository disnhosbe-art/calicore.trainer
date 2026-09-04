import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Ads/banner_ad_widget .dart';
import '../Settings/AboutPage.dart';
import '../Settings/Notifications.dart';
import '../Settings/Privacy Policy.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget settingsTile(BuildContext context, IconData icon, Color color, String title, Widget page) {
    return ListTile(

      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white),
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 18,
      ),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
    );
  }

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
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [

        const SizedBox(height: 60),

        const Text(
          "Settings",
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        section([
          settingsTile(
            context,
            Icons.notifications,
            Colors.orange,
            "Notifications",
            const Notifications(),
          ),
        ]),

        section([
          settingsTile(
            context,
            Icons.description,
            Colors.grey,
            "Privacy Policy",
            const PrivacyPolicyPage(),
          ),
          const Divider(color: Colors.black),

          settingsTile(
            context,
            Icons.info,
            Colors.grey,
            "About",
            const AboutPage(),
          ),
        ]),

        const SizedBox(height: 20),

        const BannerAdWidget(),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1F2A),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Developer", style: TextStyle(color: Colors.grey)),
                  Text(
                    "SOFIANE SADOQ",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),

              const Divider(color: Colors.black),

              ListTile(
                leading: Image.asset(
                  "assets/instagram1.png",
                  width: 30,
                  height: 30,
                ),
                title: const Text(
                  "Follow on Instagram",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.open_in_new, color: Colors.grey),
                  onTap: () async {
                    try {
                      final Uri webUrl = Uri.parse("https://www.instagram.com/soufian_sadoq/");

                      await launchUrl(
                        webUrl,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      print("Error: $e");
                    }
                  }
              )

            ],
          ),
        )

      ],
    );
  }
}
