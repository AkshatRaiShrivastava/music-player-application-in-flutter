import 'package:flutter/material.dart';
import 'package:music_player_application/constants/colors.dart';
import 'package:music_player_application/views/login.dart';
import 'package:music_player_application/views/music_player.dart';

import '../auth_file.dart';
import '../models/music.dart';

class SearchTrack extends StatefulWidget {
  const SearchTrack({super.key});

  @override
  State<SearchTrack> createState() => _SearchTrackState();
}

class _SearchTrackState extends State<SearchTrack> {
  final _auth = AuthService();
  final _trackId = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
              left: 23,
              right: 23,
              top: MediaQuery.of(context).size.height * 0.07),
          child: Column(
            children: [
              Image.asset(
                'assets/musicImg.png',
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(30)),
                child: TextField(
                  controller: _trackId,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter spotify track id here",
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Go',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MusicPlayer(trackID: _trackId.text),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height:50),
              ElevatedButton(
                onPressed: () {
                  _auth.signout();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                      color: CustomColors.backgroundColor, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.white,
                  
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
