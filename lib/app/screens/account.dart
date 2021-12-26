import 'package:flutter/material.dart';
import 'package:foodbuddy/app/config/firebase.dart';
import 'package:foodbuddy/app/ui_widgets/custom_text.dart';
import 'package:foodbuddy/app/ui_widgets/space.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Space(
            height: 30,
          ),
          const CircleAvatar(
            child: Icon(Icons.person),
            radius: 50,
          ),
          const Space(
            height: 30,
          ),
          ListTile(
            title: CustomText(text: firebaseAuth.currentUser!.email!, size: 15),
            leading: const Icon(Icons.email),
          ),
          ListTile(
            title: const CustomText(text: 'Logout', size: 15),
            leading: const Icon(Icons.logout),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
