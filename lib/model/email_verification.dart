class EmailVerificationResponse {
  final List<User> users;

  EmailVerificationResponse({
    required this.users,
  });

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) {
    var userList = json['users'] as List<dynamic>;
    List<User> usersList =
        userList.map((userJson) => User.fromJson(userJson)).toList();

    return EmailVerificationResponse(
      users: usersList,
    );
  }
}

class User {
  final String email;
  final bool emailVerified;

  User({
    required this.email,
    required this.emailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      emailVerified: json['emailVerified'],
    );
  }
}

class UserSignInResponse {
  final String? localId;
  final String? email;
  final String? displayName;
  final String? idToken;
  final bool registered;

  UserSignInResponse({
    this.localId,
    this.email,
    this.displayName,
    this.idToken,
    required this.registered,
  });

  factory UserSignInResponse.fromJson(Map<String, dynamic> json) {
    return UserSignInResponse(
      localId: json['localId'],
      email: json['email'],
      displayName: json['displayName'],
      idToken: json['idToken'],
      registered: json['registered'],
    );
  }
}
