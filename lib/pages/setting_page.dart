import 'package:chat_app/pages/blocked_user_page.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Settings"),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
        ),
        //dark mode
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                //dark mode
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //drak mode

                      Text("dark Mode"),

                      //switch toggle
                      CupertinoSwitch(
                          value:
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .isDarkMode,
                          onChanged: (value) =>
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme()),
                    ],
                  ),
                ),
                //blocked user
                    Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //drak mode

                      Text("Blocked User"),

                      //button to go to block user page 
                      IconButton(
                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockUserPage())),
                         icon: Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary,)
                         )
                    
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
