import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:artxprochatapp/AppModule/AuthModule/SignUp/Model/user_model.dart';
import 'package:artxprochatapp/AppModule/HomeModule/Model/group_chat_model.dart';
import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/SizeConfig/size_config.dart';
import '../Model/chat_model.dart';
import 'package:path/path.dart' as path;
import 'package:record/record.dart';

import '../Model/mobile_tile_model.dart';

class HomeViewModel extends GetxController {
  RxBool isExpanded = false.obs;
  RxInt selectedTileIndex = (0).obs;
  TextEditingController groupNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool addnewGroupHover = false.obs;
  RxList<GroupChatModel> groupChatList = <GroupChatModel>[].obs;
  RxBool isAddToGroup = false.obs;
  final chatIpnutController = TextEditingController();
  final time = DateFormat.jm().format(DateTime.now());
  RxList<String> fileExtension = <String>[].obs;
  RxList<ChatModel> searchList = <ChatModel>[].obs;
  List<ChatModel> searchUsers(String query) {
    return userList
        .where((user) => user.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  RxInt selectedMobileTileIndex = (-1).obs;
  RxList<MobileTileModel> mobileTileList = <MobileTileModel>[
    MobileTileModel(
        title: "Create Channel",
        icon: Icons.voice_chat,
        onTap: () {
          Get.toNamed(AppRoutes.voicChannelView, arguments: 'Create Channel');
        }),
    MobileTileModel(
        title: 'Join Channel',
        icon: Icons.voicemail_outlined,
        onTap: () {
          Get.toNamed(AppRoutes.voicChannelView, arguments: 'Join Channel');
        })
  ].obs;
  List<ChatModel> userList = <ChatModel>[
    ChatModel(
      id: 1,
      image:
          'https://images.pexels.com/photos/18173610/pexels-photo-18173610/free-photo-of-woman-with-a-camera-sitting-on-the-floor-covered-with-polaroids.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
      name: 'Umer',
    ),
    ChatModel(
      id: 2,
      image:
          'https://images.pexels.com/photos/16042440/pexels-photo-16042440/free-photo-of-forest-in-summer.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
      name: 'Ali',
    ),
    ChatModel(
      id: 3,
      image:
          'https://cdn.pixabay.com/photo/2015/06/19/21/24/avenue-815297_640.jpg',
      name: 'Mujahid',
    ),
    ChatModel(
      id: 4,
      image:
          'https://cdn.pixabay.com/photo/2017/02/08/17/24/fantasy-2049567_640.jpg',
      name: 'Khakan',
    ),
    ChatModel(
      id: 5,
      image:
          'https://cdn.pixabay.com/photo/2015/11/16/16/28/bird-1045954_640.jpg',
      name: 'Moeez',
    ),
    ChatModel(
      id: 6,
      image:
          'https://cdn.pixabay.com/photo/2012/06/19/10/32/owl-50267_1280.jpg',
      name: 'Moeez',
    ),
  ].obs;

  List chatList = [].obs;
  // List<MessageModel> newChatList = <MessageModel>[].obs;
  Rx<Random> random = Random().obs;
  RxList<PlatformFile> pickedData = <PlatformFile>[].obs;
  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (fileExtension.length < 3 && pickedData.length < 3) {
        getExtensions(result.paths);
        pickedData.insertAll(0, result.files);
      } else {
        // final file = result.paths.map((path) => File(path!)).toList();
        print('you picked only 3 files');
        return;
      }
      // Do something with the selected files
    } else {
      // User canceled the picker
    }
  }

  List<String> getExtensions(List<String?> filePaths) {
    if (filePaths != null) {
      for (String? filePath in filePaths) {
        String extension = path.extension(filePath!);
        fileExtension.insert(0, extension);
      }
    }

    return fileExtension;
  }

  getIconUsingExtension(int index) {
    if (fileExtension[index].isNotEmpty) {
      if (fileExtension[index] == '.pdf') {
        return Icon(
          FontAwesomeIcons.filePdf,
          size: SizeConfig.imageSizeMultiplier * 3,
          color: Colors.blue,
        );
      } else if (fileExtension[index] == '.zip') {
        return Icon(
          FontAwesomeIcons.fileZipper,
          size: SizeConfig.imageSizeMultiplier * 3,
          color: Colors.blue,
        );
      } else if (fileExtension[index] == '.jpeg' ||
          fileExtension[index] == '.png' ||
          fileExtension[index] == '.jpg') {
        return Icon(
          Ionicons.image,
          size: SizeConfig.imageSizeMultiplier * 3,
          color: Colors.blue,
        );
      } else {
        return Icon(
          FontAwesomeIcons.file,
          size: SizeConfig.imageSizeMultiplier * 3,
          color: Colors.blue,
        );
      }
    }
  }

