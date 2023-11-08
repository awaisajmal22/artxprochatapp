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
  final HomeViewModel homeVM;
  final SingleChatViewModel singleChatVM;
  ChatView({
    super.key,
    required this.homeVM,
    required this.singleChatVM,
  });
  // final singleChatVM = Get.put(SingleChatViewModel());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeVM.isLoadingChatView.value == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            )
          : homeVM.userChatList.length <= 1 ||
                  homeVM.specificMessagesList.isEmpty
              ? Center(
                  child: Text('No Messages Yet..',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black)),
                )
              : ListView.builder(
                  padding:
                      EdgeInsets.only(right: SizeConfig.widthMultiplier * 3),
                  itemCount: homeVM.specificMessagesIntList.length,
                  itemBuilder: (context, index) {
                    final userModel = homeVM.userChatList.firstWhere(
                        (element) =>
                            element.uid ==
                            homeVM.specificMessagesList[index].uid);
                    final msgModel = homeVM.specificMessagesList
                        .firstWhere((element) => element.uid == userModel.uid);

                    if (homeVM.specificMessagesList.isNotEmpty) {
                      return GestureDetector(
                        onTap: () {
                         
                          singleChatVM.getUserByID(uid: userModel.uid!);
                          singleChatVM.getMessages(receiverUid: userModel.uid!);
                           Get.toNamed(AppRoutes.singleChatView,
                              arguments: userModel);
                          print(userModel.fmcToken);

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
                                          userModel.image!,
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
                                    userModel.name!,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  FittedBox(
                                    child: SizedBox(
                                      width: SizeConfig.widthMultiplier * 30,
                                      child: Text(
                                        msgModel.msg!,
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
                                          userModel.lastActive == null
                                              ? ''
                                              : userModel.isOnline == true
                                                  ? "Active"
                                                  : "${timeago.format(userModel.lastActive!.toDate())}",
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
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
    );
  }
}
