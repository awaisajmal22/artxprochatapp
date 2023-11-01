// import 'package:artxprochatapp/AppModule/DirectoryModule/Model/directory_model.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';

// class FirebaseGroupDirecotryServices {
//   Future<List<DirectoryModel>> getMediaFiles(final groupName) async {
//     final Reference mediaRef =
//         FirebaseStorage.instance.ref().child("$groupName/media/");
//     ListResult imagesList = await mediaRef.list();
//     RxList<DirectoryModel> images = <DirectoryModel>[].obs;
//     for (Reference item in imagesList.items) {
//       String url = await item.getDownloadURL();
//       List<String> date = await item.name.split('[');
//       images.add(DirectoryModel(
//         path: url,
//         date: date[1],
//         name: date[0],
//       ));
//     }
//     return images;
//   }

//   Future<List<DirectoryModel>> getDocumentFiles(final groupName) async {
//     final Reference mediaRef =
//         FirebaseStorage.instance.ref().child("$groupName/documents/");
//     ListResult docList = await mediaRef.list();
//     RxList<DirectoryModel> docs = <DirectoryModel>[].obs;
//     for (Reference item in docList.items) {
//       String url = await item.getDownloadURL();
//       List<String> splitDateandName = await item.name.split('[');
//       docs.add(DirectoryModel(
//           path: url, date: splitDateandName[1], name: splitDateandName[0]));
//     }
//     return docs;
//   }


//   Future<List<DirectoryModel>> getSingleChatMediaFile(
//       {required String recieverUID, required String senderUID}) async {
//     print("$senderUID[$recieverUID");
//     final Reference mediaRef = FirebaseStorage.instance
//         .ref()
//         .child("Messages/media/$recieverUID[$senderUID/");
//     final Reference mediaRef2 = FirebaseStorage.instance
//         .ref()
//         .child("Messages/media/$senderUID[$recieverUID/");
//     ListResult imagesList2 = await mediaRef2.list();
//     ListResult imagesList = await mediaRef.list();
//     RxList<DirectoryModel> images = <DirectoryModel>[].obs;
//     for (Reference item in imagesList.items) {
//       String url = await item.getDownloadURL();
//       List<String> date = await item.name.split('[');
//       images.add(DirectoryModel(
//         path: url,
//         date: date[1],
//         name: date[0],
//       ));
//     }
//     for (Reference item2 in imagesList2.items) {
//       String url2 = await item2.getDownloadURL();
//       List<String> date2 = await item2.name.split('[');
//       images.add(DirectoryModel(
//         path: url2,
//         date: date2[1],
//         name: date2[0],
//       ));
//     }
//     return images;
//   }

//    Future<List<DirectoryModel>> getSingleChatDocumentFile(
//       {required String recieverUID, required String senderUID}) async {
//     print("$senderUID[$recieverUID");
//     final Reference mediaRef = FirebaseStorage.instance
//         .ref()
//         .child("Messages/documents/$recieverUID[$senderUID/");
//     final Reference mediaRef2 = FirebaseStorage.instance
//         .ref()
//         .child("Messages/documents/$senderUID[$recieverUID/");
//     ListResult imagesList2 = await mediaRef2.list();
//     ListResult imagesList = await mediaRef.list();
//     RxList<DirectoryModel> images = <DirectoryModel>[].obs;
//     for (Reference item in imagesList.items) {
//       String url = await item.getDownloadURL();
//       List<String> date = await item.name.split('[');
//       images.add(DirectoryModel(
//         path: url,
//         date: date[1],
//         name: date[0],
//       ));
//     }
//     for (Reference item2 in imagesList2.items) {
//       String url2 = await item2.getDownloadURL();
//       List<String> date2 = await item2.name.split('[');
//       images.add(DirectoryModel(
//         path: url2,
//         date: date2[1],
//         name: date2[0],
//       ));
//     }
//     return images;
//   }
// }
