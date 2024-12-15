


import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatServices extends ChangeNotifier{

  //get instance of the firestore
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  //get user stream

  /*
  this is basically a list of map 
  List<Map<String, dynamic>>
  [
  {
  "email": test@gmail.com,
  "id":....
  }
   {
  "email": test2@gmail.com,
  "id":....
  }
  ]

   */

  //GET ALLUSER STREAM
  Stream<List<Map<String,dynamic>>> getUserStream(){
    return _firestore.collection("User").snapshots().map((snapshot) {
      return snapshot.docs
      .where((doc) =>doc.data()['email']!=_auth.currentUser!.email)
      .map((doc) => doc.data())
      .toList();
    });

  }




  //stream is basically listen the firestore 
  // Stream<List<Map<String, dynamic>>> getUsersStream(){
  //   //Adding Data: If a new user document is added to the User collection, 
  //   //.snapshots() will notify your app with the updated collection.

  //   //.snapshots() listens to real-time changes in this collection
  //   //Every time data is added, removed, or updated in the User collection, a new snapshot is emitted by the stream.
  //   //A snapshot represents the state of the User collection at a specific point in time.
  //   return _firestore.collection("User").snapshots().map((snapshot) {
  //     //snapshot.docs gives a list of all documents in the User collection.
  //     //.map((doc) {...}) processes each document (doc) in the list.
  //     return snapshot.docs.map((doc) {
  //       //go through eash individual user 
  //       final user=doc.data();

  //       //return user
  //       return user;
  //     }).toList();
  //   });

  // }

  //GET ALL USER STREAM EXCEPT BLOCK USER

  Stream<List<Map<String, dynamic>>> getuserStreamExcludingBlocked(){
    final currentUser=_auth.currentUser;
    return _firestore
    .collection("User")
    .doc(currentUser!.uid)
    .collection("BlockedUsers")
    .snapshots()
    .asyncMap((snapshot) async{

      //get blocked user id
      final blockedUserIds=snapshot.docs.map((doc) => doc.id).toList();

      //get all users
      final userSnapshot=await _firestore.collection("User").get();

      //return a stream list, excluding currrent user and blocked user display all the user in home page
      return userSnapshot.docs
      .where((doc) => doc.data()!=currentUser.email&&!blockedUserIds.contains(doc.id))
      .map((doc) => doc.data()).toList();

    });


  }
 


  //send message 
  Future<void> sendMessage(String receiverID, messages)async{
    //get current user info
    final String currentUserID=_auth.currentUser!.uid;
    final String currentuserEmail=_auth.currentUser!.email!;
    final Timestamp timestamp=Timestamp.now();

    //create a new message
    Messages newMessage=Messages(
      senderID: currentUserID,
       senderEmail: currentuserEmail, 
       receiverID: receiverID,
        messages: messages,
         timestamp: timestamp
         );

    //construct chat room Id for the two users(sorted to ensure uniqueness) 
    List<String> ids=[currentUserID, receiverID];
    ids.sort(); //sort the ids(this ensure the chatroom id is the same for any two peopal)

    String chatRoomID=ids.join("_");

    //add new message to database
    await _firestore.collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .add(newMessage.toMap());

  }

  //get message message
  Stream<QuerySnapshot> getMessage(String userID,otherUserID){
    //constrcut the chat room ids for two user

    List<String> ids=[userID, otherUserID];
    ids.sort();
    String chatRoomID=ids.join("_");

    return _firestore
    .collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .orderBy("timestamp", descending: false)
    .snapshots();


    
  }

  //REPORT USER

  Future<void> reportUser(String messageId, String userId)async{
    final currentuser=_auth.currentUser;
    final report={
      "reportedBy":currentuser!.uid,
      "messageId":messageId,
      "messageOwnerId":userId,
      'timestamp':FieldValue.serverTimestamp()

    };
    await _firestore.collection("Reports").add(report);

  }

  //BLOCK USER
Future<void> blockUser(String userId) async {
  final currentuser = _auth.currentUser;

  await _firestore
      .collection("User")
      .doc(currentuser!.uid) // Get the current user's document
      .collection("BlockedUsers") // Create or access the "BlockedUsers" sub-collection
      .doc(userId) // Add a document with the blocked user's ID
      .set({}); // Store an empty map to represent the blocked user

  notifyListeners(); // Notify listeners about the change
}


  //UNBLOCK USER
  Future<void> unblockUser(String blockedUserId)async{
    final currentuser=_auth.currentUser;

    await _firestore
    .collection("User")
    .doc(currentuser!.uid)
    .collection("BlockedUsers")
    .doc(blockedUserId)
    .delete();
  
    

  }

  //GET BLOCK USER STREAM
  Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userId){
    return _firestore
    .collection("User")
    .doc(userId)
    .collection("BlockedUsers")
    .snapshots()
    .asyncMap((snapshot)async{
      //get list of block user ids
      final blockedUserIds=snapshot.docs.map((doc) => doc.id).toList();

      final userDocs=await Future.wait(
        blockedUserIds
        .map((id) => _firestore.collection("User").doc(id).get())
      );

      //rerurn as list
      return userDocs.map((doc) => doc.data()as Map<String, dynamic>).toList();


    });
  }


}