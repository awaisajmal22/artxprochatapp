import 'dart:io';

import 'package:artxprochatapp/AppModule/GroupChatModule/Model/groups_model.dart';
import 'package:artxprochatapp/AppModule/GroupChatModule/View/Component/add_members_to_group_dialog.dart';
import 'package:artxprochatapp/Utils/CustomButton/elevated_button.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:artxprochatapp/Utils/TextField/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Utils/Toast/toast.dart';
import '../../ViewModel/group_chat_view_model.dart';

createGroupDialog(
    {required BuildContext context,
    required TextEditingController controller,
    required GroupChatViewModel groupVM}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Container(
          height: SizeConfig.heightMultiplier * 60,
          width: SizeConfig.widthMultiplier * 60,
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create Group',
                style: GoogleFonts.acme().copyWith(
                    color: Colors.black,
                    fontSize: SizeConfig.textMultiplier * 2.5),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 4,
              ),
              Obx(
                () => groupVM.image.value == ''
                    ? GestureDetector(
                        onTap: () {
                          groupVM.selectImage();
                        },
                        child: SizedBox(
                          height: SizeConfig.heightMultiplier * 30,
                          width: SizeConfig.widthMultiplier * 60,
                          child: Center(
                            child: Text("Select an Image.."),
                          ),
                        ),
                      )
                    : Image.network(
                        groupVM.image.value,
                        fit: BoxFit.cover,
                        height: SizeConfig.heightMultiplier * 30,
                        width: SizeConfig.widthMultiplier * 60,
                      ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              customFormField(
                  onChange: (value) {},
                  context: context,
                  keyboardType: TextInputType.text,
                  hintText: 'Group Name...',
                  controller: controller),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              CustomElevatedButton(
                  title: 'Create',
                  onPressed: () {
                    
                    if (groupVM.groupNameController.text.isEmpty) {
                      toast(
                          title: "Please Enter Group Name..",
                          backgroundColor: Colors.black);
                    } else if (groupVM.image.value.isEmpty) {
                      toast(
                          title: "Please Select an Image..",
                          backgroundColor: Colors.black);
                    } else {
                    
                      // addMemberToGroupDialog(
                      //     context: context,
                      //     groupName: groupVM.groupNameController.text,
                      //     groupVM: groupVM);
                      groupVM.creatGroup(
                        
                          groupName: groupVM.groupNameController.text,
                          groupImage: groupVM.image.value);

                      controller.clear(); 
                       Get.back();
                    }
                  })
            ],
          ),
        ),
      );
    },
  );
}
