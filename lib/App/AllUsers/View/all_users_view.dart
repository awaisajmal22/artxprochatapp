import 'dart:io';

import 'package:artxprochatapp/App/SingleChat/ViewModel/single_chat_view_model.dart';
import 'package:artxprochatapp/Utils/AppGradient/gradient.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../../../RoutesAndBindings/app_routes.dart';
import '../ViewModel/all_users_view_model.dart';

class AllUsersView extends StatelessWidget {
  AllUsersView({super.key});
  final allUsersVM = Get.find<AllUsersViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: SafeArea(
            child: gradient(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Obx(
                  () => allUsersVM.isSearch.value
                      ? searchField(
                          context: context,
                          controller: allUsersVM.searchController,
                          hintText: 'Search...',
                          onChange: (value) {
                            allUsersVM.filterUsers(value);
                            // allUsersVM.getUsers();
                          },
                          onBack: () {
                            allUsersVM.isSearch.value = false;
                            allUsersVM.searchController.clear();

                            allUsersVM.getUsers();
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
                                  'All Users',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context).dividerColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                if (allUsersVM.filteredUsers.length <= 2)
                                  Obx(
                                    () => Text(
                                      "Total User ${allUsersVM.filteredUsers.length - 1}",
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
                                        "Total Users ${allUsersVM.filteredUsers.length - 1}"),
                                  )
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                allUsersVM.isSearch.value = true;
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
          () => allUsersVM.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).canvasColor,
                  ),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: allUsersVM.filteredUsers.length,
                              itemBuilder: (context, index) {
                                if (allUsersVM.currentUser!.uid ==
                                    allUsersVM.filteredUsers[index].uid) {
                                  return SizedBox.shrink();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.singleChatView,
                                        arguments:
                                            allUsersVM.filteredUsers[index],
                                      );
                                      final singleChatVM =
                                          Get.put(SingleChatViewModel());
                                      singleChatVM.getUserByID(
                                          uid: allUsersVM
                                              .filteredUsers[index].uid!);
                                      singleChatVM.getMessages(
                                          receiverUid: allUsersVM
                                              .filteredUsers[index].uid!);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 2,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                      allUsersVM
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
                                                allUsersVM
                                                    .filteredUsers[index].name!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                              allUsersVM
                                                      .filteredUsers.isNotEmpty
                                                  ? Text(
                                                      allUsersVM
                                                                  .filteredUsers[
                                                                      index]
                                                                  .lastActive ==
                                                              null
                                                          ? ''
                                                          : allUsersVM
                                                                      .filteredUsers[
                                                                          index]
                                                                      .isOnline ==
                                                                  true
                                                              ? "Active"
                                                              : "${timeago.format(allUsersVM.filteredUsers[index].lastActive!.toDate())}",
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
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
            width: SizeConfig.widthMultiplier * 3,
          ),
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.start,
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
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                isDense: true,
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
