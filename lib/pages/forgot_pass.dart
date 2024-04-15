import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForogtPassword extends StatefulWidget {
  const ForogtPassword({super.key});

  @override
  State<ForogtPassword> createState() => _ForogtPasswordState();
}

class _ForogtPasswordState extends State<ForogtPassword> {
  String? email;

  final formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("OTP Sent Successfully")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No User Found For This Email")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Text("Password Recovery",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0)),
              SizedBox(height: 15.0),
              Text("Enter Your Mail",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0)),
              SizedBox(height: 25.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.white),
                ),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.mail),
                    hintText: "Enter Email",
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                    });
                    resetPassword();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.orange,
                  ),
                  child: Center(
                      child: Text("Send OTP",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
