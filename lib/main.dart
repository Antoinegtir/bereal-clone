import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rebeal/common/locator.dart';
import 'package:rebeal/common/splash.dart';
import 'package:rebeal/state/appState.dart';
import 'package:rebeal/state/authState.dart';
import 'package:provider/provider.dart';
import 'package:rebeal/state/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
  setupDependencies();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStates>(create: (_) => AppStates()),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
        ChangeNotifierProvider<PostState>(create: (_) => PostState()),
      ],
      child: MaterialApp(
          theme: ThemeData(brightness: Brightness.dark),
          title: 'ReBeal.',
          debugShowCheckedModeBanner: false,
          home: SplashPage()),
    );
  }
}
