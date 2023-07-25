// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import '../model/chatlistmodel.dart';
import '../model/messagelist.dart';

messagehistory({String? authToken, ChatlistModelData? userUid}) async {
  try {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    var dio = Dio();
    var response = await dio.request(
      'https://svkraft.shop/api/sms-history?to_user=${userUid!}',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      MessageList messageList = MessageList.fromJson(response.data);
      return messageList;
    } else {
      MessageList messageList = MessageList.fromJson(response.data);
      return messageList;
    }
  } catch (e) {
    print(e.toString());
  }
}
