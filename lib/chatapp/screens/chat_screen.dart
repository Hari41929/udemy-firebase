import 'package:flutter/material.dart';
import 'package:udemy/chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _storemsg = FirebaseFirestore.instance;
  late User user;

  void getCurrentUser() {
    User? userCurrent = _auth.currentUser;
    if (userCurrent != null) {
      user = userCurrent;
    }
  }

  late String msg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void messageStream() async {
    await for (var i in _storemsg.collection('messages').snapshots()) {
      for (var j in i.docs) {
        print(j.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                // _auth.signOut();
                // Navigator.pop(context);
                messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                  stream: _storemsg.collection("messages").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final totMsg = snapshot.data?.docs;
                      List<Text> messageList = [];
                      if (totMsg != null) {
                        for (var msg in totMsg) {
                          Map<String, dynamic> dat =
                              msg.data() as Map<String, dynamic>;
                          final messageSen = dat['sender'];
                          final messageTex = dat['text'];
                          messageList.add(Text("$messageTex from $messageSen",
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.w500)));
                        }
                      }
                      // return Column(
                      //   children: messageList,
                      // );
                      return Expanded(
                          child: ListView(
                        children: messageList,
                      ));
                    } else {
                      return Text("no msg Found");
                    }
                  }),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          //Do something with the user input.
                          msg = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //Implement send functionality.
                        _storemsg
                            .collection('messages')
                            .add({'text': msg, 'sender': user.email});
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBg extends StatelessWidget {
  const ChatBg({super.key,required this.msg,required this.sender});
  final String sender;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(sender,style: TextStyle(
            
          ),
          ),
          Material(
            borderRadius:const BorderRadius.all(Radius.circular(30)),
            color: Colors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Text(msg,
              style:const TextStyle(
                fontSize: 25,
                color: Colors.white
              ),),
            ),
          )
        ],
      ),
    );
  }
}
