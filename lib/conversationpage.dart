import 'package:covid19/webvi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationPage extends StatefulWidget {

  FirebaseUser get_user;
  ConversationPage({this.get_user});
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {

  var sms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF7777FF),
        title: Row(
          children: [
            Icon(Icons.ac_unit),
            SizedBox(width: 5),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> WebVi()));
              },
                child: Text('Excelit Ai')
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
        ),
        shadowColor: Color(0xAB7777FF),
        elevation: 20,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
              child: Icon(Icons.logout)),
          SizedBox(width: 20,)
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              reverse: true,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 25),
                alignment: Alignment.centerLeft,
                child: StreamBuilder(
                    stream: Firestore.instance.collection('chats').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return Text('no value');
                      }else{
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            snapshot.data.documents.map((e) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e['user'] ?? 'N/A txt',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey
                                  ),
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       color: Color(0xFFEEF1FF),
                                  //       borderRadius: BorderRadius.circular(10)
                                  //   ),
                                  //   padding: EdgeInsets.all(10),
                                  //   child: Text(e['sms'] ?? 'N/A txt',
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  //   ),
                                  // ),
                                  Text(e['sms'] ?? 'N/A txt',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('\n')
                                ],
                              );
                            }).toList()
                        );
                      }
                    }
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 6, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFEEF1FF),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        cursorColor: Color(0xFF7777FF),
                        decoration: InputDecoration(
                            hintText: "Type your message",
                          border: InputBorder.none
                        ),
                        onChanged: (input){
                          sms = input;
                        },

                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      flex: 1,
                        child: FlatButton(
                            padding: EdgeInsets.all(12),
                            color: Color(0xFF7777FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)
                            ),
                            onPressed: (){
                              Firestore.instance.collection("chats").add({
                                'sms': sms,
                                'user': widget.get_user.email.toString(),
                              });
                            },
                            child: Icon(Icons.send, color: Colors.white,))
                    ),

                  ],
                )
              )
            )
          ],
        ),
      )
    );
  }
}
