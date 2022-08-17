import '../../data_layer/models/bill_group_dto.dart';
import '../entities/bill_group.dart';

abstract class IGroupRepository {
  addGroup(BillGroup group);
  Future<List<BillGroupDTO>> readAllGroups();
  Future<BillGroupDTO> readGroupById(groupID);
  updateGroup(BillGroup group);
  deleteGroup(groupID);
}