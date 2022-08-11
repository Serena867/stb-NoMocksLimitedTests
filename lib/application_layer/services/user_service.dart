import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:split_the_bill/domain_layer/entities/user.dart';
import 'package:split_the_bill/domain_layer/repository_interfaces/IUserRepository.dart';

///Current controller and services are setup to accommodate future changes and
///to save time having to plumb them in later.

@Injectable()
class UserService {
  final IUserRepository _userRepository;

  UserService({required IUserRepository userRepository})
      : _userRepository = userRepository;

  Future<List<User>> getAllUsers() async {
    List<User> users = [];
    var data = await _userRepository.readAllUsers();
    for (var userData in data) {
      User user = User(
          userID: userData.userID,
          firstName: userData.firstName,
          lastName: userData.lastName,
          email: userData.email);
      users.add(user);
    }
    return users;
  }

  Future<dynamic> memoizeGetAllUsers(AsyncMemoizer userMemoizer) async {
    return userMemoizer.runOnce(() async {
      await Future.delayed(const Duration(microseconds: 5));
      return getAllUsers();
    });
  }

  Future<User> getUserById(String id) async {
    var data = await _userRepository.readUserByID(id);
    User user = User(
        userID: data.userID,
        firstName: data.firstName,
        lastName: data.lastName,
        email: data.email);
    return user;
  }

  Future<dynamic> memoizeGetUserById(
      AsyncMemoizer userMemoizer, String id) async {
    return userMemoizer.runOnce(() async {
      await Future.delayed(const Duration(microseconds: 5));
      return getUserById(id);
    });
  }

  updateUser(User user) async {
    return await _userRepository.updateUser(user);
  }

  addUser(User user) async {
    return await _userRepository.addUser(user);
  }

  deleteUser(String id) async {
    return await _userRepository.deleteUser(id);
  }
}
