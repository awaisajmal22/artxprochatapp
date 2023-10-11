import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/SizeConfig/size_config.dart';
import '../../Model/group_chat_model.dart';
import '../../Model/groups_model.dart';
import '../../ViewModel/group_chat_view_model.dart';

class MobileGroupPeopleListView extends StatelessWidget {
  Rx<GroupsModel> groupModel;
  int groupIndex;
  MobileGroupPeopleListView({
    Key? key,
    required this.groupModel,
    required this.groupIndex,
    // required this.controller,
  }) : super(key: key);

  final groupVM = Get.put(GroupChatViewModel());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: SizeConfig.heightMultiplier * 7.5,
        width: SizeConfig.widthMultiplier * 100,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: SizeConfig.widthMultiplier * 3,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 7.5,
              child: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.groupChatSettingView, arguments: [
                      groupModel.value,
                      groupVM.groupMembersList
                    ]);
                  },
                  child: Container(
                    height: SizeConfig.heightMultiplier * 6,
                    width: SizeConfig.widthMultiplier * 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: AssetImage('assets/images/Group.png'),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: Offset(
                                0, 3), // Offset in the x and y directions
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 3,
            ),
            Obx(
              () => groupVM.groupMembersList.isEmpty
                  ? SizedBox.shrink()
                  : Row(
                      children: List.generate(groupVM.groupMembersList.length,
                          (index) {
                        bool isEven = index % 2 == 0;
                        final data = groupVM.groupMembersList[index];
                        return Row(
                          children: [
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 7.5,
                              child: Align(
                                alignment: isEven
                                    ? Alignment.bottomCenter
                                    : Alignment.topCenter,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.groupProfileView,
                                        arguments: data.obs);
                                  },
                                  child: Container(
                                    height: SizeConfig.heightMultiplier * 6,
                                    width: SizeConfig.widthMultiplier * 12,
                                    decoration: BoxDecoration(
                                        border: data.isAdmin == true
                                            ? Border.all(
                                                color: Colors.blue,
                                                width: 2,
                                              )
                                            : null,
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.black,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            data.image!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.5), // Shadow color
                                            spreadRadius: 2, // Spread radius
                                            blurRadius: 5, // Blur radius
                                            offset: Offset(0,
                                                3), // Offset in the x and y directions
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 3,
                            )
                          ],
                        );
                      }, growable: true),
                    ),
            )
          ],
        ));
  }
}
