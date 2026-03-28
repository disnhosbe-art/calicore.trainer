import 'package:flutter/material.dart';


class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
            style: TextStyle(color: Colors.white),
            "Privacy Policy"
        ),

        iconTheme: const IconThemeData(color: Colors.orange),
      ),

      body: const Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Text(
            """Privacy Policy

Last updated: 2026

This application, CaliCore, is developed by SOFIANE SADOQ.

We respect your privacy and are committed to protecting it.

This app does not require users to create an account or provide personal information.

Data Collection:
The app does not collect, store, or share any personal data directly.

However, the app uses third-party advertising services such as Unity Ads. These services may automatically collect limited information, including:

• Device information  
• Advertising ID  
• IP address  

This data is used only for displaying and improving advertisements.

Third-Party Services:
https://unity.com/legal/privacy-policy

User Rights:
Users can manage or reset their advertising ID through device settings.

Children’s Privacy:
This app is not directed to children under 13.

Changes:
We may update this policy from time to time.

Contact:
disnhosbe@gmail.com
""",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}