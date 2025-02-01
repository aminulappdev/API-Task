import 'package:api_task/Data/Models/profile_data.dart';

class ProfileModel {
  bool? success;
  String? message;
  ProfileData? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

 
}
