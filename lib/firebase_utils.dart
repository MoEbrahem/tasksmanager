import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasksmanager/model/TaskModel.dart';
import 'package:tasksmanager/model/userModel.dart';

class FirebaseUtils {
  // user

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: ((snapshot, option) =>
              UserModel.fromFireStore(snapshot.data()!)),
          toFirestore: (usersModel, option) => usersModel.toFireStore(),
        );
  }

  static Future<void> addUserToFirebase(UserModel user) {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<UserModel?> readUserfromFireStore(String userid) async {
    var querySnapshot = await getUsersCollection().doc(userid).get();
    return querySnapshot.data();
  }

  // add Task

  static CollectionReference<Task> getTasksCollection(String uid) {
    return getUsersCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addTasktoFireStore(Task task, String uid) {
    var taskCollection = getTasksCollection(uid);
    DocumentReference<Task> taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task t, String uid) async {
    await getTasksCollection(uid).doc(t.id).delete();
  }

  static Future<void> editTaskFromFireStore(Task t, String uid) async {
    await getTasksCollection(uid).doc(t.id).update(
      {
        "title": t.title,
        "desc": t.desc,
        "dateTime": t.dateTime,
      },
    );
  }
}
