
import 'package:chat_app/compenents/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auh_services.dart';
import 'package:chat_app/compenents/my_drawer.dart';
import 'package:chat_app/services/chat/chat_services.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  //chat and auth services

  final ChatServices _chatServices=ChatServices();
  final AuthServices _authServices=AuthServices();

  


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        
        
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }
  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatServices.getuserStreamExcludingBlocked(),
       builder: (context, snapshot){
        //error
        if(snapshot.hasError){
          return Text("Error");

        }

        //loading....
        if(snapshot.connectionState==ConnectionState.waiting){
          return Text("Loading ");
        }

        return ListView(
          children: snapshot.data!.map((userData) => _buildUserListItem(userData, context)).toList()
        );
       }
       );
  }
  //build individual  list tile for user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    //display all user except current user 
    if(userData['email'] !=_authServices.getCurrentUser()!.email){
      return UserTile(
      text: userData["email"], 
      onTap: (){
        //tapped on a user ->go to chat page

        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
          receiverEmail: userData["email"],
          receiverID: userData['uid'],
          )
          )
          );
      }
      );
    }else{
      return Container();
    }
  }
}