import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpace(50),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Text(
                    'Account page',
                    style: TextStyle(fontSize: 40),
                  ),
                  heightSpace(20),
                  listItem('Profile', Icons.person, null),
                  heightSpace(10),
                  listItem('Logout', Icons.logout, logout),
                  heightSpace(10),
                  listItem('Help', Icons.help, logout),
                  heightSpace(10),
                  listItem('Details', Icons.home, logout)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  logout() {
    Navigator.pushNamed(context, '/login');
  }
}

listItem(text, icon, ontap) => Card(
      child: ListTile(
        onTap: ontap,
        leading: Icon(icon),
        title: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
