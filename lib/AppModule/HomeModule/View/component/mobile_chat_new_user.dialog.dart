import 'package:artxprochatapp/AppModule/HomeModule/ViewModel/home_view_model.dart';
import 'package:artxprochatapp/AppModule/SingleChatModule/Model/users_model.dart';
import 'package:artxprochatapp/AppModule/SingleChatModule/ViewModel/single_chat_view_model.dart';
import 'package:artxprochatapp/Utils/TextField/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/SizeConfig/size_config.dart';
import 'package:timeago/timeago.dart' as timeago;

showTextNewUserDialog({
  required BuildContext context,
  required TextEditingController controller,
  required SingleChatViewModel singleChatVM,
  required HomeViewModel homeVM,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customSearchFormField(
                textColor: Colors.white,
                onChanged: (value) {
                  singleChatVM.searchList.value =
                      singleChatVM.searchUsers(value!);

                  if (singleChatVM.searchController.text.isEmpty) {
                    singleChatVM.searchList.value = [];
                  } else {}
                },
                context: context,
                keyboardType: TextInputType.text,
                hintText: 'Search User...',
                controller: controller,
              ),
              Expanded(
                  child: Obx(
                () => ListView.builder(
                  padding:
                      EdgeInsets.only(top: SizeConfig.heightMultiplier * 1),
                  shrinkWrap: true,
                  itemCount: singleChatVM.searchList.isNotEmpty
                      ? singleChatVM.searchList.length
                      : singleChatVM.userChatList.length,
                  itemBuilder: (context, index) {
                    return singleChatVM.userChatList[index].uid ==
                            singleChatVM.currentUser!.uid
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              Obx(
                                () => ListTile(
                                  subtitle: singleChatVM
                                              .userChatList[index].isOnline ==
                                          null
                                      ? SizedBox.shrink()
                                      : singleChatVM.searchList.isNotEmpty
                                          ? Text(
                                              singleChatVM.searchList[index]
                                                          .isOnline ==
                                                      true
                                                  ? "Active"
                                                  : "Last Active: ${timeago.format(singleChatVM.searchList[index].lastActive!.toDate())}",
                                              maxLines: 2,
                                            )
                                          : Text(
                                              singleChatVM.userChatList[index]
                                                          .lastActive ==
                                                      null
                                                  ? ''
                                                  : singleChatVM
                                                              .userChatList[
                                                                  index]
                                                              .isOnline ==
                                                          true
                                                      ? "Active"
                                                      : "Last Active: ${timeago.format(singleChatVM.userChatList[index].lastActive!.toDate())}",
                                              maxLines: 2,
                                            ),
                                  onTap: () {
                                    Get.back();
                                    singleChatVM.getUserByID(
                                        uid: singleChatVM.searchList.isNotEmpty
                                            ? singleChatVM
                                                .searchList[index].uid!
                                            : singleChatVM
                                                .userChatList[index].uid!);
                                    singleChatVM.getMessages(
                                        receiverUid:
                                            singleChatVM.searchList.isNotEmpty
                                                ? singleChatVM
                                                    .searchList[index].uid!
                                                : singleChatVM
                                                    .userChatList[index].uid!);
                                    Get.toNamed(
                                      AppRoutes.singleChatView,
                                    );
                                  },
                                  leading: SizedBox(
                                    height: SizeConfig.heightMultiplier * 8,
                                    width: SizeConfig.widthMultiplier * 14,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            singleChatVM.searchList.isNotEmpty
                                                ? singleChatVM
                                                    .searchList[index].image!
                                                : singleChatVM
                                                    .userChatList[index].image!,
                                            fit: BoxFit.cover,
                                            height:
                                                SizeConfig.heightMultiplier * 6,
                                            width:
                                                SizeConfig.widthMultiplier * 12,
                                          ),
                                        ),
                                        Obx(() => singleChatVM
                                                .searchList.isNotEmpty
                                            ? Container(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    2,
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        3,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: singleChatVM
                                                                .searchList[
                                                                    index]
                                                                .isOnline ==
                                                            true
                                                        ? Colors.green
                                                        : Colors.grey),
                                              )
                                            : Container(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    2,
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        3,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: singleChatVM
                                                                .userChatList[
                                                                    index]
                                                                .isOnline ==
                                                            true
                                                        ? Colors.green
                                                        : Colors.grey),
                                              ))
                                      ],
                                    ),
                                  ),
                                  title: Text(
                                    singleChatVM.searchList.isNotEmpty
                                        ? singleChatVM.searchList[index].name!
                                        : singleChatVM
                                            .userChatList[index].name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize:
                                                SizeConfig.textMultiplier *
                                                    2.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 0.5,
                              )
                            ],
                          );
                  },
                ),
              ))
            ],
          ),
        ),
      );
    },
  );
}
