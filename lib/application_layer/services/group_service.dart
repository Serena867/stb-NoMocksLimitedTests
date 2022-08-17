import 'package:injectable/injectable.dart';
import 'package:split_the_bill/domain_layer/repository_interfaces/IGroupRepository.dart';

import '../../domain_layer/entities/bill_group.dart';

@Injectable()
class GroupService {
  final IGroupRepository _groupRepository;

  GroupService({required IGroupRepository groupRepository})
      : _groupRepository = groupRepository;

  Future<BillGroup> getGroupByID(String groupID) async {
    var data = await _groupRepository.readGroupById(groupID);
    var groupModel = BillGroup(
        groupID: data.groupID, groupName: data.groupName, bills: data.bills);
    return groupModel;
  }

  Future<List<BillGroup>> getAllGroups() async {
    List<BillGroup> groups = [];
    var data = await _groupRepository.readAllGroups();
    for (var groupData in data) {
      var groupModel = BillGroup(groupID: groupData.groupID, groupName: groupData.groupName, bills: groupData.bills);
      groups.add(groupModel);
    }
    return groups;
  }

  updateGroup(BillGroup group) async {
    return await _groupRepository.updateGroup(group);
  }

  addGroup(BillGroup group) async {
    return await _groupRepository.addGroup(group);
  }

  deleteGroup(String groupID) async {
    return await _groupRepository.deleteGroup(groupID);
  }


}
