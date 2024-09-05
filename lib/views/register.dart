import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth_file.dart';
import '../constants/colors.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Container(
        margin: EdgeInsets.only(
            left: 25,
            right: 25,
            top: MediaQuery.of(context).size.height * 0.05),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/authImg.png',
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              Text(
                'Create your account',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please fill all the details below to create your account',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),

              TextField(
                controller: _name,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  hintText: "Full name",
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              ),

              SizedBox(
                height: 20,
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
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signup,
                  child: Text(
                    "Create Account",
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
  _signup() async {
    final user =
    await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      log("user created successfully");
      const snackbar = SnackBar(content:
        Text('Account created successfully, you can login now.')
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      // Navigator.pushNamed(context, 'home');
      Map<String,dynamic> data={
        'name' : _name.text,
        'email':_email.text,
        'createdOn': Timestamp.now()
      };
      user.updateDisplayName(_name.text);
      FirebaseFirestore.instance.collection("users").doc(user.uid).set(data);
    }
  }
}
