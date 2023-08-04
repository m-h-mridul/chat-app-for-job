
// ignore_for_file: camel_case_types, unnecessary_question_mark, prefer_void_to_null, unnecessary_new, prefer_collection_literals, unnecessary_this

class loginAuth {
  bool? success;
  String? message;
  Data? data;

  loginAuth({this.success, this.message, this.data});

  loginAuth.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  User? user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  Null? image;
  String? name;
  String? username;
  String? email;
  String? phone;
  int? phoneVerified;
  Null? dateOfBirth;
  Null? gender;
  String? location;
  int? postLimit;
  int? coins;

  User(
      {this.id,
      this.image,
      this.name,
      this.username,
      this.email,
      this.phone,
      this.phoneVerified,
      this.dateOfBirth,
      this.gender,
      this.location,
      this.postLimit,
      this.coins});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    phoneVerified = json['phone_verified'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    location = json['location'];
    postLimit = json['post_limit'];
    coins = json['coins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['phone_verified'] = this.phoneVerified;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['location'] = this.location;
    data['post_limit'] = this.postLimit;
    data['coins'] = this.coins;
    return data;
  }
}
