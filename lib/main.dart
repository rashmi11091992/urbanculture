import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_culture/SkincareRoutineScreen.dart';

import 'Skincareprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCYRMoYeONEZGNSl5VBM6bIMtA8etNYSWU",
    appId: "1:333788951001:android:4858aae2a7ad35832e29c8",
    messagingSenderId: "333788951001",
    projectId: "urbanculture-cf0d8",
    storageBucket: "gs://urbanculture-cf0d8.appspot.com",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SkincareProvider(),
        child: MaterialApp(
          title: 'Skin Routine',
          home: SkincareRoutineScreen(),
        ));
  }
}
