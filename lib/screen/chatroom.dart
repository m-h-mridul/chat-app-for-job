// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable

import 'package:chatappjob/model/modelingdata.dart';
import 'package:chatappjob/model/usermessage.dart';
import 'package:chatappjob/service/messagesent.dart';
import 'package:chatappjob/service/messagehistory.dart';
import 'package:flutter/material.dart';

import '../model/chatlistmodel.dart';
import '../model/messagelist.dart';

class ChatRoom extends StatelessWidget {
  ChatRoom(
      {super.key, required this.loginauth, required this.chatlistModelData});
  loginAuth loginauth;
  ChatlistModelData chatlistModelData;
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
                child: FutureBuilder(
                    future: messagehistory(
                        authToken: loginauth.data!.token,
                        userUid: chatlistModelData),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          // Extracting data from snapshot object
                          MessageList temp = snapshot.data as MessageList;
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
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: message,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text',
                  hintText: 'message',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  UserMessage um = UserMessage(
                      userUid: chatlistModelData.userId.toString(),
                      message: message.text.toString());
                  await messagesent(loginauth: loginauth, um: um);
                  message.clear();
                },
                child: Text('Sent message'),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
