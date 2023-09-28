import 'package:artxprochatapp/AppModule/HomeModule/Model/group_chat_model.dart';
import 'package:get/get.dart';

class GroupChatModel {
  int? id;
  String? groupImage;
  String? groupName;
  List<GroupUsersModel>? userModel;
  GroupChatModel({
    this.groupImage,
    this.groupName,
    this.id,
    this.userModel,
  });
}

class GroupUsersModel {
  int? id;
  String? userImage;
  String? userName;
  RxBool? groupCreatedBy;
  GroupUsersModel({
    this.groupCreatedBy,
    this.id,
    this.userImage,
    this.userName,
  });
}
