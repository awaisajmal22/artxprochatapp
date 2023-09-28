// import 'package:artxprochatapp/AppModule/VoiceChannelModule/ViewModel/voice_channel_view_model.dart';
// import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:get/get.dart';

// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

// class VoiceChannelView extends StatelessWidget {
//   VoiceChannelView({Key? key}) : super(key: key);
//   final voiceVM = Get.find<VoiceChannelViewModel>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: GestureDetector(
//           onTap: () {
//             voiceVM.engine.leaveChannel();
//             Get.back();
//           },
//           child: Icon(Icons.arrow_back),
//         ),
//         backgroundColor: Colors.black,
//         title: Text('${voiceVM.channelController.text}'),
//         centerTitle: true,
//       ),
//       body: Obx(
//         () => voiceVM.loading.value
//             ? const CircularProgressIndicator()
//             : Stack(
//                 children: [
//                   Center(
//                     child: _remoteVideo(
//                       voiceVM: voiceVM,
//                       context: context,
//                     ),
//                   ),
//                   SizedBox(
//                     height: SizeConfig.heightMultiplier * 90,
//                     width: SizeConfig.heightMultiplier * 90,
//                     child: Stack(
//                       children: [
//                         Obx(
//                           () => Positioned(
//                             top: voiceVM.yPosition.value,
//                             left: voiceVM.xPosition.value,
//                             child: GestureDetector(
//                               onPanUpdate: (value) {
//                                 if (value.delta.dx < 0 ||
//                                     value.delta.dy < 0 ||
//                                     value.delta.dy > 80.toDouble() ||
//                                     value.delta.dx > 80.toDouble()) {
//                                   voiceVM.yPosition.value = 0;
//                                   voiceVM.xPosition.value = 0;
//                                 } else {
//                                   voiceVM.yPosition.value = value.delta.dy;
//                                   voiceVM.xPosition.value = value.delta.dx;
//                                 }
//                               },
//                               child: SizedBox(
//                                   height: SizeConfig.heightMultiplier * 10,
//                                   width: SizeConfig.widthMultiplier * 20,
//                                   child: const RtcLocalView.SurfaceView()),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }

// Widget _remoteVideo({
//   required VoiceChannelViewModel voiceVM,
//   required BuildContext context,
// }) {
//   return SizedBox(child: Obx(() {
//     if (voiceVM.remoteID.isNotEmpty) {
//       if (voiceVM.remoteID.length == 1) {
//         return SizedBox(
//           height: double.maxFinite,
//           width: double.maxFinite,
//           child: Obx(
//             () => RtcRemoteView.SurfaceView(
//               uid: voiceVM.remoteID[0],
//               channelId: voiceVM.channelController.text,
//             ),
//           ),
//         );
//       } else if (voiceVM.remoteID.length == 2) {
//         return Column(
//           children: [
//             SizedBox(
//               height: SizeConfig.heightMultiplier * 50,
//               width: double.infinity,
//               child: Obx(
//                 () => RtcRemoteView.SurfaceView(
//                   uid: voiceVM.remoteID[1],
//                   channelId: voiceVM.channelController.text,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: SizeConfig.heightMultiplier * 50,
//               width: double.infinity,
//               child: Obx(
//                 () => RtcRemoteView.SurfaceView(
//                   uid: voiceVM.remoteID[2],
//                   channelId: voiceVM.channelController.text,
//                 ),
//               ),
//             )
//           ],
//         );
//       } else {
//         return SizedBox(
//           height: SizeConfig.heightMultiplier * 100,
//           width: SizeConfig.widthMultiplier * 100,
//           child: Obx(
//             () => GridView.builder(
//               itemCount: voiceVM.remoteID.length,
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 200,
//                 childAspectRatio: 11 / 20,
//                 crossAxisSpacing: 5,
//                 mainAxisSpacing: 10,
//               ),
//               itemBuilder: (context, index) {
//                 return Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: RtcRemoteView.SurfaceView(
//                     uid: voiceVM.remoteID[index],
//                     channelId: voiceVM.channelController.text,
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       }
//     } else {
//       return const Center(
//         child: Text('Waiting for other users to Join'),
//       );
//     }
//   }));
// }
import 'package:artxprochatapp/AppModule/VoiceChannelModule/ViewModel/voice_channel_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/channel_name_model.dart';
import 'component/pre_join_dialog.dart';

class VoiceChannelView extends StatefulWidget {
  String channelTile = Get.arguments;
  @override
  State<VoiceChannelView> createState() => _VoiceChannelViewState();
}

class _VoiceChannelViewState extends State<VoiceChannelView> {
  final _formKey = GlobalKey<FormState>();

