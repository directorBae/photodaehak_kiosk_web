import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'first_page.dart';
import 'photo_upload_page.dart';
import 'edit_main.dart';
import 'page_final.dart';
import 'upload_mobile.dart';
import 'final_mobile.dart';
import 'unavailableaccess.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const KIOSKWEB());
}

class KIOSKWEB extends StatelessWidget {
  const KIOSKWEB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'kioskweb',
      home: const FirstPage(),
      getPages: [
        GetPage(name: '/first', page: () => const FirstPage()),
        GetPage(name: '/photo_upload', page: () => PhotoUploadPage()),
        GetPage(name: '/edit_main', page: () => const EditMainPage()),
        GetPage(name: '/final', page: () => const FinalPage()),
        GetPage(name: '/upload_mobile', page: () => MobileUpload()),
        GetPage(name: '/mobile_final', page: () => MobileFinalPage()),
        GetPage(name: '/unavailable', page: () => const UnavailableAccessPage()),
      ],
    );
  }
}
