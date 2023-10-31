class UserModel {
  String? email;
  String? password;
  String? phone;
  String? gender;
  String? name;
  String? birthday;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? id;

  UserModel(
      {this.email,
      this.password,
      this.phone,
      this.gender,
      this.name,
      this.birthday,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    gender = json['gender'];
    name = json['name'];
    birthday = json['birthday'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['gender'] = gender;
    data['name'] = name;
    data['birthday'] = birthday;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}
