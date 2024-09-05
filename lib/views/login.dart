import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_player_application/constants/colors.dart';

import '../auth_file.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Container(
        margin: EdgeInsets.only(
            left: 25,
            right: 25,
            top: MediaQuery.of(context).size.height * 0.03),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/loginImg.png',
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              Text(
                'Sign in to your account',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'You need to login before getting started !',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _password,
                obscureText: true,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async{
                    final user =
                    await _auth.loginUserWithEmailAndPassword(
                        _email.text, _password.text);
                    if (user != null) {
                      Navigator.pushNamedAndRemoveUntil(context, 'searchTrack',(Route<dynamic> route) => false);
                    }
                    const snackbar = SnackBar(content:
                      Text('Something went wrong')
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: CustomColors.backgroundColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot password ?",
                        style: TextStyle(color: Colors.white70),
                      ))
                ],
              ),
              Text("OR",style: TextStyle(color: Colors.white),),
              SizedBox(height: 20,),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: Text(
                    "Create account",
                    style: TextStyle(color: CustomColors.backgroundColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
