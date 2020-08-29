

import 'package:image_picker/image_picker.dart';

List<UserCredentials> userCredentials = [new UserCredentials("Md Shakib Uddin Bhuiyan", "shakibuddinbhuiyan@gmail.com", "01794508014", "sakib")];
UserCredentials currentUser;
List<Post> posts = [];
double latitude;
double longitude;

class UserCredentials{
  static int userID = 0;
  String name;
  String email;
  String mobile;
  String password;
  UserCredentials(this.name,this.email,this.mobile,this.password);
}

class Post{
  static int postID = 0;
  String userName;
  String description;
  String imagePath;
  String mobile;
  String address;
  String email;
  Post(this.userName, this.description, this.imagePath, this.mobile, this.address,
      this.email);
}
