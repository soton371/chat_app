
import 'package:covid19/conversationpage.dart';
import 'package:covid19/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var email, password, confirm_password, user_name, forusername;
  var hide_password = true;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  registarPage() async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    forusername = Firestore.instance.collection("usernames").add(
        {
          'username': user_name
        });

    user != null
        ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => ConversationPage(get_user: user,)))
        : print('Error of registerPage function');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image(
                    height: 100,
                    width: 100,
                    image: AssetImage('images/chatlogo.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Excelit ',
                        style: TextStyle(
                            fontSize: 43,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7777FF)),
                      ),
                      Text(
                        'AI',
                        style: TextStyle(
                            fontSize: 43,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Get Inspired To Create The Future',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Divider(
                          height: 1,
                          color: Color(0xFF7777FF),
                        ),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: Color(0xFF7777FF)),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please enter username';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (input) {
                              setState(() {
                                user_name = input;
                              });
                            },
                            cursorColor: Color(0xFF7777FF),
                            style:
                            TextStyle(color: Colors.black54, fontSize: 16),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Color(0xFF7777FF)),
                                hintText: "Enter Username",
                                prefixIcon: Icon(Icons.account_circle_outlined),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Color(0xFF7777FF),
                        ),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: Color(0xFF7777FF)),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please enter email';
                              } else if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(input)) {
                                return 'Please enter valid email';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (input) {
                              setState(() {
                                email = input;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Color(0xFF7777FF),
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Color(0xFF7777FF)),
                                hintText: "Enter Email",
                                prefixIcon: Icon(Icons.email_outlined),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Color(0xFF7777FF),
                        ),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: Color(0xFF7777FF)),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please enter password';
                              } else if(input.length < 6){
                                return "Password must be more than 5 characters";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (input) {
                              setState(() {
                                password = input;
                              });
                            },
                            obscureText: hide_password,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                            cursorColor: Color(0xFF7777FF),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Color(0xFF7777FF)),
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hide_password ? hide_password = false : hide_password = true;
                                      });
                                    },
                                    child: Icon(
                                      hide_password
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    )),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Color(0xFF7777FF),
                        ),
                        Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: Color(0xFF7777FF)),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return "Please enter re-password";
                              } else if (password.toString() !=
                                  confirm_password.toString()) {
                                return "Don't match password";
                              } else if(input.length < 6){
                                return "Password must be more than 5 characters";
                              }
                              else {
                                return null;
                              }
                            },
                            onChanged: (input) {
                              confirm_password = input;
                            },
                            obscureText: hide_password,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                            cursorColor: Color(0xFF7777FF),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(color: Color(0xFF7777FF)),
                                hintText: "Confirm Password",
                                prefixIcon: Icon(Icons.lock_outline),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hide_password
                                            ? hide_password = false
                                            : hide_password = true;
                                      });
                                    },
                                    child: Icon(
                                      hide_password
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    )),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Color(0xFF7777FF),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                color: Color(0xFF7777FF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                onPressed: () {
                                  _formkey.currentState.validate()
                                      ? setState(() {
                                          registarPage();
                                        })
                                      : print('Error inside register button');
                                    //sent username
                                  // Firestore.instance.collection("usernames").add(
                                  //     {
                                  //       'username': user_name
                                  //     });
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF7777FF),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
