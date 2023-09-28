import 'package:artxprochatapp/AppModule/HomeModule/Model/group_chat_model.dart';
import 'package:artxprochatapp/AppModule/HomeModule/ViewModel/home_view_model.dart';
import 'package:artxprochatapp/Utils/CustomButton/elevated_button.dart';
import 'package:artxprochatapp/Utils/TextField/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Utils/SizeConfig/size_config.dart';

showAddNewGroupDailog({
  required BuildContext context,
  required HomeViewModel homeVM,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          alignment: Alignment.center,
          height: SizeConfig.heightMultiplier * 20,
          width: SizeConfig.widthMultiplier * 80,
          color: Color(0xff3079E2),
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 10,
                vertical: SizeConfig.heightMultiplier * 2),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Create New Group',
                  style: GoogleFonts.acme(
                      fontSize: SizeConfig.textMultiplier * 2,
                      height: SizeConfig.heightMultiplier * 0.083),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              customAddGroupFormField(
                  context: context,
                  keyboardType: TextInputType.text,
                  hintText: 'Add Group Name',
                  controller: homeVM.groupNameController),
              const SizedBox(
                height: 10,
              ),

              CustomElevatedButton(
                  title: 'Create',
                  onPressed: () {
                    if (homeVM.groupNameController.text.isNotEmpty) {
                      homeVM.groupChatList.insert(
                          0,
                          GroupChatModel(
                              groupName: homeVM.groupNameController.text,
                              user: <Users>[].obs));
                      homeVM.groupNameController.clear();

                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: addMemberView(
                                homeVM, context, homeVM.groupChatList.length),
                          );
                        },
                      );
                    }
                  }),

              // addMemberView(homeVM, context)
            ],
          ),
        ),
      );
    },
  );
}

Widget addMemberView(
    HomeViewModel homeVM, BuildContext context, int groupIndex) {
  return Container(
    alignment: Alignment.center,
    height: SizeConfig.heightMultiplier * 20,
    width: SizeConfig.widthMultiplier * 80,
    color: Color(0xff3079E2),
    child: ListView(
      children: [
        customSearchFormField(
            onChanged: (value) {
              homeVM.searchList.value = homeVM.searchUsers(value!);
              if (homeVM.searchController.text.isEmpty) {
                homeVM.searchList.value = [];
              }
            },
            context: context,
            keyboardType: TextInputType.text,
            hintText: 'Search person',
            controller: homeVM.searchController),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 20,
          child: Obx(
            () => ListView.builder(
              itemCount: homeVM.searchList.isEmpty
                  ? homeVM.userList.length
                  : homeVM.searchList.length,
              itemBuilder: (context, index) {
                if (homeVM.searchList.isNotEmpty) {
                  return Obx(
                    () => ListTile(
                      contentPadding: EdgeInsets.all(5),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          homeVM.searchList[index].image!,
                          height: SizeConfig.heightMultiplier * 4,
                          width: SizeConfig.widthMultiplier * 6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Users user = Users(
                            id: homeVM.searchList[index].id,
                            image: homeVM.searchList[index].image,
                            isAdd: true.obs,
                            name: homeVM.searchList[index].name,
                          );
                          // for (int i = 0;
                          //     i < homeVM.groupChatList[0].user!.length;
                          //     i++) {

                          if (homeVM.groupChatList[groupIndex].user!
                              .any((element) => element.id == user.id)) {
                            return;
                          } else {
                            homeVM.groupChatList[groupIndex].user
                                ?.insert(0, user);
                          }
                          // }
                        },
                        child: Obx(
                          () => Icon(
                            Icons.add,
                            color: homeVM.groupChatList[groupIndex].user![index]
                                        .isAdd!.value ==
                                    true
                                ? Colors.blue
                                : Colors.white,
                            size: SizeConfig.textMultiplier * 2,
                          ),
                        ),
                      ),
                      title: Text(
                        '${homeVM.searchList[index].name}',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.textMultiplier * 1.4),
                      ),
                    ),
                  );
                } else {
                  return Obx(
                    () => ListTile(
                      contentPadding: EdgeInsets.all(5),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          homeVM.userList[index].image!,
                          height: SizeConfig.heightMultiplier * 4,
                          width: SizeConfig.widthMultiplier * 6,
                          fit: BoxFit.cover,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          // homeVM.userList[index].check?.value =
                          //     !homeVM.userList[index].check!.value;
                          // if (homeVM.userList[index].check!.value == true) {

                          Users user = Users(
                            id: homeVM.userList[index].id,
                            image: homeVM.userList[index].image,
                            isAdd: true.obs,
                            name: homeVM.userList[index].name,
                          );
                          if (homeVM.groupChatList[0].user!
                              .any((element) => element.id == user.id)) {
                            return;
                          } else {
                            homeVM.groupChatList[0].user?.insert(0, user);
                            print(homeVM.groupChatList[0].user?.length);
                          }

                          // homeVM.groupChatList[0].user?.insert(0, user);

                          // } else
                          // if (homeVM
                          //         .groupChatList[0].user?[index].isAdd?.value ==
                          //     false) {
                          //   homeVM.groupChatList[0].user?.removeAt(index);
                          // }
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: SizeConfig.textMultiplier * 2,
                        ),
                      ),
                      title: Text(
                        '${homeVM.userList[index].name}',
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.textMultiplier * 1.4),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    ),
  );
}
