import 'package:chat_app/services/auth/auh_services.dart';
import 'package:chat_app/compenents/my_button.dart';
import 'package:chat_app/compenents/my_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  //tap to go to login page
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController ConfirmPwController = TextEditingController();
  bool _isLoading = false;

  void Register(BuildContext context) async {
    //get auth services
    final _auth = AuthServices();

    // Save parent context to ensure it's valid
    final parentContext = context;

    //pw and confirm pw matched
    if (pwController.text == ConfirmPwController.text) {
      try {
        setState(() {
          _isLoading = true; // Show loading state
        });

        await _auth.signUpWithEmailPassword(
            emailController.text, pwController.text);

        if (mounted) {
          setState(() {
            _isLoading = false; // Stop loading after success
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false; // Stop loading on error
          });
        }

        // Use parent context for the dialog
        showDialog(
          context: parentContext,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    //password donot matched show error==> tell user to fix it
    else {
      // Use parent context for the dialog
      showDialog(
          context: parentContext,
          builder: (context) => AlertDialog(
                title: Text("Password don't matched"),
              ));
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
              //logo
              Icon(Icons.message,
                  size: 60, color: Theme.of(context).colorScheme.primary),
              SizedBox(
                height: 50,
              ),

              //welcome back message
              Text(
                "Lets create an account for you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 25,
              ),

              //name  textField
              MyTextField(
                  hintext: "name..",
                  obscureText: false,
                  controller: nameController),
              SizedBox(
                height: 10,
              ),

              //email textField
              MyTextField(
                hintext: "Email..",
                obscureText: false,
                controller: emailController,
              ),
              SizedBox(
                height: 10,
              ),

              //pw textField
              MyTextField(
                hintext: "Password..",
                obscureText: true,
                controller: pwController,
              ),
              SizedBox(
                height: 10,
              ),

              //confirm password controller
              MyTextField(
                hintext: "Confirm Password..",
                obscureText: true,
                controller: ConfirmPwController,
              ),
              SizedBox(
                height: 25,
              ),

              //login button
              MyButton(
                text: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text("Register",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                onTap: _isLoading
                    ? null
                    : () => Register(context), // Disable button when loading
              ),
              SizedBox(
                height: 25,
              ),

              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
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
