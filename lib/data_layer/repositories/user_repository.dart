import 'package:injectable/injectable.dart';
import 'package:split_the_bill/data_layer/data_sources/IDatasource.dart';
import 'package:split_the_bill/data_layer/models/user_dto.dart';
import '../../domain_layer/entities/user.dart';
import '../../domain_layer/repository_interfaces/IUserRepository.dart';

@Singleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IDatasource _datasource;

  UserRepository({required IDatasource datasource}) : _datasource = datasource;

  @override
  addUser(User user) async {
    var userModel = UserDTO(
        userID: user.userID,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email);
    return await _datasource.addUser(userModel);
  }

  @override
  Future<List<UserDTO>> readAllUsers() async {
    return await _datasource.readAllUsers();
  }

  @override
  Future<UserDTO> readUserByID(userID) async {
    return await _datasource.readUserById(userID);
  }

  @override
  updateUser(User user) async {
    var userModel = UserDTO(
        userID: user.userID,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email);
    return await _datasource.updateUser(userModel);
  }

  @override
  deleteUser(userID) async {
    return await _datasource.deleteUser(userID);
  }
}
