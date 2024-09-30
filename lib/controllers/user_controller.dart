import 'package:get/get.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  var user = Rxn<User>();

  void setUser(User newUser) {
    user.value = newUser;
  }

  double getProfileCompletionPercentage() {
    if (user.value == null) return 0.0;

    int completedFields = 0;
    int totalFields = 5; // Adjust this based on your user model

    if (user.value!.name.isNotEmpty) completedFields++;
    if (user.value!.email.isNotEmpty) completedFields++;
    if (user.value!.avatar.isNotEmpty) completedFields++;
    // Add more fields as needed

    return (completedFields / totalFields) * 100;
  }
}
