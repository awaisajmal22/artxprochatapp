import 'package:artxprochatapp/AppModule/GroupChatModule/Model/group_chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/SizeConfig/size_config.dart';

class GroupChatViewModel extends GetxController {
  RxBool isUser = false.obs;
  RxInt textFieldTextLenght = 40.obs;
  final groupChatInputController = TextEditingController();
  RxInt textFieldLines = 1.obs;

  
  RxList<GroupChatModel> groupList = <GroupChatModel>[
    GroupChatModel(
        groupImage:
            'https://images.pexels.com/photos/18005100/pexels-photo-18005100/free-photo-of-an-interior-with-potted-plants-and-pictures-in-frames.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        groupName: 'NewYork is My City',
        id: 1,
        userModel: [
          GroupUsersModel(
            groupCreatedBy: true.obs,
            id: 1,
            userImage:
                'https://images.pexels.com/photos/18125927/pexels-photo-18125927/free-photo-of-woman-on-the-stairwell-of-a-parking-garage.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Umer',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 2,
            userImage:
                'https://images.pexels.com/photos/18377390/pexels-photo-18377390/free-photo-of-city-street-building-pattern.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jamal',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 3,
            userImage:
                'https://images.pexels.com/photos/15488686/pexels-photo-15488686/free-photo-of-red-cabriolet-car-with-flowers-arrangement.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Kashif',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/12792408/pexels-photo-12792408.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jahan',
          )
        ]),
    GroupChatModel(
        groupImage:
            'https://images.pexels.com/photos/18005100/pexels-photo-18005100/free-photo-of-an-interior-with-potted-plants-and-pictures-in-frames.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        groupName: 'Kawait',
        id: 2,
        userModel: [
          GroupUsersModel(
            groupCreatedBy: true.obs,
            id: 1,
            userImage:
                'https://images.pexels.com/photos/18125927/pexels-photo-18125927/free-photo-of-woman-on-the-stairwell-of-a-parking-garage.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Umer',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 2,
            userImage:
                'https://images.pexels.com/photos/18377390/pexels-photo-18377390/free-photo-of-city-street-building-pattern.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jamal',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 3,
            userImage:
                'https://images.pexels.com/photos/15488686/pexels-photo-15488686/free-photo-of-red-cabriolet-car-with-flowers-arrangement.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Kashif',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/12792408/pexels-photo-12792408.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jahan',
          )
        ]),
    GroupChatModel(
        groupImage:
            'https://images.pexels.com/photos/18005100/pexels-photo-18005100/free-photo-of-an-interior-with-potted-plants-and-pictures-in-frames.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        groupName: 'America',
        id: 3,
        userModel: [
          GroupUsersModel(
            groupCreatedBy: true.obs,
            id: 1,
            userImage:
                'https://images.pexels.com/photos/18125927/pexels-photo-18125927/free-photo-of-woman-on-the-stairwell-of-a-parking-garage.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Umer',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 2,
            userImage:
                'https://images.pexels.com/photos/18377390/pexels-photo-18377390/free-photo-of-city-street-building-pattern.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jamal',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 3,
            userImage:
                'https://images.pexels.com/photos/15488686/pexels-photo-15488686/free-photo-of-red-cabriolet-car-with-flowers-arrangement.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Kashif',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/12792408/pexels-photo-12792408.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jahan',
          )
        ]),
    GroupChatModel(
        groupImage:
            'https://images.pexels.com/photos/18005100/pexels-photo-18005100/free-photo-of-an-interior-with-potted-plants-and-pictures-in-frames.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        groupName: 'Pakistan',
        id: 1,
        userModel: [
          GroupUsersModel(
            groupCreatedBy: true.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/18125927/pexels-photo-18125927/free-photo-of-woman-on-the-stairwell-of-a-parking-garage.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Umer',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 2,
            userImage:
                'https://images.pexels.com/photos/18377390/pexels-photo-18377390/free-photo-of-city-street-building-pattern.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jamal',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 3,
            userImage:
                'https://images.pexels.com/photos/15488686/pexels-photo-15488686/free-photo-of-red-cabriolet-car-with-flowers-arrangement.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Kashif',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/12792408/pexels-photo-12792408.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jahan',
          )
        ])
  ].obs;
}
