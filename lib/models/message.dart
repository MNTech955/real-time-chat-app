
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages{
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String messages;
  final Timestamp timestamp;

  Messages({
    required this.senderID,
    required this.senderEmail, 
    required this.receiverID,
    required this.messages, 
    required this.timestamp
  });

  //convert to map
  Map<String, dynamic> toMap(){
    return{
      "senderID":senderID,
      "senderEmail":senderEmail,
      "receiverID":receiverID,
      "messages":messages,
      "timestamp":timestamp,
    };
  }

}