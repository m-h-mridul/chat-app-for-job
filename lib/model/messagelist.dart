// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class MessageList {
  int? statusCode;
  String? message;
  List<MessageListData>? data;

  MessageList({this.statusCode, this.message, this.data});

  MessageList.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MessageListData>[];
      json['data'].forEach((v) {
        data!.add(new MessageListData.fromJson(v));
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

class MessageListData {
  int? userId;
  int? isFile;
  String? fileType;
  String? message;
  String? time;
  String? date;

  MessageListData(
      {this.userId,
      this.isFile,
      this.fileType,
      this.message,
      this.time,
      this.date});

  MessageListData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    isFile = json['is_file'];
    fileType = json['file_type'];
    message = json['message'];
    time = json['time'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['is_file'] = this.isFile;
    data['file_type'] = this.fileType;
    data['message'] = this.message;
    data['time'] = this.time;
    data['date'] = this.date;
    return data;
  }
}
