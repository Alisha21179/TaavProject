class UserViewModel {
  String name, family, address, birthday, phoneNumber, username, password;
  bool isAdmin;

  static String isAdminKey = "isAdmin";
  static String nameKey = "name";
  static String familyKey = "family";
  static String addressKey = "address";
  static String birthdayKey = "birthday";
  static String phoneNumberKey = "phoneNumber";
  static String usernameKey = "username";
  static String passwordKey = "password";

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
      isAdmin: json[UserViewModel.isAdminKey],
      name: json[UserViewModel.nameKey],
      family: json[UserViewModel.familyKey],
      address: json[UserViewModel.addressKey],
      birthday: json[UserViewModel.birthdayKey],
      phoneNumber: json[UserViewModel.phoneNumberKey],
      username: json[UserViewModel.usernameKey],
      password: json[UserViewModel.passwordKey],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserViewModel.isAdminKey: isAdmin,
      UserViewModel.nameKey: name,
      UserViewModel.familyKey: family,
      UserViewModel.addressKey: address,
      UserViewModel.birthdayKey: birthday,
      UserViewModel.phoneNumberKey: phoneNumber,
      UserViewModel.usernameKey: username,
      UserViewModel.passwordKey: password,
    };
  }
}
