import 'package:injectable/injectable.dart';
import 'package:split_the_bill/data_layer/models/bill_group_dto.dart';
import 'package:split_the_bill/domain_layer/entities/bill_group.dart';
import '../../domain_layer/repository_interfaces/IGroupRepository.dart';
import '../data_sources/IDatasource.dart';

@Singleton(as: IGroupRepository)
class GroupRepository implements IGroupRepository {
  final IDatasource _datasource;

  GroupRepository({required IDatasource datasource}) : _datasource = datasource;

  @override
  addGroup(BillGroup group) async {
    var groupModel = BillGroupDTO(
        groupID: group.groupID, groupName: group.groupName, bills: group.bills);
    return await _datasource.addGroup(groupModel);
  }

  @override
  Future<List<BillGroupDTO>> readAllGroups() async {
    return await _datasource.readAllGroups();
  }

  @override
  Future<BillGroupDTO> readGroupById(groupID) async {
    return await _datasource.readGroupById(groupID);
  }

  @override
  updateGroup(BillGroup group) async {
    var groupModel = BillGroupDTO(
        groupID: group.groupID, groupName: group.groupName, bills: group.bills);
    return await _datasource.updateGroup(groupModel);
  }

  @override
  deleteGroup(groupID) async {
    return await _datasource.deleteGroup(groupID);
  }
}
