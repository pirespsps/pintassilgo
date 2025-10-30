import 'package:pintassilgo/models/User/user.dart';
import 'package:pintassilgo/models/genericDAO.dart';

class Userdao extends GenericDAO<User> {

  @override
  User fromMap(item){
    User.fromMap(item);
    return User.fromMap(item);
  }

  @override
  Map<String, dynamic> toMap(User object){
    return object.toMap();
  }

}