  // bool get _isAppBarExpanded {
  //   return silverAppBarScrollController.hasClients &&
  //       silverAppBarScrollController.offset >
  //           (SizeConfig.heightMultiplier * 43.1 - kToolbarHeight);
  // }

  RxBool isAppBarClose = true.obs;
  void closeSilverScroll() {
    isAppBarClose.value = false;
  }

  @override
  void onInit() {
    // TODO: implement

    // silverAppBarScrollController
    //   .addListener(() {
    //     if (silverAppBarScrollController.offset >
    //         (SizeConfig.heightMultiplier * 43.1 - kToolbarHeight)) {
    //       isExpanded.value = true;
    //     } else {
    //       isExpanded.value = false;
    //     }
    // isAppBarPinned.value = _isAppBarExpanded;
    // });
    getCurrentUserData();
    audioPlayer;

    _recordSub = recoder.onStateChanged().listen((recordState) {
      _recordState.value = recordState;
    });
    _amplitudeSub = recoder
        .onAmplitudeChanged(const Duration(milliseconds: 0))
        .listen((amp) {
      amplitude?.value = amp;
      print(amp);
    });

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    recoder.dispose();
    // silverAppBarScrollController.dispose();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    audioPlayer.dispose();
  }

  RxInt _recordDuration = 0.obs;
  Timer? _timer;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Rx<Amplitude>? amplitude;
  Rx<RecordState> _recordState = RecordState.stop.obs;
  RxString audioPath = ''.obs;
  RxBool isRecording = false.obs;
  final recoder = Record();
  RxBool isRocordingStart = false.obs;
  StreamSubscription<RecordState>? _recordSub;
  final audioPlayer = AudioPlayer();
  Future<void> startRecording() async {
    final microphoneStatus = await Permission.microphone.status;
    final status = await Permission.storage.request();
    try {
      if (Platform.isWindows || Platform.isAndroid) {
        if (await recoder.hasPermission() && status.isGranted) {
          // final isSupported = await recoder.isEncoderSupported(
          //   AudioEncoder.aacLc,
          // );
          await recoder.start();

          isRecording.value = true;
          _recordDuration.value = 0;
          _startTimer();
          print(amplitude!.value);
        }
      }
    } catch (e) {
      // Get.snackbar('Microphone', 'Permission not granted');
    }
  }

  Future stopRecording() async {
    try {
      final path = await recoder.stop();
      audioPath.value = path!;
      print(path);
      isRecording.value = false;
      return path;
    } catch (e) {
      print('something went wrong');
    }
  }

  Future<void> playAudio(String newPath) async {
    print(audioPath.value);

    File file = File(newPath);
    print(file.path);
    try {
      await audioPlayer.setFilePath(file.path);
      audioPlayer.play();
      isPlaying.value = true;
      print(file.path);
    } catch (e) {
      Get.snackbar('Audio Play', '$e');
    }
  }

  Widget buildText(BuildContext context) {
    if (_recordState.value != RecordState.stop) {
      return _buildTimer(context);
    }

    return const Text("Waiting to record");
  }

  Widget _buildTimer(BuildContext context) {
    final String minutes = _formatNumber(_recordDuration.value ~/ 60);
    final String seconds = _formatNumber(_recordDuration.value % 60);

    return Text(
      '$minutes : $seconds',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: SizeConfig.textMultiplier / 0.5, color: Colors.blue),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _recordDuration.value++;
    });
  }

  RxBool isPlaying = false.obs;
  Rx<Duration> duration = Duration().obs;

  String formatDuration(Duration? duration) {
    if (duration == null) return '0:00';
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes);
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Future<void> stopAudioPlay() async {
    await audioPlayer.stop();
    isPlaying.value = false;
  }

  User? user = FirebaseAuth.instance.currentUser;
  Rx<UserModel> userData = UserModel().obs;
  getCurrentUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((data) {
      if (data.exists) {
        final model = UserModel.fromJson(data.data() as Map<String, dynamic>);
        userData.value = model;
      }
    });
    // if (user != null) {
    //   final data = await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(user!.uid)
    //       .get();

    //   final model = UserModel.fromJson(data.data()!);
    //   userData.value = model;
  }

  final auth = FirebaseAuth.instance;
  final databaseReference = FirebaseFirestore.instance.collection('users');
  signOut() async {
    final current = auth.currentUser!.uid;

    if (current == null) {
      return;
    }
    final userRef = databaseReference.doc(current);
    userRef.update({
      "isOnline": false,
      "lastActive": FieldValue.serverTimestamp()
    }).then((value) async {
       final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', '');
        await prefs.setString('password', '');
        await prefs.setString('uid', '');
      await auth
          .signOut()
          .whenComplete(() => Get.offAllNamed(AppRoutes.loginView));
    });
  }
}
