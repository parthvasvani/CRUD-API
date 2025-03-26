import 'package:get/get.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  RxString userEmail = ''.obs; // ✅ Added observable for email

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  void getCurrentUser() {
    User? user = _authService.getCurrentUser();
    if (user != null) {
      userEmail.value = user.email ?? '';
    }
  }

  Future<void> registerUser(String email, String password, String name) async {
    User? user = await _authService.registerUser(email, password, name);
    if (user != null) {
      userEmail.value = email;  // ✅ Set email after registration
      Get.snackbar("Success", "Registration successful!");
      Get.offNamed('/home');
    } else {
      Get.snackbar("Error", "Registration failed!");
    }
  }

  Future<void> loginUser(String email, String password) async {
    User? user = await _authService.loginUser(email, password);
    if (user != null) {
      userEmail.value = email;  // ✅ Set email after login
      Get.snackbar("Success", "Login successful!");
      Get.offNamed('/home');
    } else {
      Get.snackbar("Error", "Invalid credentials!");
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    userEmail.value = '';  // ✅ Clear email on logout
    Get.offNamed('/login');
  }
}
