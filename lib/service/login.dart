// ignore_for_file: avoid_print


import 'package:chatappjob/helper/toast.dart';
import 'package:dio/dio.dart';

import '../model/modelingdata.dart';

login({String? phone, String? password}) async {
  loginAuth autogenerated = loginAuth(success: false, message: '');
  try {
    var headers = {'Accept': 'application/json'};
    var data = FormData.fromMap({'phone': phone, 'password': password});

    var dio = Dio();
    var response = await dio.request(
      'https://svkraft.shop/api/login',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      loginAuth autogenerated2 = loginAuth.fromJson(response.data);
      return autogenerated2;
    } else {
      print(response.statusMessage);
      showtoast(message: response.statusMessage.toString());
      return autogenerated;
    }
  } catch (e) {
    print(e.toString());
    return autogenerated;
  }
}
