class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String avatar;
  List<Map<String, dynamic>> wishlist;
  List<Map<String, dynamic>> history;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.wishlist,
    required this.history,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        avatar: json['avatar'],
        wishlist: List<Map<String, dynamic>>.from(json['wishlist'] ?? []),
        history: List<Map<String, dynamic>>.from(json['history'] ?? []),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'avatar': avatar,
    'wishlist': wishlist,
    'history': history,
  };
}
