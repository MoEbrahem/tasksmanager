import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasksmanager/model/TaskModel.dart';

class FirebaseUtils {

  // add Task

  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance.collection("users").withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addTasktoFireStore(Task task) {
    var taskCollection = getTasksCollection();
    DocumentReference<Task> taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task t) async{
    await getTasksCollection().doc(t.id).delete();
    
  }
    static Future<void> editTaskFromFireStore(Task t) async{
    await getTasksCollection().doc(t.id).update({
      "title": t.title,
      "desc": t.desc,
      "dateTime": t.dateTime
    },
    );
    
  }
  
}
