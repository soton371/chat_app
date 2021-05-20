
import 'package:covid19/conversationpage.dart';
import 'package:covid19/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var email, password;
  var hide_password = true;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  logIn() async {
    FirebaseUser user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    user != null
        ? Navigator.push(
            context, MaterialPageRoute(builder: (context) => ConversationPage(get_user: user,)))
        : print('Error of logIn function');
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
                    height: 60,
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
                          data: Theme.of(context).copyWith(
                            primaryColor: Color(0xFF7777FF),
                          ),
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
                              } else if (input.length < 6) {
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
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                ),
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
                                          logIn();
                                        })
                                      : print('error inside log in button');
                                },
                                child: Text(
                                  'LOGIN',
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
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          "Register",
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
