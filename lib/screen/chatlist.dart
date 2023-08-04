// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:async';

import 'package:chatappjob/model/modelingdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/chatlistmodel.dart';
import '../service/getalluser.dart';
import 'chatroom.dart';

class ChatList extends StatefulWidget {
  ChatList({super.key, required this.token, required this.loginauth});
  loginAuth loginauth;
  String? token;

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late Timer _timer;
  int _fetchInterval = 5; // In seconds, adjust the interval as needed

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: _fetchInterval), (timer) {
      getAllUser(loginauth: widget.loginauth);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Chat app"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          getAllUser(loginauth: widget.loginauth);
          ChatlistModel temp = chatlist.value;
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
                  'loading...',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          }
        }),

        // SizedBox(
        //   height: height * .8,
        //   child: FutureBuilder(
        //       future: getAllUser(loginauth: widget.loginauth),
        //       builder: (ctx, snapshot) {
        //         if (snapshot.connectionState ==
        //             ConnectionState.done) {
        //           if (snapshot.hasError) {
        //             return Center(
        //               child: Text(
        //                 '${snapshot.error} occurred',
        //                 style: TextStyle(fontSize: 18),
        //               ),
        //             );
        //           } else if (snapshot.hasData) {
        //             ChatlistModel temp =
        //                 snapshot.data as ChatlistModel;

        //             if (temp.statusCode == 200) {
        //               return ListView.builder(
        //                 itemCount: temp.data!.length,
        //                 itemBuilder: (context, index) {
        //                   ChatlistModelData temp2 = temp.data![index];
        //                   return Card(
        //                     child: InkWell(
        //                       onTap: () {
        //                         Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                             builder: (context) => ChatRoom(
        //                               loginauth: widget.loginauth,
        //                               chatlistModelData: temp2,
        //                             ),
        //                           ),
        //                         );
        //                       },
        //                       child: ListTile(
        //                         title: Text(temp2.name!),
        //                         subtitle: Text(temp2.lastMessage!),
        //                       ),
        //                     ),
        //                   );
        //                 },
        //               );
        //             } else {
        //               return Center(
        //                 child: SingleChildScrollView(
        //                   child: Text(
        //                     'cannot find data',
        //                     style: TextStyle(fontSize: 18),
        //                   ),
        //                 ),
        //               );
        //             }
        //           }
        //         }
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }),
        // ),
      ),
    );
  }
}
