import 'dart:convert';

BaseRequestModel baseRequestModelFromJson(String str) => BaseRequestModel.fromJson(json.decode(str));

String baseRequestModelToJson(BaseRequestModel data) => json.encode(data.toJson());

class BaseRequestModel <T> {
    T data;
    String message;
    String path;
    int status;

    BaseRequestModel({
        required this.data,
        required this.message,
        required this.path,
        required this.status,
    });

    factory BaseRequestModel.fromJson(Map<String, dynamic> json) => BaseRequestModel<T>(
        data: json['data'],
        message: json['message'],
        path: json['path'],
        status: json['status'],
    );

    Map<String, dynamic> toJson() => {
        'data': data,
        'message': message,
        'path': path,
        'status': status,
    };
}
