import 'package:artxprochatapp/AppModule/GroupChatModule/ViewModel/group_chat_view_model.dart';
import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class ChatGroupMobile extends StatelessWidget {
  final GroupChatViewModel groupVM;
  ChatGroupMobile({Key? key, required this.groupVM}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.heightMultiplier * 18.5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: SizeConfig.widthMultiplier * 3,
            ),
            GestureDetector(
              onTap: () {
                // Get.toNamed(AppRoutes.groupView);
              },
              child: Container(
                height: SizeConfig.heightMultiplier * 18.5,
                width: SizeConfig.widthMultiplier * 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            Offset(0, 3), // Offset in the x and y directions
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 2),
                      child: Text(
                        'Create New Group',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 3,
            ),
            Obx(
              () => groupVM.groupList.isEmpty
                  ? const SizedBox.shrink()
                  : Row(
                      children:
                          List.generate(groupVM.groupList.length, (index) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.groupView, arguments: [
                                  index,
                                ]);
                              },
                              child: Container(
                                height: SizeConfig.heightMultiplier * 18.5,
                                width: SizeConfig.widthMultiplier * 25,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(groupVM
                                            .groupList[index].groupImage!)),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: Offset(0,
                                            3), // Offset in the x and y directions
                                      ),
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 4.5,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeConfig.widthMultiplier * 2),
                                      child: Text(
                                        groupVM.groupList[index].groupName!,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 12,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                      ),
                                    )
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}
