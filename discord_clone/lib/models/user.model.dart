class User {
  final String id;
  final String uid;
  final String name;
  final String email;
  final String status;
  final String wallpaper;
  final String avatar;
  final String bio;
  final String createdAt;

  const User({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.status,
    required this.wallpaper,
    required this.avatar,
    required this.bio,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      uid: json['_uid'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      wallpaper: json['wallpaper'],
      avatar: json['avatar'],
      bio: json['bio'],
      createdAt: json['createdAt'],
    );
  }
}
