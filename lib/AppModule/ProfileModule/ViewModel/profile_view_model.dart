import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ProfileViewModel extends GetxController {
  RxString image = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Future getImageFormStorage() async {
    FilePickerResult? selectedImage = await FilePicker.platform.pickFiles();
    if (selectedImage != null) {
      Uint8List? fileBytes = selectedImage.files.first.bytes;
      String fileName = selectedImage.files.first.name;
      image.value = fileName;
    }
  }
}
