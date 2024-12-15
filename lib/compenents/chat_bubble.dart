
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;
  const ChatBubble({super.key, required this.message, required this.isCurrentUser, required this.messageId, required this.userId});

  //showoption
  void _showOptions(BuildContext context, String messageId, String userId){
    showModalBottomSheet(
      context: context,
       builder: (context){
        return SafeArea(
          child: Wrap(
            children: [
              //report message button
              ListTile(
                leading: Icon(Icons.flag),
                title: Text("Report"),
                onTap: (){
                  //navigate the menu
                  Navigator.pop(context);
                  _reportMessage(context, messageId, userId);

                },
              ),


              //block user button
                 ListTile(
                leading: Icon(Icons.block),
                title: Text("Block User"),
                onTap: (){
                  Navigator.pop(context);
                  _blockUser(context, userId);

                },
              ),

              //cancel button
                    ListTile(
                leading: Icon(Icons.cancel),
                title: Text("Cancel"),
                onTap: (){
                  Navigator.pop(context);

                },
              ),


            ],
          ),
        );
       }
       );
  }

  //report message
  void _reportMessage(BuildContext context, String messageId, String userId){
    showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
        title: Text("Report message"),
        content: Text("Are you sure you want to report this message?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: ()=>Navigator.pop(context),
             child: Text("Cancel")
             ),

             //report button
              TextButton(
            onPressed: (){
          
              ChatServices().reportUser(messageId, userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Message reported"),
                      )
                    );

            },
             child: Text("Report")
             ),


        ],
      )
      );
  }


  //block user
    void _blockUser(BuildContext context,  String userId){
    showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
        title: Text("Block user"),
        content: Text("Are you sure you want to block this user?"),
        actions: [
          //cancel button
          TextButton(
            onPressed: ()=>Navigator.pop(context),
             child: Text("Cancel")
             ),

             //block button
              TextButton(
            onPressed: (){
          
              ChatServices().blockUser(userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("User Blocked"),
                      )
                    );

            },
             child: Text("Block")
             ),


        ],
      )
      );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        if(!isCurrentUser){
          //show option
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
         color: isCurrentUser? Colors.green:Colors.grey.shade500,
         borderRadius: BorderRadius.circular(12)
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Text(message),
      ),
    );
  }
}