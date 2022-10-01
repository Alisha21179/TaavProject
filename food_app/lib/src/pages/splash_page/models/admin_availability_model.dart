import 'package:food_app/src/infrastructure/commons/models/user_view_model.dart';

class AdminAvailabilityModel {
  final bool isAdmin = true;

  AdminAvailabilityModel();

  Map<String, dynamic> toJson() {
    return {
      UserViewModel.isAdminKey: isAdmin,
    };
  }

  factory AdminAvailabilityModel.fromJson(Map<String, dynamic> map) {
    return AdminAvailabilityModel();
  }
}
