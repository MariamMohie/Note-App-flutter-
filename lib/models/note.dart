import 'package:flutter/cupertino.dart';
//class to define the properties of the note
class Note {
  int? id;
  String?title, description;
  DateTime ? createdAt;

  Note({
    this.id,

    // we used required cuz this 3 requirment needed every time ,but id will be uto increament
    required this.title,
    required this.description,
    required this.createdAt,
  });
  //convert my requirement into Map to be stored in DB
  Map<String,dynamic> toMap(){
    return{
      'title':title,
      'description':description,
      // convert it to a text as we do in database
      'createdAt':createdAt.toString(),

    };
}
}