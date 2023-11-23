import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoUploadNumber extends GetxController {
  int len = 0;

  void uploadPhoto(List<Uint8List>? imageByte) async {
    if (imageByte != null) {
      List<Uint8List> imagelist = imageByte;
      len = imagelist.length;

      FirebaseStorage storage = FirebaseStorage.instance;

      FirebaseFirestore.instance
          .collection('uploads')
          .doc("upload_name")
          .set({"upload_number": len});

      for (int i = 0; i < imagelist.length; i++) {
          uploadOnePhoto(imagelist, i, storage);
      }
    }
  }

  void uploadOnePhoto(imagelist, i, storage){
    Reference ref = storage.ref("Mobile/sendedPhoto_$i");
    ref.putData(
      imagelist[i],
      SettableMetadata(
        contentType: "image/jpeg",
      ),
    );
  }
}

void tooManyPhotosAlert() {
  Get.dialog(
    AlertDialog(
      title: const Text(
        '오류',
        style: TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontFamily: 'Happiness-sans',
            fontWeight: FontWeight.w900),
      ),
      content: const Text(
        '사진은 8장까지 선택 가능합니다.',
        style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontFamily: 'Happiness-sans',
            fontWeight: FontWeight.w700),
      ),
      actions: [
        TextButton(
          child: const Text(
            "닫기",
            style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontFamily: 'Happiness-sans',
                fontWeight: FontWeight.w700),
          ),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}

class MobileUpload extends StatelessWidget {
  MobileUpload({super.key});

  final controller = Get.put(PhotoUploadNumber());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SizedBox(
          width: (MediaQuery.of(context).size.width * 0.3),
          height: (MediaQuery.of(context).size.height * 0.15),
          child: Center(
            child: TextButton(
              onPressed: () async {
                List<Uint8List>? bytesFromPicker =
                    await ImagePickerWeb.getMultiImagesAsBytes();
                bytesFromPicker == null
                    ? null
                    : (bytesFromPicker.length <= 8
                        ? {
                            controller.uploadPhoto(bytesFromPicker),
                            Get.offAllNamed('/mobile_final')
                          }
                        : tooManyPhotosAlert());
              },
              child: const Text(
                "사진 업로드\n(최대 8장)",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
