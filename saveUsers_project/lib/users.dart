class Users {
  String email;
  int age;
  String name;
  Users({required this.age, required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age, 'email': email};
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(age: json['age'], name: json['name'], email: json['email']);
  }
}
