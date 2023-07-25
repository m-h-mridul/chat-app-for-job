// ignore_for_file: prefer_const_constructors

import 'package:chatappjob/model/modelingdata.dart';
import 'package:flutter/material.dart';

import '../model/chatlistmodel.dart';
import '../model/messagelist.dart';
import '../model/usermessage.dart';
import '../service/messagesent.dart';
import '../service/getalluser.dart';
import '../service/messagehistory.dart';
import 'chatroom.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.token, required this.loginauth});
  loginAuth loginauth;
  String? token;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Chat app"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                 
                  SizedBox(
                    height: height * .8,
                    child: FutureBuilder(
                        future: getAllUser(loginauth: widget.loginauth),
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  '${snapshot.error} occurred',
                                  style: TextStyle(fontSize: 18),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              // Extracting data from snapshot object
                              ChatlistModel temp =
                                  snapshot.data as ChatlistModel;

                              if (temp.statusCode == 200) {
                                return ListView.builder(
                                  itemCount: temp.data!.length,
                                  itemBuilder: (context, index) {
                                    ChatlistModelData temp2 = temp.data![index];
                                    return Card(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatRoom(
                                                loginauth: widget.loginauth,
                                                chatlistModelData: temp2,
                                              ),
                                            ),
                                          );
                                        },
                                        child: ListTile(
                                          title: Text(temp2.name!),
                                          subtitle: Text(temp2.lastMessage!),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      'cannot find data',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                ],
              ),

              // SizedBox(
              //   height: 20,
              // ),
              // TextField(
              //   controller: message,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Enter text',
              //     hintText: 'message',
              //   ),
              // ),
              // Text(
              //   'You have pushed the button this many times:',
              // ),
              // ElevatedButton(
              //   onPressed: () async {
              //     UserMessage um = UserMessage(
              //         userUid: '4', message: message.text.toString());
              //     await messagesent(um: um);
              //   },
              //   child: Text('Sent message'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
