class ChatlistModel {
  int? statusCode;
  String? message;
  List<ChatlistModelData>? data;

  ChatlistModel({this.statusCode, this.message, this.data});

  ChatlistModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ChatlistModelData>[];
      json['data'].forEach((v) {
        data!.add(ChatlistModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatlistModelData {
  int? userId;
  String? image;
  String? name;
  String? email;
  String? phone;
  String? lastMessage;

  ChatlistModelData(
      {this.userId,
      this.image,
      this.name,
      this.email,
      this.phone,
      this.lastMessage});

  ChatlistModelData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    lastMessage = json['last_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['last_message'] = this.lastMessage;
    return data;
  }
}
