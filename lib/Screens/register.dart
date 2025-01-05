import 'package:flutter/material.dart';
import '../Services/auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class Register extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller = TextEditingController();
  final void Function()? onTap;

  Register({super.key, required this.onTap});

  void register(BuildContext context) {
    final _auth = AuthService();

    if (_passwordcontroller.text == _confirmpasswordcontroller.text) {
      try {
        _auth.SignupWithUserAndPassword(
          _emailcontroller.text.trim(),
          _passwordcontroller.text.trim(),
        );


      } catch (e) {
        // Show error dialog if registration fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      // Show error dialog if passwords don't match
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Passwords don't match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 50),
              const Text(
                "Let's create an account for you",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              // Email TextField
              MyTextfield(
                hinttext: "Email",
                obsecureText: false,
                controller: _emailcontroller,
              ),
              const SizedBox(height: 10),
              // Password TextField
              MyTextfield(
                hinttext: "Password",
                obsecureText: true,
                controller: _passwordcontroller,
              ),
              const SizedBox(height: 10),
              // Confirm Password TextField
              MyTextfield(
                hinttext: "Confirm Password",
                obsecureText: true,
                controller: _confirmpasswordcontroller,
              ),
              const SizedBox(height: 25),
              // Register Button
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),
              const SizedBox(height: 25),
              // Login Redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      'Login now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
