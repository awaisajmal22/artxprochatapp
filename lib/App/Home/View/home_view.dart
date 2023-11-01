import 'package:artxprochatapp/Utils/PopupMenu/popup_menu_view.dart';
import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../Utils/AppGradient/gradient.dart';
import '../../../Utils/CustomButton/floating_button.dart';
import '../ViewModel/home_view_model.dart';
import 'Component/chat_view.dart';
import 'Component/group_view.dart';
import 'Component/search_textField_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final homeVM = Get.find<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingButton(
        onTap: () {
          print(homeVM.usersList.length);
          Get.toNamed(AppRoutes.allUsersView);
        },
        context: context,
        icon: Ionicons.chatbubble_ellipses,
      ),
      body: Container(
        color: Theme.of(context).dividerColor,
        child: SafeArea(
          child: Obx(
            () => CustomScrollView(
              physics: homeVM.isSelectWraper.value == true
                  ? NeverScrollableScrollPhysics()
                  : BouncingScrollPhysics(),
              controller: homeVM.scrollController,
              slivers: <Widget>[
                Obx(
                  () => homeVM.isSearchBarShow == true
                      ? searchSilverAppBar(context: context, homeVM: homeVM)
                      : silverAppBar(context),
                ),
                SliverFillRemaining(
                  child:
                      TabBarView(controller: homeVM.tabController, children: [
                    ChatView(),
                    GroupView(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget silverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: Size(SizeConfig.widthMultiplier * 100,
            SizeConfig.heightMultiplier * 6.15),
        child: gradient(
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor:
                Theme.of(context).canvasColor.withOpacity(0.3),
            tabs: homeVM.tabs,
            controller: homeVM.tabController,
          ),
        ),
      ),
      snap: true,
      pinned: true,
      floating: true,
      expandedHeight: SizeConfig.heightMultiplier * 12,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: gradient(
              child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 2,
                vertical: SizeConfig.heightMultiplier * 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/artx.png',
                  color: Theme.of(context).dividerColor,
                  height: SizeConfig.heightMultiplier * 10,
                  width: SizeConfig.widthMultiplier * 20,
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeVM.isSearchBarShow.value = true;
                      },
                      child: Icon(
                        Ionicons.search,
                        size: SizeConfig.heightMultiplier * 2,
                      ),
                    ),

                    // homeVM.signOut()
                    FittedBox(
                      child: popUpMenu(context,
                          popUpMenuList: homeVM.popUpMenuList, (value) {
                        if (value == 1) {
                          Get.toNamed(AppRoutes.createGroupView);
                        }
                        if (value == 2) {}
                        if (value == 3) {
                          homeVM.signOut();
                        }
                      }),
                    )
                  ],
                )
              ],
            ),
          ))),
    );
  }

  Widget searchSilverAppBar(
      {required BuildContext context, required HomeViewModel homeVM}) {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      expandedHeight: homeVM.isSelectWraper.value == true
          ? SizeConfig.heightMultiplier * 15
          : SizeConfig.heightMultiplier * 21,
      flexibleSpace: gradient(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 2,
            vertical: SizeConfig.heightMultiplier * 3,
          ),
          child: Column(
            children: [
              Obx(
                () => searchFormField(
                  selectedWraper: homeVM.isSelectWraper,
                  wraper: homeVM.wraperList[homeVM.selectedWraper.value],
                  onCancelCheck: homeVM.onCancel,
                  onCancel: () {
                    homeVM.searchController.clear();
                    homeVM.onCancel.value = false;
                    homeVM.isSelectWraper.value = false;
                  },
                  onChange: (value) {
                    if (value != null || value != '') {
                      homeVM.onCancel.value = true;
                    }
                  },
                  onBackButton: () {
                    homeVM.isSearchBarShow.value = false;
                    homeVM.searchController.clear();
                    homeVM.onCancel.value = false;
                    homeVM.isSelectWraper.value = false;
                  },
                  context: context,
                  controller: homeVM.searchController,
                  hintText: 'Search',
                  bottomPadding: 0,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              if (homeVM.isSelectWraper.value == true)
                SizedBox.shrink()
              else
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: List.generate(
                        growable: true,
                        homeVM.wraperList.length,
                        (index) => GestureDetector(
                              onTap: () {
                                homeVM.selectedWraper.value = index;
                                homeVM.isSelectWraper.value = true;
                                homeVM.onCancel.value = true;
                              },
                              child: FittedBox(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .canvasColor
                                        .withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        homeVM.wraperList[index].icon,
                                        color: Theme.of(context).dividerColor,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 2,
                                      ),
                                      Text(homeVM.wraperList[index].title)
                                    ],
                                  ),
                                ),
                              ),
                            )),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
