import 'package:asbar/Constants/colors.dart';
import 'package:asbar/Constants/styles.dart';
import 'package:asbar/Providers/AuthProvider.dart';
import 'package:asbar/Scaffolds/AuthScaffold.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 72),
        child: ListView(
          children: [
            const SizedBox(height: 36),

            ///Profile Picture
            Center(
              child: Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kGrey,
                ),
              ),
            ),

            const SizedBox(height: 18),

            ///Doctor Name
            const Center(
              child: Text("Dr. John Doe", style: kMedium16),
            ),
            const SizedBox(height: 6),

            ///Edit Profile
            SingleIconText(iconData: Icons.person, text: "Edit Profile"),

            ///Edit Profile
            SingleIconText(iconData: Icons.settings, text: "Settings"),

            ///Edit Profile
            SingleIconText(iconData: Icons.logout, text: "Logout"),
          ],
        ),
      ),
    );
  }
}

class SingleIconText extends StatelessWidget {
  const SingleIconText({Key? key, required this.text, required this.iconData})
      : super(key: key);

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProviderFalse =
        Provider.of<AuthProvider>(context, listen: false);

    Function function = () {};
    switch (text) {
      case 'Logout':
        function = () async {
          await authProviderFalse.signOut();
          Navigator.pushReplacementNamed(context, AuthScaffold.id);
        };
    }
    return InkWell(
      onTap: () async {
        function();
      },
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(iconData, color: kBlue2),
              const SizedBox(width: 24),
              Text(text, style: kMedium15)
            ],
          ),
          const SizedBox(height: 24),
          Container(height: 1, color: kBorderGrey),
        ],
      ),
    );
  }
}
