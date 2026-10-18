class UserProfile {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String image;

  const UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      image: json["image"],
    );
  }
}