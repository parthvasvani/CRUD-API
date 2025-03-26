import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => authController.userEmail.isNotEmpty
                ? Text('Welcome, ${authController.userEmail.value}', style: TextStyle(fontSize: 18))
                : Text('Welcome, Guest', style: TextStyle(fontSize: 18))),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => authController.logout(),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
