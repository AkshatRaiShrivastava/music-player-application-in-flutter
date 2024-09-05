import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_player_application/constants/colors.dart';
import 'package:music_player_application/views/login.dart';
import 'package:music_player_application/views/search_track.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/mainImg.jpg'),
                          radius: 80,
                        ),
                      ]),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Listen Music",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Text(
                    "Everywhere you want",
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                  const SizedBox(
                    height: 130,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Get Started', style: TextStyle(color: Color.fromRGBO(117, 207, 246, 1.0),fontSize: 20),),
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(65, 137, 166, 1.0),
                        child: IconButton(
                          onPressed: _navigateToHome,
                          icon: Icon(Icons.arrow_forward,color: Colors.white,),
                          
                        ),
                        radius: 30,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _navigateToHome(){

    if(FirebaseAuth.instance.currentUser?.uid == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SearchTrack()));
    }
  }
}
