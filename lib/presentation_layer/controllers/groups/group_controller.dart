

import 'package:injectable/injectable.dart';
import 'package:split_the_bill/application_layer/services/group_service.dart';

import '../../../domain_layer/entities/bill_group.dart';

@Injectable()
class GroupController {
  final GroupService _groupService;

  GroupController({required GroupService groupService}) : _groupService = groupService;

  Future<BillGroup> getGroupByID(String groupID) {
    return _groupService.getGroupByID(groupID);
  }

  Future<List<BillGroup>> getAllGroups() {
    return _groupService.getAllGroups();
  }

  updateGroup(BillGroup group) {
    return _groupService.updateGroup(group);
  }

  addGroup(BillGroup group) {
    return _groupService.addGroup(group);
  }

  deleteGroup(BillGroup group) {
    return _groupService.deleteGroup(group.groupID);
  }

}