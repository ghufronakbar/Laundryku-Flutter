class User {
  final String id;
  final String name;
  final String phone;
  final String? profilePicture;
  final String? imageUrl;
  final String email;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.phone,
    this.profilePicture,
    this.imageUrl,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      profilePicture: json['profile_picture'],
      imageUrl: json['image_url'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'profile_picture': profilePicture,
      'image_url': imageUrl,
      'email': email,
      'password': password,
    };
  }
}
