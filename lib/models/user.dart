class User {
  String email;
  String nickname;
  String displayName;
  String token;

  User({
    required this.email,
    required this.nickname,
    required this.displayName,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["user_email"],
        nickname: json["user_nicename"],
        displayName: json["user_display_name"],
        token: json["token"],
      );
}
