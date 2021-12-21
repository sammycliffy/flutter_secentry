import 'package:flutter/material.dart';
import 'package:flutter_secentry/Pages/authpages/login.dart';
import 'package:flutter_secentry/Pages/authpages/registration.dart';
import 'package:flutter_secentry/Pages/onboarding/splashscreen.dart';
import 'package:flutter_secentry/constants/colors.dart';
import 'package:flutter_secentry/constants/route.dart';
import 'package:flutter_secentry/helpers/providers/providers.dart';
import 'package:flutter_secentry/widget/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Pages/Estate/estate_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        routes: route,
        title: 'Flutter Secentry',
        theme: ThemeData(
          scaffoldBackgroundColor: kWhite,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const EstateDashoard(),
      ),
    );
  }
}
