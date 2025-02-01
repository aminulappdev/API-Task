
class UserModel {
  String? accessToken;
  String? refreshToken;
  String? role;
  String? sId;
  String? status;

  UserModel({this.accessToken, this.refreshToken, this.role, this.sId, this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    role = json['role'];
    sId = json['_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['role'] = this.role;
    data['_id'] = this.sId;
    data['status'] = this.status;
    return data;
  }
}