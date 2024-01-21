// import 'package:eventflow/Screens/Bienvenu/bienvenu1.dart';
// import 'package:eventflow/Screens/Bienvenu/bienvenu3.dart';
// import 'package:eventflow/Screens/organizators/lists.dart';
import 'package:eventflow/Screens/organizators/lists.dart';
import 'package:eventflow/controller/google_sign_in.dart';
// import 'package:eventflow/Screens/home.dart';
// import 'package:eventflow/Screens/login.dart';
// import 'package:eventflow/Screens/signup.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'firebase_options.dart';
// import 'package:eventflow/Screens/Bienvenu/bienvenu2.dart';
// import 'package:eventflow/Screens/Bienvenu/bienvenu4.dart';


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => GoogleSignInProvider(),
//       child:  MaterialApp(
//         theme: ThemeData(

//           useMaterial3: true,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: const Bienvenu2(),
//       ),
//     );

//   }
//   }




















// import 'package:flutter/material.dart';
// import 'package:event_flow/widgets/app_logo.dart';
// import 'package:event_flow/widgets/my_circular_progress.dart';
// import 'package:event_flow/screens/sign_in.dart';
// import 'package:event_flow/screens/home_page.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     // Utilisez Future.delayed pour rediriger automatiquement après un certain délai
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (context) => const SignIn(), // Remplacez SignInPage par le nom de votre page de connexion
//       ));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: Colors.white,
//           child: const Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   AppLogo(),
//                   SizedBox(height: 10),
//                   Text("EventFlow",
//                       style:
//                           TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 5),
//                   Text("Vos évenements en un click",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 18, color: Colors.grey)),
//                   SizedBox(height: 20),
//                   MyCircularProgress()
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// NEW VERSION


import 'dart:io';

import 'package:eventflow/Screens/Bienvenu/createEvenement.dart';
import 'package:flutter/material.dart';
// import 'package:eventflow/Screens/deodat/screens/';
import 'package:eventflow/Screens/deodat/screens/events.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eventflow/widgets/deodat/widgets/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:eventflow/Screens/deodat/screens/home_page.dart';
import 'package:eventflow/widgets/deodat/widgets/app_logo.dart';
import 'package:eventflow/widgets/deodat/widgets/my_circular_progress.dart';


import 'package:eventflow/Screens/Bienvenu/bienvenu1.dart';
import 'package:eventflow/Screens/Bienvenu/bienvenu2.dart';
import 'package:eventflow/Screens/Bienvenu/bienvenu4.dart';

import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => NotificationProvider(),
//       child: const MyApp(),
//     ),
//   );
// }



// some solutions for multi-provider error
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        // Other providers if any
      ],
      child: MyApp(),
    ),
  );
}







class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   // Utilisez Future.delayed pour rediriger automatiquement après un certain délai
  //   Future.delayed(const Duration(seconds: 5), () {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => const Bienvenu2(),
  //     ));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateEvent()
    );

  }
}