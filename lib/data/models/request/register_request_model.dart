class RegisterRequestModel {
  String code;
  String nickname;
  String fullname;
  String phoneNumber;
  String email;
  String password;

  RegisterRequestModel({
    this.code,
    this.nickname,
    this.fullname,
    this.phoneNumber,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['nickname'] = nickname;
    data['fullname'] = fullname;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
