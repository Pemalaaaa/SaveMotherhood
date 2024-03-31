class Users {
  String? firstname;
  String? lastname;
  String? email;
  

  Users({
    this.firstname,
    this.lastname,
    this.email,
  });

  Users fromJson(Map<String, dynamic> json) {
    return Users(
      firstname: json["firstname"],
      lastname: json["lastname"],
      email: json["email"],
    );
  }
}
