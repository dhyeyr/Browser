
import 'package:flutter/material.dart';
import 'package:mirrorwall/View/home_page.dart';
import 'package:provider/provider.dart';

import 'Controller/connectivity_provider.dart';
import 'Model/const.dart';
import 'View/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),

      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Hello",
            // home: HomeScreen(),
            routes: {
              "/": (context) => SplashScreen(),
              homePage:(context) => Home_page(url: "https://www.google.com/"),
            },
          );
        }
      ),
    );
  }
}

