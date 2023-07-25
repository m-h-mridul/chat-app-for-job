// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:chatappjob/helper/toast.dart';
import 'package:dio/dio.dart';

import '../model/modelingdata.dart';
import '../model/usermessage.dart';

messagesent({loginAuth? loginauth, UserMessage? um}) async {
  try {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${loginauth!.data!.token}',
    };
    var data =
        FormData.fromMap({'to_user': um!.userUid, 'message': um.message});

    var dio = Dio();
    var response = await dio.request(
      'https://svkraft.shop/api/send-sms',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      String ans = json.encode(response.data);
      showtoast(message: ans);
    } else {
      showtoast(message: response.statusMessage);
    }
  } catch (e) {
    print(e.toString());
    showtoast(message: "Inside tay cache ${e.toString()}");
  }
}
