class UserModel {
  String userName;
  String userEmail;
  String? userImage;
  String userUid;
  UserModel({
    required this.userEmail,
 this.userImage,
    required this.userName,
    required this.userUid,
  });
}