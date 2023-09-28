import 'package:artxprochatapp/AppModule/HomeModule/View/component/mobile_chat_new_user.dialog.dart';
import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../../Utils/SizeConfig/size_config.dart';
import '../../../Utils/TextField/text_form_field.dart';
import '../../GroupChatModule/ViewModel/group_chat_view_model.dart';
import '../../SingleChatModule/ViewModel/single_chat_view_model.dart';
import '../ViewModel/home_view_model.dart';
import 'component/mobile_groups_list.dart';

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({
    Key? key,
    required this.homeVM,
    required this.groupVM,
    required this.singleChatVM,
    required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);
  final SingleChatViewModel singleChatVM;
  final HomeViewModel homeVM;
  final GroupChatViewModel groupVM;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => homeVM.userData.value.uid == null
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 3),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Image.asset(
                              'assets/images/drawer.png',
                              fit: BoxFit.contain,
                              width: SizeConfig.widthMultiplier * 10,
                              height: SizeConfig.heightMultiplier * 10,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 2,
                          ),
                          Obx(
                            () => Text(
                              homeVM.userData.value.name!,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.5,
                    ),
                    MobileHomePageSearchView(
                      singleChatVM: singleChatVM,
                      homeVM: homeVM,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 3),
                        child: Text(
                          'Chat Groups',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  fontSize: SizeConfig.textMultiplier * 2.4,
                                  fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    ChatGroupMobile(groupVM: groupVM),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.5,
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: singleChatVM.usersList.length,
                      itemBuilder: (context, index) {
                        final unreadedMessage = singleChatVM
                            .usersList[index].message!
                            .where((message) => message.isReaded == false)
                            .length;
                        return singleChatVM.usersList[index].message!.isEmpty
                            ? SizedBox.shrink()
                            : Obx(
                                () => Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.singleChatView,
                                            arguments:
                                                singleChatVM.usersList[index]);
                                      },
                                      leading: SizedBox(
                                        height: SizeConfig.heightMultiplier * 8,
                                        width: SizeConfig.widthMultiplier * 14,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Positioned(
                                              right: 0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  singleChatVM.usersList[index]
                                                      .userImage!,
                                                  fit: BoxFit.cover,
                                                  height: SizeConfig
                                                          .heightMultiplier *
                                                      6,
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      12,
                                                ),
                                              ),
                                            ),
                                            singleChatVM.usersList[index]
                                                    .message!.isEmpty
                                                ? SizedBox.shrink()
                                                : Positioned(
                                                    left: 0,
                                                    top: 0,
                                                    child: Container(
                                                      height: SizeConfig
                                                              .heightMultiplier *
                                                          4,
                                                      width: SizeConfig
                                                              .widthMultiplier *
                                                          8,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: Center(
                                                        child: Text(
                                                          "+${unreadedMessage.toString()}",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .textMultiplier *
                                                                          1.7),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                      title: Text(
                                        singleChatVM.usersList[index].userName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2.0),
                                      ),
                                      subtitle: singleChatVM
                                              .usersList[index].message!.isEmpty
                                          ? const SizedBox.shrink()
                                          : Text(
                                              singleChatVM.usersList[index]
                                                  .message![0].msg!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight: singleChatVM
                                                                  .usersList[
                                                                      index]
                                                                  .message![0]
                                                                  .isReaded ==
                                                              true
                                                          ? FontWeight.w900
                                                          : FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize: SizeConfig
                                                              .textMultiplier *
                                                          1.8),
                                            ),
                                      trailing: Text(
                                        singleChatVM.checkDate(singleChatVM
                                            .usersList[index]
                                            .message![0]
                                            .dateTime!),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        1.8),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 0.5,
                                    )
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                ),
              ],
            )),
    );
  }
}

class MobileHomePageSearchView extends StatelessWidget {
  MobileHomePageSearchView(
      {Key? key, required this.homeVM, required this.singleChatVM})
      : super(key: key);
  final SingleChatViewModel singleChatVM;
  final HomeViewModel homeVM;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.widthMultiplier * 3,
      ),
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: customFormField(
                onChange: (value) {},
                context: context,
                keyboardType: TextInputType.text,
                hintText: 'Search Chat..',
                controller: homeVM.searchController,
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 2,
            ),
            GestureDetector(
              onTap: () {
                showTextNewUserDialog(
                  homeVM: homeVM,
                    context: context,
                    controller: singleChatVM.searchController,
                    singleChatVM: singleChatVM);
              },
              child: Container(
                width: SizeConfig.widthMultiplier * 15,
                height: SizeConfig.widthMultiplier * 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                child: const Center(
                  child: Icon(Ionicons.add),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
