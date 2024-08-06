class UserModel {
  static String collectionName = "users";

  String id;
  String userName;
  String email;
  UserModel({required this.id, required this.userName, required this.email});
  UserModel.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String,
          userName: data['userName'] as String,
          email: data["email"] as String,
        );
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
    };
  }
}
