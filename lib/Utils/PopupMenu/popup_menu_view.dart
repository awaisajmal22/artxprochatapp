import 'package:artxprochatapp/Utils/Models/popUpMenu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ionicons/ionicons.dart';

import '../SizeConfig/size_config.dart';

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Alert!!"),
        content: Text("You are awesome!"),
        actions: [
          MaterialButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget popUpMenu(BuildContext context, Function(int) onSelected,
    {required List<PopupMenuModel> popUpMenuList}) {
  return PopupMenuButton<int>(
    padding: EdgeInsets.all(0),
    itemBuilder: (context) {
      return List.generate(popUpMenuList.length, (index) {
        return PopupMenuItem(
          padding: EdgeInsets.all(10),
          value: popUpMenuList[index].key,
          // row with 2 children
          child: Row(
            children: [
              Icon(popUpMenuList[index].icon),
              SizedBox(
                width: 10,
              ),
              Text(
                "${popUpMenuList[index].title}",
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        );
      });
    },
    offset: Offset(0, 30),
    color: Theme.of(context).scaffoldBackgroundColor,
    icon: Icon(
      Ionicons.ellipsis_vertical,
      color: Theme.of(context).dividerColor,
    ),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    onSelected: (value) {
      onSelected(value);
    },
  );
}
