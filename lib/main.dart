import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:music_player_application/views/register.dart';
import 'package:music_player_application/views/search_track.dart';
import 'firebase_options.dart';
import 'package:music_player_application/views/home.dart';
import 'package:music_player_application/views/login.dart';
import 'package:music_player_application/views/music_player.dart';


void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player App',
      initialRoute: 'home',
      routes: {
        'searchTrack':(context)=>const SearchTrack(),
        'home': (context)=>const HomePage(),
        'musicPlayer':(context)=>MusicPlayer(),
        'login':(context)=>const LoginPage(),
        'register':(context)=>const Register()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MusicPlayer(),
    );
  }
}
