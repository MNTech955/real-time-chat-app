
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  //instance of auth 
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser(){
    return _auth.currentUser;
  }


  //sign in

  Future<UserCredential> signInWithEmailPassword(String email, String password)async{
    try{
      UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      //save user info if does not already exit
        await _firestore.collection("User").doc(userCredential.user!.uid).set({
          "uid":userCredential.user!.uid,
          'email':email

         });

      return userCredential;

    }catch(e){
      throw Exception(e.toString());
    }
  }

  //sign up

  Future<UserCredential> signUpWithEmailPassword(String email, String password)async{
    try{
      UserCredential userCredential=await _auth.createUserWithEmailAndPassword(
        email: email,
         password: password
         );

         //save user info into separte doc 
         await _firestore.collection("User").doc(userCredential.user!.uid).set({
          "uid":userCredential.user!.uid,
          'email':email

         });

         return userCredential;


    }on FirebaseAuthException catch(e){
      throw Exception(e.toString());
    }

  }

  //sign out

  Future<void> signOut()async{
    await _auth.signOut();

  }

  //error

}