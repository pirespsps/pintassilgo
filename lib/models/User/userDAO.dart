import 'package:pintassilgo/models/User/user.dart';
import 'package:pintassilgo/models/genericDAO.dart';

class UserDAO extends GenericDAO<User> {

  @override
  String table = "tbUser";

  @override
  User fromMap(item){
    return User.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(User object){
    return object.toMap();
  }

}