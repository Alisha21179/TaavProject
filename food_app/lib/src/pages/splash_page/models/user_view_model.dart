class UserViewModel {
  String name, family, address, birthday, phoneNumber, username, password;
  bool isAdmin;

  UserViewModel({
    required this.isAdmin,
    required this.name,
    required this.family,
    required this.address,
    required this.birthday,
    required this.phoneNumber,
    required this.username,
    required this.password,
  });

  factory UserViewModel.fromJson(Map<String, dynamic> json) {
    return UserViewModel(
      isAdmin: json['isAdmin'],
      name: json['name'],
      family: json['family'],
      address: json['address'],
      birthday: json['birthday'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      password: json['password'],
    );
  }
}
