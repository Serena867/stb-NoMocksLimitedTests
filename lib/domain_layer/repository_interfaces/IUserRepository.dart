import '../../data_layer/models/user_dto.dart';
import '../entities/user.dart';

abstract class IUserRepository {
  addUser(User user);
  Future<List<UserDTO>> readAllUsers();
  Future<UserDTO> readUserByID(userID);
  updateUser(User user);
  deleteUser(userID);
}