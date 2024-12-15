import 'package:chat_app/compenents/user_tile.dart';
import 'package:chat_app/services/auth/auh_services.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class BlockUserPage extends StatelessWidget {
    BlockUserPage({super.key});

  //chat and auth services

  final ChatServices chatServices=ChatServices();
  final  AuthServices authServices=AuthServices();

  //show confirm unblock box
  void _showUnBlockBox(BuildContext context, String userId){
    showDialog(
      context: context,
       builder: (context)=>AlertDialog(
        title: Text("Unblock User"),
        content: Text("Are you sure you want to unblock this user?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: ()=>Navigator.pop(context),
             child: Text("Cancel"),
             ),


          //unblock button
           TextButton(
            onPressed: (){
              chatServices.unblockUser(userId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("User unblocked"))
              );

            },
             child: Text("Unblock"),
             ),

        ],

       )
       );

  }

  @override
  Widget build(BuildContext context) {
    String userId=authServices.getCurrentUser()!.uid;
    return Scaffold(
     // backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Blocked User"),
       backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        actions: [],
      ),
      body: StreamBuilder<List<Map<String,dynamic>>>(
        stream: chatServices.getBlockedUsersStream(userId),
         builder: (context, snapshot){

          //error
          if(snapshot.hasError){
            return Center(
              child: Text("Error loading..."),
            );
          }
          //loading
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final blockedUsers=snapshot.data??[];
          //no user
          if(blockedUsers.isEmpty){
            return  Center(
              child: Text("No Blocked users"),
            );
          }
          //load complete 
          return ListView.builder(
            itemCount: blockedUsers.length,
            itemBuilder: (context, index){
              final user=blockedUsers[index];

              return UserTile(
                text: user['email'],
                 onTap: ()=>_showUnBlockBox(context, user['uid']),
                 );
            }
            );
         }
         ),

    );
  }
}