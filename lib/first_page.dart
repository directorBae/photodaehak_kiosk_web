import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void deletePhoto() async {
  ListResult cartresult = await FirebaseStorage.instance.ref("Cart/").listAll();
  ListResult mobileresult =
      await FirebaseStorage.instance.ref("Mobile/").listAll();
  for (int i = 0; i < cartresult.items.length; i++) {
    await FirebaseStorage.instance.ref(cartresult.items[i].fullPath).delete();
  }
  for (int i = 0; i < mobileresult.items.length; i++) {
    await FirebaseStorage.instance.ref(mobileresult.items[i].fullPath).delete();
  }
  FirebaseFirestore.instance
      .collection('uploads')
      .doc("upload_name")
      .set({"upload_number": 0});
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 1080,
        height: 1920,
        color: Colors.white,
        child: Stack(
          children: [
            const Positioned(
              left: 2,
              top: 1565,
              child: SizedBox(
                width: 1077,
                height: 100,
                child: Text(
                  "화면을 터치해주세요",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Happiness-sans',
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 59,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 475,
              left: 532,
              child: Container(
                width: 900,
                height: 900,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfffff44f),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 500,
                          height: 500,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xfffff44f),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 475,
                      top: 300,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 559,
                  height: 140,
                  color: const Color(0xfffff44f),
                ),
              ),
            ),
            const Positioned(
              left: 5,
              top: 740,
              child: SizedBox(
                width: 630,
                height: 104,
                child: Text(
                  "                         한 장에 1000원!\n            추억을 인화해드립니다.\n",
                  style: TextStyle(
                    fontFamily: 'Happiness-sans',
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 105,
              top: 49,
              child: SizedBox(
                width: 871,
                height: 393,
                child: Image.asset("assets/images/photounivlogo_withText.jpg"),
              ),
            ),
            const Positioned(
              left: 588,
              top: 49,
              child: SizedBox(
                width: 519,
                height: 163,
                child: Text(
                  "사진에 \n청춘을 담다.\n",
                  style: TextStyle(
                    fontFamily: 'Happiness-sans',
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 63,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 1,
              top: 1,
              child: SizedBox(
                width: 1075,
                height: 1915,
                child: TextButton(
                  onPressed: () {
                    deletePhoto();
                    Get.toNamed('/photo_upload');
                  },
                  child: const Text(""),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
