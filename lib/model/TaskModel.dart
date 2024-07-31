
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  String desc;
  DateTime dateTime;
  bool isDone;
  Task({
    this.id = '',
    required this.title,
    required this.desc,
    required this.dateTime,
    this.isDone = false,
  });


    
  
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "dateTime": dateTime,
      "isDone": isDone,
    };
  }
    Task.fromFireStore(Map<String, dynamic> json) :this(
    id: json["id"] as String,
    title: json["title"] as String,
    desc: json["desc"] as String,
    dateTime: (json["dateTime"]as Timestamp).toDate(),
    isDone: json["isDone"] ,
    );
    


}