  late final FocusNode _unfocusNode;
  late final TextEditingController _channelNameController;

  bool _isCreatingChannel = false;
  final voiceChannelVM = Get.find<VoiceChannelViewModel>();
  @override
  void initState() {
    super.initState();
    _unfocusNode = FocusNode();
    _channelNameController = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }

  String? _channelNameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a channel name';
    } else if (value.length > 64) {
      return 'Channel name must be less than 64 characters';
    }
    return null;
  }

  Future<void> _createRoom() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (voiceChannelVM.channelList.contains(_channelNameController.text)) {
      return _showSnackBar(context, 'Channel Already Created');
    } else {
      FocusScope.of(context).requestFocus(_unfocusNode);
      setState(() => _isCreatingChannel = true);
      final input = <String, dynamic>{
        'channelName': _channelNameController.text,
        'expiryTime': 3600, // 1 hour
      };
      try {
        final response = await FirebaseFunctions.instance
            .httpsCallable('generateToken')
            .call(input);
        final token = response.data as String?;
        if (token != null) {
          if (context.mounted) {
            _showSnackBar(
              context,
              'Token generated successfully!',
            );
          }
          await Future.delayed(
            const Duration(seconds: 3),
          );
          if (context.mounted) {
            await showDialog(
              context: context,
              builder: (context) => PreJoiningDialog(
                channelName: _channelNameController.text,
                token: token,
              ),
            );
            voiceChannelVM.channelsList.insert(
                0,
                ChannelNameModel(
                    channelName: _channelNameController.text, token: token));
            print("Channel list Length:" +
                "${voiceChannelVM.channelsList[0].channelName}");
          }
        }
      } catch (e) {
        _showSnackBar(
          context,
          'Error generating token: $e',
        );
      } finally {
        setState(() => _isCreatingChannel = false);
      }
    }
  }

  Future<void> _joinRoom(String channelName, String token) async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }

    FocusScope.of(context).requestFocus(_unfocusNode);
    setState(() => _isCreatingChannel = true);
    final input = <String, dynamic>{
      'channelName': channelName,
      'expiryTime': 3600, // 1 hour
    };
    try {
      // final response = await FirebaseFunctions.instance
      //     .httpsCallable('generateToken')
      //     .call(input);
      // final token = response.data as String?;
      if (token != null) {
        //   if (context.mounted) {
        //     _showSnackBar(
        //       context,
        //       'Token generated successfully!',
        //     );
        //   }
        //   await Future.delayed(
        //     const Duration(seconds: 3),
        //   );
        if (context.mounted) {
          await showDialog(
            context: context,
            builder: (context) => PreJoiningDialog(
              channelName: channelName,
              token: token,
            ),
          );
        }
      }
    } catch (e) {
      _showSnackBar(
        context,
        'Error generating token: $e',
      );
    } finally {
      setState(() => _isCreatingChannel = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   surfaceTintColor: Colors.white,
        // ),
        body: SafeArea(
          child: widget.channelTile.contains("Create Channel")
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenSize.width,
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 24.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  30.0,
                                  0.0,
                                  8.0,
                                ),
                                child: Text(
                                  widget.channelTile,
                                  style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.only(bottom: 24.0),
                                child: Text(
                                  'Enter a channel name to generate token. The token will be valid for 1 hour.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: TextFormField(
                                  autofocus: true,
                                  controller: _channelNameController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Channel Name',
                                    labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    hintText: 'Enter your channel name...',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF57636C),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: _channelNameValidator,
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              _isCreatingChannel
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        CircularProgressIndicator(
                                          color: Colors.black,
                                        )
                                      ],
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      height: 55,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                        ),
                                        onPressed: _createRoom,
                                        child: const Text('Create Room'),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          30.0,
                          0.0,
                          8.0,
                        ),
                        child: Text(
                          widget.channelTile,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(bottom: 24.0),
                        child: Text(
                          'Select the channel name to generate token. The token will be valid for 1 hour.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      Expanded(
                          child: Obx(
                        () => voiceChannelVM.channelsList.isEmpty
                            ? const Center(
                                child: Text('Please Create Channel First'),
                              )
                            : Obx(
                                () => ListView.builder(
                                  itemCount: voiceChannelVM.channelsList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            _joinRoom(
                                                voiceChannelVM
                                                    .channelsList[index]
                                                    .channelName
                                                    .toString(),
                                                voiceChannelVM
                                                    .channelsList[index]
                                                    .token!);
                                          },
                                          title: Text(
                                            voiceChannelVM.channelsList[index]
                                                .channelName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 1,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                      ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
