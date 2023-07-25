// ignore_for_file: avoid_print

import 'package:chatappjob/helper/toast.dart';
import 'package:dio/dio.dart';

registation(
    {String? name,
    String? email,
    String? phone,
    String? password,
    String? city}) async {
  try {
    print({name,email,phone,password,city});
    var headers = {'Accept': 'application/json'};
    var data = FormData.fromMap({
      'email': email!,
      'phone': phone,
      'password': password,
      'username': name,
      'city_name': 'نينوى.'
    });

    var dio = Dio();
    var response = await dio.request(
      'https://svkraft.shop/api/register',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      showtoast(message: response.data.toString());
    } else {
      showtoast(message: response.data.toString());
    }
  } catch (e) {
    print(e.toString());
  }
}
