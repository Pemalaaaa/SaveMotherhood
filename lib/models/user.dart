class Users {
  String? firstname;
  String? lastname;
  String? email;
  String? profileUrl;

  Users({
    this.firstname,
    this.lastname,
    this.email,
    this.profileUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'profileUrl': profileUrl,
    };
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      profileUrl: json['profileUrl'] ?? "https://via.placeholder.com/150",
    );
  }
}
