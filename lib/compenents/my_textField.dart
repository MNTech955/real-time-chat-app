import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintext;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextField({super.key, required this.hintext, required this.obscureText, required this.controller, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary
            ), 
            
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:  Theme.of(context).colorScheme.tertiary
            )
          ), 
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintext,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)
        ),
      ),
    );
  }
}