class LoginReq {
  final String email;
  final String password;

  LoginReq({
    required this.email,
    required this.password,
  });
  @override
  String toString() {
    return """\n
    Email: $email,
    Password: $password
    """;
  }
}

class User {
  String? token;
  String? expDate;
  String? fullName;
  String? email;
  String? phone;
  List? roles;
  String? avatar;
  String? userId;
  User(
      {this.token,
      this.expDate,
      this.fullName,
      this.email,
      this.phone,
      this.avatar,
      this.roles,
      this.userId});
  @override
  String toString() {
    return """\n
    Exp Date: $expDate,
    Full Name: $fullName,
    Email: $email,
    Phone: $phone,
    Roles: $roles,
    Avatar: $avatar,
    User ID: $userId,
    Token: $token,
    """;
  }
}
