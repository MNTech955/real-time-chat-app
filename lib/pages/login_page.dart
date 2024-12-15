import 'package:chat_app/services/auth/auh_services.dart';
import 'package:chat_app/compenents/my_button.dart';
import 'package:chat_app/compenents/my_textField.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  // Tap to go to the register page
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  bool _isLoading = false;

  // Method to handle login
  void login(BuildContext context) async {
    // Auth services instance
    final authServices = AuthServices();

    // Save parent context to ensure it remains valid after the await
    final parentContext = context;

    // Try login
    setState(() {
      _isLoading = true; // Show loading state
    });

    try {
      await authServices.signInWithEmailPassword(
          emailController.text, pwController.text);

      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _isLoading = false; // Hide loading state after success
        });
      }
    } catch (e) {
      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _isLoading = false; // Ensure loading stops in case of an error
        });
      }

      // Show error dialog using the parent context
      showDialog(
        context: parentContext,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              // Logo
              Icon(Icons.message,
                  size: 60, color: Theme.of(context).colorScheme.primary),
              SizedBox(
                height: 50,
              ),

              // Welcome back message
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 25,
              ),

              // Email textField
              MyTextField(
                hintext: "Email..",
                obscureText: false,
                controller: emailController,
              ),
              SizedBox(
                height: 10,
              ),

              // Password textField
              MyTextField(
                hintext: "Password..",
                obscureText: true,
                controller: pwController,
              ),
              SizedBox(
                height: 25,
              ),

              // Login button
              MyButton(
                text: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary),
                      )
                    : Text("Login",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                onTap: _isLoading
                    ? null
                    : () => login(context), // Disable button when loading
              ),
              SizedBox(
                height: 25,
              ),

              // Register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
