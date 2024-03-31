//making the class for adding the doctors
class Doctor {
  String name;
  String hospital;
  String phone;

  //making  a constructor
  Doctor({
    required this.name,
    required this.hospital,
    required this.phone,
  });

  
  // Doctor fromJson(Map<String, dynamic> json) {
  //   return Doctor(
  //     'name':name,
  //     'hospital':hospital,
  //     'phone':phone,
  //   );
  // }
}

  // Users fromJson(Map<String, dynamic> json) {
  //   return Users(
  //     firstname: json["firstname"],
  //     lastname: json["lastname"],
  //     email: json["email"],
  //   );
  // }
