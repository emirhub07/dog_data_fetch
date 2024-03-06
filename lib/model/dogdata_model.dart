import 'package:hive/hive.dart';

class DogDataModel {
  String? message;
  String? status;

  DogDataModel({this.message, this.status});

  DogDataModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["status"] = status;
    return _data;
  }
}
