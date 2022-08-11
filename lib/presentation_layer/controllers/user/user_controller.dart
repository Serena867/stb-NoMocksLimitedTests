import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:split_the_bill/application_layer/services/user_service.dart';
import '../../../domain_layer/entities/user.dart';

///Current controller and services are setup to accommodate future changes and
///to save time having to plumb them in later.

@Injectable()
class UserController {
  final UserService _userService;

  UserController({required UserService userService})
      : _userService = userService;

  Future<List<User>> getAllUsers() {
    return _userService.getAllUsers();
  }

  Future<dynamic> memoizeGetAllUsers(AsyncMemoizer userMemoizer) {
    return _userService.memoizeGetAllUsers(userMemoizer);
  }

  Future<User> getUserById(String id) {
    return _userService.getUserById(id);
  }

  Future<dynamic> memoizeGetUserById(AsyncMemoizer userMemoizer, String id) {
    return _userService.memoizeGetUserById(userMemoizer, id);
  }

  updateUser(User user) {
    return _userService.updateUser(user);
  }

  addUser(User user) {
   return _userService.addUser(user);
  }

  deleteUser(String id) {
    return _userService.deleteUser(id);
  }
}
