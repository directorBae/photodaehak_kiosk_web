import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ManageUploaded extends GetxController {
  int photoNum = 0;
  bool _running = true;

  @override
  void onInit() {
    getUploadedName();
    super.onInit();
  }

  void getUploadedName() async {
    var result = await FirebaseFirestore.instance
        .collection('uploads')
        .doc('upload_name')
        .get();
    photoNum = result.data()!['upload_number'];
  }

  Stream<List> photostream() async* {
    while (_running) {
      await Future.delayed(const Duration(milliseconds: 200));
      ListResult result =
          await FirebaseStorage.instance.ref("Mobile").listAll();
      List itemList = result.items;
      yield itemList;
      if ((itemList.length == photoNum) && (photoNum != 0)) {
        _running = false;
      }
    }
  }
}

class MobileFinalPage extends StatelessWidget {
  MobileFinalPage({super.key});

  final controller = Get.put(ManageUploaded());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: StreamBuilder(
              stream: controller.photostream(),
              builder: (BuildContext context, AsyncSnapshot? snapshot) {
                if (snapshot?.hasData == false) {
                  return const CircularProgressIndicator();
                } else if (snapshot?.data.length != controller.photoNum) {
                  return Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: LinearPercentIndicator(
                            padding: EdgeInsets.zero,
                            percent: snapshot?.data.length / controller.photoNum,
                            lineHeight: 5,
                            backgroundColor: Colors.black38,
                            progressColor: const Color(0xfffff44f),
                            width: MediaQuery.of(context).size.width * 0.60),
                      ));
                } else if (snapshot!.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}',
                    ),
                  );
                } else {
                  return SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.60),
                      height: (MediaQuery.of(context).size.height * 0.30),
                      child: const Text("업로드가 완료되었습니다.\n창을 닫아주세요.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              decoration: TextDecoration.none)));
                }
              }),
        ));
  }
}
