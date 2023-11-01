import 'package:artxprochatapp/App/Home/ViewModel/home_view_model.dart';
import 'package:artxprochatapp/App/SingleChat/ViewModel/single_chat_view_model.dart';
import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import 'package:timeago/timeago.dart' as timeago;

class ChatView extends StatelessWidget {
  ChatView({
    super.key,
  });
  final singleChatVM = Get.find<SingleChatViewModel>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (homeVM) {
      return Obx(
        () => homeVM.userChatList.length <= 1
            ? homeVM.isLoadingChatView.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        print(homeVM.usersList.length);
                      },
                      child: Text('No Messages Yet..',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.black)),
                    ),
                  )
            : ListView.builder(
                padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 3),
                itemCount: homeVM.userChatList.length,
                itemBuilder: (context, index) {
                  if (homeVM.userChatList[index].uid ==
                          homeVM.currentUser!.uid ||
                      homeVM.userChatList[index].isMessage == false) {
                    return const SizedBox.shrink();
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.singleChatView,
                            arguments: homeVM.userChatList[index]);

                        singleChatVM.getUserByID(
                            uid: homeVM.userChatList[index].uid!);
                        singleChatVM.getMessages(
                            receiverUid: homeVM.userChatList[index].uid!);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 2,
                        ),
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
                                        homeVM.userChatList[index].image!,
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
                                  homeVM.userChatList[index].name!,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                FittedBox(
                                  child: SizedBox(
                                    width: SizeConfig.widthMultiplier * 30,
                                    child: Text(
                                      homeVM.userChatList[index].lastMessage!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 2,
                                ),
                                homeVM.userChatList.isNotEmpty
                                    ? Text(
                                        homeVM.userChatList[index].lastActive ==
                                                null
                                            ? ''
                                            : homeVM.userChatList[index]
                                                        .isOnline ==
                                                    true
                                                ? "Active"
                                                : "${timeago.format(homeVM.userChatList[index].lastActive!.toDate())}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }),
      );
    });
  }
}
