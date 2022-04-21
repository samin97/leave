import 'package:first_app/global/error_dialog.dart';
import 'package:first_app/global/global.dart';
import 'package:first_app/main_screen/home_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  formValidation() {
    if (emailController.text.isNotEmpty) {
      if (passwordController.text.isNotEmpty) {
        loginNow();
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(message: "Please enter password");
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
                message: "Please enter email and password");
          });
    }
  }

  Future loginNow() async {
    await sharedPreferences?.setString("email", emailController.text);
    Route newRoute = MaterialPageRoute(builder: (_) => const HomeScreen());
    Navigator.pushReplacement(context, newRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email'),
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Password'),
                controller: passwordController,
              ),
              ElevatedButton(
                  onPressed: () {
                    formValidation();
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
