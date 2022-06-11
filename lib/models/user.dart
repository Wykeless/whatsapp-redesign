class User {
  //user propeties
  String? username = '';
  List<String>? textMessages = [];
  String? profilePictureUrl = '';
  String? statusUrl = '';

  //constructor for the user class
  User({
    this.username,
    this.textMessages,
    this.profilePictureUrl,
    this.statusUrl,
  });
}
