import 'package:chat_app/services/auth/auh_services.dart';
import 'package:chat_app/pages/setting_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
   void logOut(){
    //get auth services 
    final _auth=AuthServices();
     _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
            ),
          ),


          //home List Tile
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("H O M E"),
              leading: Icon(Icons.home),
              onTap: (){
                //pop the drawer 
                Navigator.pop(context);
              },
            ),
          ),

          //setting listTile
              Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("S E T T I N G S"),
              leading: Icon(Icons.settings),
              onTap: (){
                //pop the drawer 
                Navigator.pop(context);

                //navigate to the setting page 

                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
              },
            ),
          ),

          //logout list tile 
          Spacer(),
          
              Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: logOut,
            ),
            
          ),
        ],
      ),
    );
  }
}