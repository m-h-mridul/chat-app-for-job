// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:get/get_rx/get_rx.dart';
import '../model/chatlistmodel.dart';
import '../model/messagelist.dart';

Rx<MessageList> messagelist = MessageList().obs;
messagehistory({String? authToken, ChatlistModelData? userUid}) async {
  try {
    userUid!.userId!.toInt();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    var dio = Dio();
    var response = await dio.request(
      'https://svkraft.shop/api/sms-history?to_user=${userUid.userId!.toInt()}',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      MessageList messageList = MessageList.fromJson(response.data);
      messagelist.value = messageList;
      return messageList;
    } else {
      MessageList messageList = MessageList.fromJson(response.data);
      return messageList;
    }
  } catch (e) {
    print(e.toString());
  }
}
