// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable

import 'dart:async';

import 'package:chatappjob/model/modelingdata.dart';
import 'package:chatappjob/model/usermessage.dart';
import 'package:chatappjob/service/messagesent.dart';
import 'package:chatappjob/service/messagehistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../model/chatlistmodel.dart';
import '../model/messagelist.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom(
      {super.key, required this.loginauth, required this.chatlistModelData});
  loginAuth loginauth;
  ChatlistModelData chatlistModelData;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late Timer _timer;
  int _fetchInterval = 5;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: _fetchInterval), (timer) {
      messagehistory(
          authToken: widget.loginauth.data!.token,
          userUid: widget.chatlistModelData);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Chat Room"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: height * .7,
                child: Obx(() {
                  messagehistory(
                      authToken: widget.loginauth.data!.token,
                      userUid: widget.chatlistModelData);
                  MessageList temp = messagelist.value;
                  if (temp.statusCode == 200) {
                    return temp.data!.isNotEmpty
                        ? ListView.builder(
                            itemCount: temp.data!.length,
                            itemBuilder: (context, index) {
                              MessageListData temp2 = temp.data![index];
                              return Card(
                                child: ListTile(
                                  title: Text(temp2.message!),
                                  subtitle: Text(temp2.time.toString()),
                                ),
                              );
                            },
                          )
                        : Text('Start Conversation');
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
                }),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter text',
                        hintText: 'message',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        UserMessage um = UserMessage(
                            userUid: widget.chatlistModelData.userId.toString(),
                            message: message.text.toString());
                        await messagesent(loginauth: widget.loginauth, um: um);
                        message.clear();
                      },
                      child: Text('Sent'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
