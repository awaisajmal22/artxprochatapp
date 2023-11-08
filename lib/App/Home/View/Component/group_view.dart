import 'package:artxprochatapp/App/GroupChat/ViewModel/group_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/SizeConfig/size_config.dart';
import '../../ViewModel/home_view_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class GroupView extends StatelessWidget {
  GroupView({
    super.key,
  });

  final groupChatVM = Get.find<GroupChatViewModel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (homeVM) {
      return homeVM.groupsList.length < 1
          ? Center(
              child: Text('No Group Created Yet..',
                  style: Theme.of(context).textTheme.titleLarge),
            )
          : ListView.builder(
              padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 3),
              itemCount: homeVM.groupsList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    groupChatVM.getGroupMessages(
                        groupName: homeVM.groupsList[index].groupName!);
                    Get.toNamed(AppRoutes.groupView,
                        arguments: homeVM.groupsList[index]);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: SizeConfig.heightMultiplier * 10,
                          width: SizeConfig.widthMultiplier * 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    homeVM.groupsList[index].groupImage!,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            Text(
                              homeVM.groupsList[index].groupName!,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              homeVM.groupsList[index].members!.length <= 1
                                  ? '${homeVM.groupsList[index].members!.length} Member'
                                  : '${homeVM.groupsList[index].members!.length} Members',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                );
              });
    });
  }
}
