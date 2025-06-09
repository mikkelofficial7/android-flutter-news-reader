class UserModel {
  final int id;
  final String firstName;
  final String? lastName;
  final String? phone;
  final String email;
  final String? photoUrl;
  final String? bgTheme;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    this.lastName,
    this.phone,
    this.photoUrl,
    this.bgTheme,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phone: json['phone'],
        photoUrl: json['user_photo'],
        bgTheme: json['bg_theme'],
      );
}
