import 'package:flutter/material.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/spaces.dart';
import 'package:flutter_secentry/helpers/providers/profile.dart';
import 'package:flutter_secentry/services/auth_service.dart';
import 'package:flutter_secentry/widget/dialog.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:provider/src/provider.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  AuthServices _authServices = AuthServices();
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
                    style: TextStyle(fontSize: 25),
                  ),
                  heightSpace(20),
                  listItem('Profile', Icons.person, badge),
                  heightSpace(10),
                  listItem('Delete Account', Icons.delete, deleteAccount),
                  heightSpace(10),
                  listItem('Logout', Icons.logout, logout),
                  heightSpace(10),
                  // listItem('Help', Icons.help, logout),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteAccount() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('AlertDialog Title'),
          content: Container(
            color: Colors.transparent,
            width: 200,
            height: 150,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Delete Account',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimary),
                  ),
                  heightSpace(10),
                  Text(
                    'Are you sure you want to delete?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  heightSpace(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => delete(),
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              color: kPrimary,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(color: kWhite, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: kPrimary, width: 3)),
                          child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: kPrimary, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  heightSpace(8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  delete() async {
    await _authServices
        .deleteAccount()
        .then((value) => Navigator.pushNamed(context, '/login'));
  }

  logout() {
    Navigator.pushNamed(context, '/login');
  }

  badge() {
    Navigator.pushNamed(context, '/user_badge');
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
