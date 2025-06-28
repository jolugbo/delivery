import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gt_delivery/constant/app_color.dart';
import 'package:image_picker/image_picker.dart';

class HelperClass {
  final ImagePicker _picker = ImagePicker();

  // Future<bool> hasInternetConnection() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     return true; // Internet connection exists
  //   }
  //   return false; // No internet connection
  // }

  Future<File?> _pickImage(ImageSource source) async {
    File? doc;
    final XFile? pickedFile = await _picker.pickImage(source: source);
    // final XFile? pickedFile = await simulateFileSelection(
    //   'assets/images/mark.png', // Replace with your asset path
    //   'mark.png', // Desired name for the temporary file
    // );

    if (pickedFile != null) {
      doc = File(pickedFile.path);
      // if (_selectedRiderProfileImage != null &&
      //     _selectedRiderLicenseImage != null) {
      //   setState(() {
      //     isFormValid = true;
      //   });
      // }
    }
    return doc;
  }

  Future<File?> showImageSourceSelector(BuildContext context) async {
    return await showModalBottomSheet<File?>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pick from Gallery'),
              onTap: () async {
                final File? selectedFile =
                    await _pickImage(ImageSource.gallery);
                Navigator.of(context)
                    .pop(selectedFile); // Return the selected file
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Picture'),
              onTap: () async {
                final File? capturedFile = await _pickImage(ImageSource.camera);
                Navigator.of(context)
                    .pop(capturedFile); // Return the captured file
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> modalTemplate(BuildContext context,double height,Widget child) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContextcontext, StateSetter setModalState) {
            return Container(
              height: height,
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: child
            );
          },
        );
      },
    );
  }
}
