// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/chatlistmodel.dart';
import '../model/modelingdata.dart';

getAllUser({loginAuth? loginauth}) async {
  try {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginauth!.data!.token}',
    };
    var dio = Dio();
    var response = await dio.request(
      'https://svkraft.shop/api/chat-list',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      ChatlistModel chatlistModel = ChatlistModel.fromJson(response.data);
      return chatlistModel;
    } else {
      ChatlistModel chatlistModel = ChatlistModel.fromJson(response.data);
      return chatlistModel;
    }
  } catch (e) {
    print(e.toString());
  }
}
