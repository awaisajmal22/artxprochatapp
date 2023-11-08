import 'dart:io';

import 'package:artxprochatapp/App/CreatGroup/View/component/bottom_sheet.dart';
import 'package:artxprochatapp/Utils/AppGradient/gradient.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../Utils/CustomButton/floating_button.dart';
import '../../../Utils/TextField/text_form_field.dart';
import '../ViewModel/create_group_view_model.dart';

class AddGroupDetailView extends StatelessWidget {
  AddGroupDetailView({super.key});
  final creatGroupVM = Get.find<CreateGroupViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingButton(
        context: context,
        onTap: () {
          creatGroupVM.creatGroup(
            selecetedUsersUIDs: creatGroupVM.groupUserUdisList,
            groupName: creatGroupVM.groupNameController.text,
            groupImage: creatGroupVM.imagePath.value,
            selectedUsers: creatGroupVM.groupUserList,
          );
        },
        icon: Ionicons.checkmark,
      ),
      appBar: PreferredSize(
          child: gradient(
              child: SafeArea(
                  child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Row(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New Group',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).dividerColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ))),
          preferredSize: Size(SizeConfig.widthMultiplier * 100,
              SizeConfig.heightMultiplier * 6.5)),
      body: Container(
          color: Theme.of(context).dividerColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 3),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        GroupImagePickerBottomSheet(
                            context: context,
                            data: creatGroupVM.bottomSheetList,
                            fromGallery: () {
                              creatGroupVM.getImageFormStorage();
                            },
                            fromCamera: () {
                              creatGroupVM.getImageFormCamera();
                            },
                            delete: () {
                              // creatGroupVM.deleteImage();
                              creatGroupVM.imagePath.value = '';
                            });
                      },
                      child: Obx(
                        () => Container(
                          height: SizeConfig.heightMultiplier * 10,
                          width: SizeConfig.widthMultiplier * 15,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                width: 1),
                            image: creatGroupVM.imagePath.value.isNotEmpty
                                ? DecorationImage(
                                    image: FileImage(
                                      File(creatGroupVM.imagePath.value),
                                    ),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: NetworkImage(
                                        'https://t4.ftcdn.net/jpg/02/87/33/73/240_F_287337338_PgwbwV7uLupWby2xLdWLpFs31iPgSOHh.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 2,
                    ),
                    Expanded(
                        child: gradient(
                      bottomLeftRadius: 20,
                      bottomRightRadius: 20,
                      topRightRadius: 20,
                      topleftRadius: 20,
                      transform: 2.2,
                      child: customFormField(
                          context: context,
                          keyboardType: TextInputType.text,
                          hintText: 'Group Name..',
                          controller: creatGroupVM.groupNameController),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 3),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Particpants : ${creatGroupVM.groupUserList.length}',
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 0.5,
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: List.generate(creatGroupVM.groupUserList.length,
                          (index) {
                        return Column(
                          children: [
                            Container(
                              height: SizeConfig.heightMultiplier * 10,
                              width: SizeConfig.widthMultiplier * 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(creatGroupVM
                                          .groupUserList[index].image!),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              "${creatGroupVM.groupUserList[index].name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                            )
                          ],
                        );
                      }, growable: true),
                      spacing: 5,
                    ),
                  ),
                )),
              )
            ],
          )),
    );
  }
}
