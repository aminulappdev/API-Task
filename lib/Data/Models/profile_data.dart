
class ProfileData {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? contact;
  String? profilePicture;
  List<dynamic>? document;
  String? role;
  String? fcmToken;
  bool? isActive;
  bool? isDelete;
  String? status;
  Validation? validation;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<dynamic>? shifts;

  ProfileData({
    this.sId,
    this.firstName,
    this.lastName,
    this.email,
    this.contact,
    this.profilePicture,
    this.document,
    this.role,
    this.fcmToken,
    this.isActive,
    this.isDelete,
    this.status,
    this.validation,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.shifts,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    contact = json['contact'];
    profilePicture = json['profilePicture'];
    document = json['document'] != null ? List<dynamic>.from(json['document']) : null;
    role = json['role'];
    fcmToken = json['fcmToken'];
    isActive = json['isActive'];
    isDelete = json['isDelete'];
    status = json['status'];
    validation = json['validation'] != null ? Validation.fromJson(json['validation']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    shifts = json['shifts'] != null ? List<dynamic>.from(json['shifts']) : null;
  }

  
}

class Validation {
  bool? isVerified;

  Validation({this.isVerified});

  Validation.fromJson(Map<String, dynamic> json) {
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    return {
      'isVerified': isVerified,
    };
  }
}