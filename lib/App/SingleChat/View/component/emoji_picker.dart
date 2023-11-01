import 'package:artxprochatapp/Utils/AppGradient/gradient.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';

Widget emojiPicker(
    {required RxBool emojiShowing,
    required TextEditingController controller,
    required VoidCallback onBackspacePressed,
    required BuildContext context,
    required Function(Category category, Emoji emoji) onSelectEmoji}) {
  return Obx(
    () => Offstage(
      offstage: !emojiShowing.value,
      child: gradient(
        child: SizedBox(
            height: 250,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                onSelectEmoji(category!, emoji);
              },
              textEditingController: controller,
              onBackspacePressed: onBackspacePressed,
              config: Config(
                columns: 7,
                // Issue: https://github.com/flutter/flutter/issues/28894
                emojiSizeMax: 32 *
                    (foundation.defaultTargetPlatform == TargetPlatform.iOS
                        ? 1.30
                        : 1.0),
                verticalSpacing: 0,
                horizontalSpacing: 0,
                gridPadding: EdgeInsets.zero,
                initCategory: Category.RECENT,
                bgColor: Colors.transparent,
                indicatorColor: Colors.blue,
                iconColor: Theme.of(context).dividerColor,
                iconColorSelected: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                recentTabBehavior: RecentTabBehavior.RECENT,
                recentsLimit: 28,
                replaceEmojiOnLimitExceed: false,
                noRecents: const Text(
                  'No Recents',
                  style: TextStyle(fontSize: 20, color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
                loadingIndicator: const SizedBox.shrink(),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
                checkPlatformCompatibility: true,
              ),
            )),
      ),
    ),
  );
}
