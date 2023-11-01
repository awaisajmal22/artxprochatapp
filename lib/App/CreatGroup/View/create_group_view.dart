import 'dart:io';

import 'package:artxprochatapp/Utils/Toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/AppGradient/gradient.dart';
import '../../../Utils/CustomButton/floating_button.dart';
import '../../../Utils/SizeConfig/size_config.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../ViewModel/create_group_view_model.dart';

class CreateGroupView extends StatelessWidget {
  CreateGroupView({super.key});
  final creatGroupVM = Get.find<CreateGroupViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingButton(
          context: context,
          onTap: () {
            print(creatGroupVM.filteredUsers.length);
            if (creatGroupVM.groupUserList.isNotEmpty) {
              Get.toNamed(AppRoutes.addGroupDetailView);
            } else {
              toast(
                  title: 'Please atleast select 1 user',
                  gravity: ToastGravity.BOTTOM,
                  fontSize: 10);
            }
          },
          icon: Icons.arrow_forward),
      appBar: PreferredSize(
          child: SafeArea(
            child: gradient(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Obx(
                  () => creatGroupVM.isSearch.value
                      ? searchField(
                          context: context,
                          controller: creatGroupVM.searchController,
                          hintText: 'Search...',
                          onChange: (value) {
                            creatGroupVM.filterUsers(value);
                            // creatGroupVM.getUsers();
                            if (value.length == 0) {
                              creatGroupVM.getUsers();
                            }
                          },
                          onBack: () {
                            creatGroupVM.isSearch.value = false;
                            creatGroupVM.searchController.clear();

                            creatGroupVM.getUsers();
                          },
                          readOnly: false,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 3,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'New Group',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context).dividerColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                if (creatGroupVM.filteredUsers.length <= 2)
                                  Obx(
                                    () => Text(
                                      "Total User ${creatGroupVM.filteredUsers.length - 1}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color:
                                                Theme.of(context).dividerColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  )
                                else
                                  Obx(
                                    () => Text(
                                        "Total Users ${creatGroupVM.filteredUsers.length - 1}"),
                                  )
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                creatGroupVM.isSearch.value = true;
                              },
                              child: Icon(Ionicons.search),
                            )
                          ],
                        ),
                ),
              ),
            ),
          ),
          preferredSize: Size(SizeConfig.widthMultiplier * 100,
              SizeConfig.heightMultiplier * 6.5)),
      body: Container(
        color: Theme.of(context).dividerColor,
        child: Obx(
          () => creatGroupVM.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).canvasColor,
                  ),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      if (creatGroupVM.groupUserList.isEmpty)
                        SizedBox.shrink()
                      else
                        Container(
                          color: Theme.of(context).dividerColor,
                          height: SizeConfig.heightMultiplier * 9,
                          child: ListView.builder(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            itemCount: creatGroupVM.groupUserList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              int reversedIndex =
                                  creatGroupVM.groupUserList.length - 1 - index;
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height:
                                            SizeConfig.heightMultiplier * 6.5,
                                        width: SizeConfig.widthMultiplier * 10,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(creatGroupVM
                                                    .groupUserList[
                                                        reversedIndex]
                                                    .image!),
                                                fit: BoxFit.cover)),
                                      ),
                                      Positioned(
                                          bottom: 5,
                                          right: 0,
                                          child: gradientCircle(
                                            child: GestureDetector(
                                              onTap: () {
                                                creatGroupVM.groupUserList
                                                    .removeAt(reversedIndex);
                                              },
                                              child: Icon(
                                                Icons.cancel,
                                                size: SizeConfig
                                                        .heightMultiplier *
                                                    2,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (creatGroupVM.groupUserList.isEmpty)
                        SizedBox.shrink()
                      else
                        Container(
                          height: 1,
                          color: Theme.of(context).canvasColor.withOpacity(0.2),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                        ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: creatGroupVM.filteredUsers.length,
                              itemBuilder: (context, index) {
                                if (creatGroupVM.currentUser!.uid ==
                                    creatGroupVM.filteredUsers[index].uid) {
                                  return SizedBox.shrink();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      if (creatGroupVM.groupUserList.contains(
                                          creatGroupVM.filteredUsers[index])) {
                                      } else {
                                        creatGroupVM.groupUserList.add(
                                            creatGroupVM.filteredUsers[index]);
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 2,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    10,
                                            width:
                                                SizeConfig.widthMultiplier * 15,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      creatGroupVM
                                                          .filteredUsers[index]
                                                          .image!,
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(
                                            width:
                                                SizeConfig.widthMultiplier * 2,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: SizeConfig
                                                        .heightMultiplier *
                                                    2,
                                              ),
                                              Text(
                                                creatGroupVM
                                                    .filteredUsers[index].name!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              creatGroupVM
                                                      .filteredUsers.isNotEmpty
                                                  ? Text(
                                                      creatGroupVM
                                                                  .filteredUsers[
                                                                      index]
                                                                  .lastActive ==
                                                              null
                                                          ? ''
                                                          : creatGroupVM
                                                                      .filteredUsers[
                                                                          index]
                                                                      .isOnline ==
                                                                  true
                                                              ? "Active"
                                                              : "${timeago.format(creatGroupVM.filteredUsers[index].lastActive!.toDate())}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5)),
                                                    )
                                                  : SizedBox.shrink(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              })),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Container searchField(
      {required BuildContext context,
      required bool readOnly,
      required TextEditingController controller,
      required Function(String) onChange,
      required VoidCallback onBack,
      required String hintText}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onBack,
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).dividerColor,
            ),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 1,
          ),
          Expanded(
            child: TextFormField(
              readOnly: readOnly,
              controller: controller,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Platform.isAndroid ? Colors.white : Colors.black,
                  ),
              onChanged: (value) {
                onChange(value);
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              obscureText: false,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(top: 10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Platform.isAndroid
                    ? Colors.transparent
                    : Theme.of(context).primaryColor,
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Platform.isAndroid ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
