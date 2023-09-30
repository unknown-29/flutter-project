import 'package:flutter/material.dart';
import 'package:untitled3/pages/home.dart';
import 'package:untitled3/pages/login.dart';
import 'package:untitled3/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:lottie/lottie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  AnimationController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=AnimationController(
      // duration: Duration(seconds: (5)),
      vsync: this,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Colors.blue.shade200,
        child: Center(
          child: Lottie.network(
            'https://lottie.host/23bb28de-a340-4a59-abf3-fbf3efff7e11/KTGQo5GLmW.json',
            onLoaded: (composition) {
              _controller
                ?..duration = composition.duration
                ..forward().whenComplete(() => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()),
              ));
            },
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: Colors.black.withOpacity(.1),
      //       )
      //     ],
      //   ),
      //   child: GNav(
      //       rippleColor: Colors.grey.shade800,
      //       // tab button ripple color when pressed
      //       hoverColor: Colors.grey.shade700,
      //       // tab button hover color
      //       haptic: true,
      //       // haptic feedback
      //       tabBorderRadius: 15,
      //       // tabActiveBorder: Border.all(color: Colors.black, width: 1),
      //       // tab button border
      //       // tabBorder: Border.all(color: Colors.grey, width: 1),
      //       // tab button border
      //       tabShadow: [
      //         BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
      //       ],
      //       // tab button shadow
      //       curve: Curves.easeOutExpo,
      //       // tab animation curves
      //       duration: Duration(milliseconds: 300),
      //       // tab animation duration
      //       gap: 8,
      //       // the tab button gap between icon and text
      //       color: Colors.grey[800],
      //       // unselected icon color
      //       activeColor: Colors.purple,
      //       // selected icon and text color
      //       iconSize: 44,
      //       // tab button icon size
      //       tabBackgroundColor: Colors.purple.withOpacity(0.1),
      //       // selected tab background color
      //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      //       // navigation bar padding
      //       tabs: [
      //         GButton(
      //           icon: Icons.home_rounded,
      //           text: 'Home',
      //         ),
      //         GButton(
      //           icon: Icons.favorite_border_rounded,
      //           text: 'Likes',
      //         ),
      //         GButton(
      //           icon: Icons.search,
      //           text: 'Search',
      //         ),
      //         GButton(
      //           icon: Icons.phone,
      //           text: 'Profile',
      //
      //         )
      //       ]
      //   ),
      // ),
    );
  }
}
