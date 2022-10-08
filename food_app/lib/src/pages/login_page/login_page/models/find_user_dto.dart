import 'package:food_app/src/infrastructure/commons/models/user_view_model.dart';

class FindUserDTO{
  final String username;
  final String? password;
  final String? phoneNumber;

  const FindUserDTO({
    required this.username,
    this.password,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      UserViewModel.usernameKey: username,
      if(password!=null)UserViewModel.passwordKey: password,
      if(phoneNumber!=null)UserViewModel.phoneNumberKey: phoneNumber,
    };
  }

}