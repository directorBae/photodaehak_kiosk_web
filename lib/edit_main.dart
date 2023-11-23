import 'dart:async';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:ui' as ui;
import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as image;
import 'package:js/js.dart';
import 'package:http/http.dart' as http;

@JS()
external void _exportRaw(String key, Uint8List value);

class ImageSaver {
  static Future<String> save(String name, Uint8List fileData) async {
    _exportRaw(name, fileData);
    return name;
  }
}

var colorMatchList = {
  "uni": const Color(0xff46BEBF),
  "peak": const Color(0xffE0858E),
  "astral": const Color(0xffff69b4),
  "photon": const Color(0xffffe109),
  "esc": const Color(0xfff1afbc),
  "unplugged": const Color(0xffff8e7f),
  "unis": const Color(0xff12243C)
};

final Map<String, List<double>> layoutFirstValue = {
  "horizontal": [900.0, 600.0],
  "vertical": [600.0, 900.0]
};

List logoDisplayInfoList = [
  {
    "logoname": "nologo",
    "showname": "무로고",
    "sampleimage": "assets/images/nologo.png",
    "editimage": "assets/images/nologo_use.png"
  },
  {
    "logoname": "mascot_only",
    "showname": "윤이",
    "sampleimage": "assets/images/logo-mascot_only.png",
    "editimage": "assets/images/mascot_only_use.png"
  },
  {
    "logoname": "mascot_symbol",
    "showname": "윤이",
    "sampleimage": "assets/images/logo-mascot_symbol.png",
    "editimage": "assets/images/mascot_symbol_use.png"
  },
  {
    "logoname": "epidemic",
    "showname": "EpideMIC",
    "sampleimage": "assets/images/logo-epidemic.png",
    "editimage": "assets/images/epidemic_use.png"
  },
  {
    "logoname": "pitchhigh",
    "showname": "PitchHigh",
    "sampleimage": "assets/images/logo-pitchhigh.png",
    "editimage": "assets/images/pitchhigh_use.png"
  },
  {
    "logoname": "unich",
    "showname": "UNICH",
    "sampleimage": "assets/images/logo-unich.png",
    "editimage": "assets/images/unich_use.png"
  },
  {
    "logoname": "peak",
    "showname": "PEAK",
    "sampleimage": "assets/images/logo-peak.png",
    "editimage": "assets/images/peak_use.png"
  },
  {
    "logoname": "hexa",
    "showname": "HeXA",
    "sampleimage": "assets/images/logo-hexa.png",
    "editimage": "assets/images/hexa_use.png"
  },
  {
    "logoname": "junto",
    "showname": "JUNTO",
    "sampleimage": "assets/images/logo-junto.png",
    "editimage": "assets/images/junto_use.png"
  },
  {
    "logoname": "nest",
    "showname": "NEST",
    "sampleimage": "assets/images/logo-nest.png",
    "editimage": "assets/images/nest_use.png"
  },
  {
    "logoname": "ivf",
    "showname": "IVF",
    "sampleimage": "assets/images/logo-ivf.png",
    "editimage": "assets/images/ivf_use.png"
  },
  {
    "logoname": "rockets",
    "showname": "UNIST ROCKETS",
    "sampleimage": "assets/images/logo-rockets.png",
    "editimage": "assets/images/rockets_use.png"
  },
  {
    "logoname": "ensemble",
    "showname": "ENSEMBLE",
    "sampleimage": "assets/images/logo-ensemble.png",
    "editimage": "assets/images/ensemble_use.png"
  },
  {
    "logoname": "czardas",
    "showname": "CZARDAS",
    "sampleimage": "assets/images/logo-czardas.png",
    "editimage": "assets/images/czardas_use.png"
  },
  {
    "logoname": "uni",
    "showname": "UNI",
    "sampleimage": "assets/images/logo-uni.png",
    "editimage": "assets/images/uni_use.png"
  },
  {
    "logoname": "clubunion_1",
    "showname": "CLUB UNION",
    "sampleimage": "assets/images/logo-clubunion_1.png",
    "editimage": "assets/images/clubunion_1_use.png"
  },
  {
    "logoname": "clubunion_2",
    "showname": "CLUB UNION",
    "sampleimage": "assets/images/logo-clubunion_2.png",
    "editimage": "assets/images/clubunion_2_use.png"
  },
  {
    "logoname": "geekhak",
    "showname": "Dorm Council",
    "sampleimage": "assets/images/logo-geekhak.png",
    "editimage": "assets/images/geekhak_use.png"
  },
  {
    "logoname": "astral",
    "showname": "ASTRAL",
    "sampleimage": "assets/images/logo-astral.png",
    "editimage": "assets/images/astral_use.png"
  },
  {
    "logoname": "earthcops",
    "showname": "EarthCops",
    "sampleimage": "assets/images/logo-earthcops.png",
    "editimage": "assets/images/earthcops_use.png"
  },
  {
    "logoname": "esc",
    "showname": "ESC",
    "sampleimage": "assets/images/logo-esc.png",
    "editimage": "assets/images/esc_use.png"
  },
  {
    "logoname": "melpo",
    "showname": "Melting Point",
    "sampleimage": "assets/images/logo-melpo.png",
    "editimage": "assets/images/melpo_use.png"
  },
  {
    "logoname": "photon",
    "showname": "Phot:ON",
    "sampleimage": "assets/images/logo-photon.png",
    "editimage": "assets/images/photon_use.png"
  },
  {
    "logoname": "unplugged",
    "showname": "Unplugged",
    "sampleimage": "assets/images/logo-unplugged.png",
    "editimage": "assets/images/unplugged_use.png"
  },
  {
    "logoname": "unis",
    "showname": "UNIS",
    "sampleimage": "assets/images/logo-unis.png",
    "editimage": "assets/images/unis_use.png"
  },
  {
    "logoname": "cres",
    "showname": "Crescendo",
    "sampleimage": "assets/images/logo-cres.png",
    "editimage": "assets/images/cres_use.png"
  },
];

List layOutDisplayInfoList = [
  {
    "layoutname": "ho-0-basic",
    "showname": "가로 무틀",
    "sampleimage": "assets/images/ho-0-basic-display.png",
    "srcNum": 1,
    "layoutHW": [600.0, 900.0],
    "srcHW": [600.0, 900.0],
    "srcloc": [
      [0.0, 0.0]
    ]
  },
  {
    "layoutname": "ho-1-basic",
    "showname": "가로 1분할",
    "sampleimage": "assets/images/ho-1-basic-display.png",
    "srcNum": 1,
    "layoutHW": [600.0, 900.0],
    "srcHW": [482.0, 858.5],
    "srcloc": [
      [21.0, 21.0]
    ]
  },
  {
    "layoutname": "ho-1-right",
    "showname": "가로 1분할 (우측로고)",
    "sampleimage": "assets/images/ho-1-right-display.png",
    "srcNum": 1,
    "layoutHW": [600.0, 900.0],
    "srcHW": [559.0, 734.5],
    "srcloc": [
      [21.0, 21.0]
    ]
  },
  {
    "layoutname": "ho-2-basic",
    "showname": "가로 2분할",
    "sampleimage": "assets/images/ho-2-basic-display.png",
    "srcNum": 2,
    "layoutHW": [600.0, 900.0],
    "srcHW": [435.38, 420.41],
    "srcloc": [
      [21.0, 21.0],
      [21.0, 459.051]
    ]
  },
  {
    "layoutname": "ho-4-basic",
    "showname": "가로 4분할",
    "sampleimage": "assets/images/ho-4-basic-display.png",
    "srcNum": 4,
    "layoutHW": [600.0, 900.0],
    "srcHW": [235.50, 422.0],
    "srcloc": [
      [21.0, 20.54544],
      [21.0, 459.8],
      [274.0, 20.5405],
      [274.0, 459.8]
    ]
  },
  {
    "layoutname": "ve-0-basic",
    "showname": "세로 무틀",
    "sampleimage": "assets/images/ve-0-basic-display.png",
    "srcNum": 1,
    "layoutHW": [900.0, 600.0],
    "srcHW": [900.0, 600.0],
    "srcloc": [
      [0.0, 0.0]
    ]
  },
  {
    "layoutname": "ve-1-basic",
    "showname": "세로 1분할",
    "sampleimage": "assets/images/ve-1-basic-display.png",
    "srcNum": 1,
    "layoutHW": [900.0, 600.0],
    "srcHW": [722.08, 535.07],
    "srcloc": [
      [25.0, 33.0]
    ]
  },
  {
    "layoutname": "ve-2-basic",
    "showname": "세로 2분할",
    "sampleimage": "assets/images/ve-2-basic-display.png",
    "srcNum": 2,
    "layoutHW": [900.0, 600.0],
    "srcHW": [358.0, 559.0],
    "srcloc": [
      [21.0, 21.0],
      [397.04544, 21.0]
    ]
  },
  {
    "layoutname": "ve-4-basic",
    "showname": "세로 4분할",
    "sampleimage": "assets/images/ve-4-basic-display.png",
    "srcNum": 4,
    "layoutHW": [900.0, 600.0],
    "srcHW": [358.0, 271.2],
    "srcloc": [
      [20.67225, 21.0],
      [21.0, 308.2],
      [397.0, 21.0],
      [397.0, 308.2]
    ]
  }
];

class PalleteStateController extends GetxController {
  @override
  void onInit() {
    callStatus();
    super.onInit();
  }

  void sendMessage(String botToken, int chatId, String message) async {
    final uri = Uri.https(
      'api.telegram.org',
      '/bot$botToken/sendMessage',
      {
        'chat_id': chatId.toString(),
        'text': message,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      debugPrint('Message sent successfully.');
    } else {
      debugPrint('Failed to send message.');
    }
  }

  Payload payload = Payload();

  //결제용 데이터 init
  bootpayReqeustDataInit() {
    Item item1 = Item();
    item1.name = "사진"; // 주문정보에 담길 상품명
    item1.qty = cartCount.reduce((v, e) => (v + e)); // 해당 상품의 주문 수량
    item1.id = "Photo"; // 해당 상품의 고유 키
    item1.price = 1000; // 상품의 가격

    payload.webApplicationId = ''; // web application id

    payload.pg = '카카오페이';
    payload.method = '간편';
    // payload.methods = ['card', 'phone', 'vbank', 'bank', 'kakao'];
    payload.orderName = item1.name; //결제할 상품명
    payload.price = item1.qty! * item1.price!; //정기결제시 0 혹은 주석

    payload.orderId = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); //주문번호, 개발사에서 고유값으로 지정해야함
    List<Item> itemList = [item1];
    payload.items = itemList; // 상품정보 배열

    Extra extra = Extra(); // 결제 옵션

    // extra.quotas = [0,2,3];
    //extra.quota = '0,2,3';
    //extra.popup = 1;
    //extra.quickPopup = 1;

    // extra.clo

    // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
    // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능
    payload.extra = extra;
    payload.extra?.openType = "iFrame";
  }

  void goBootpayTest(BuildContext context) {
    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: true,
      closeButton: const Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        Bootpay().dismiss(context);
      },
      onError: (String data) {
        Bootpay().dismiss(context);
      },
      onClose: () {
        Bootpay().dismiss(context);
      },
      onIssued: (String data) {
        Bootpay().dismiss(context);
      },
      onConfirm: (String data) {
        //1. 바로 승인하고자 할 때
        return true;
        /***
            2. 비동기 승인 하고자 할 때
            checkQtyFromServer(data);
            return false;
         ***/
      },
      onDone: (String data) {
        makelog();
        stockManage();
        Get.toNamed('/final', arguments: getPrintURL());
        _downloadImage();
      },
    );
  }

  Future<List<String>> getPrintURL() async {
    List<String> printPhotos = [];
    for (int i = 0; i < cartName.length; i++) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("Cart/renderedPhoto_${cartName[i]}");
      String url = await ref.getDownloadURL();
      printPhotos.add(url);
    }
    return printPhotos;
  }

  void callStatus() {
    layoutPath = layoutPath;
  }

  //To Controll Source Image Editing layouts
  RxList<bool> controllLayoutList =
      List<bool>.generate(layOutDisplayInfoList.length, (index) => false).obs;

  //To Controll Source Image Editing layouts

  final List<String> photoCount = Get.arguments;

  //Pallete Infos start
  RxString color = 'black'.obs;
  RxString logo = 'nologo'.obs;
  RxString layout = 'ho-1-basic'.obs;
  Rx<int> index = 1.obs;

  RxString layoutPath = 'assets/images/ho-1-basic-black-nologo.png'.obs;
  RxList<List<double>> srcCP = [
    [21.0, 21.0],
    [0.0, 0.0],
    [0.0, 0.0],
    [0.0, 0.0]
  ].obs;
  RxList<double> srcHW = [482.0, 858.5].obs;
  RxList<double> layoutHW = [900.0, 600.0].obs;

  Rx<int> srcNum = 1.obs;
  RxList<String?> srcPath = [null, null, null, null, 'http'].obs;
  RxList<List<double>> srcimageHW = [
    [482.0, 858.5],
    [30.0, 30.0],
    [30.0, 30.0],
    [30.0, 30.0]
  ].obs;

  RxList<List<double>> srcloc = [
    [21.0, 21.0],
    [0.0, 0.0],
    [0.0, 0.0],
    [0.0, 0.0]
  ].obs;
  RxList<double> scale = [1.0, 1.0, 1.0, 1.0].obs;

  int currentTouch = 0;
  RxList<dynamic> sourceborderColor = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent
  ].obs;

  Rx<bool> logoedit = false.obs;
  RxString logoPath = 'assets/images/nologo_use.png'.obs;

  //Pallete Infos end

  //Gesture Detect Temp values start
  double touchtempx = 0.0;
  double touchtempy = 0.0;
  double movedtempx = 0.0;
  double movedtempy = 0.0;

  double srcimageWidthtemp = 600.0;
  double srcimageHeighttemp = 300.0;

  //Gesture Detect Temp values end

  //Cart Infos start
  RxList cartCount = [].obs;
  RxList cartData = [].obs;
  RxList cartImage = [].obs;

  //Cart Infos end

  Future<ui.Image> loadImagefromAsset(String imageAssetPath) async {
    final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
    image.Image? baseImage =
        image.decodeImage(assetImageByteData.buffer.asUint8List());
    ui.Codec codec =
        await ui.instantiateImageCodec(image.encodePng(baseImage!));
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  Future<ui.Image> loadImagefromNetwork(String path) async {
    var completer = Completer<ImageInfo>();
    var img = NetworkImage(path);
    img
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  Map? findInfo() {
    for (int i = 0; i < layOutDisplayInfoList.length; i++) {
      if (layOutDisplayInfoList[i]['layoutname'] == layout.value) {
        return layOutDisplayInfoList[i];
      }
    }
    return null;
  }

  void paintImg(
      ui.Image img, Canvas canvas, Paint paint, int index, Map info) async {
    double uiimagewidth = 0.0;
    double uiimageheight = 0.0;
    double widtherror = 0.0;
    double heighterror = 0.0;

    if (img.width ~/ img.height ==
        (info['srcHW'][1] / info['srcHW'][0]).toInt()) {
      if ((info['srcHW'][1] / info['srcHW'][0]) < (img.width / img.height)) {
        if (info['srcHW'][1] > info['srcHW'][0]) {
          uiimagewidth = info['srcHW'][1];
          uiimageheight = (info['srcHW'][1] / img.width) * img.height;
          heighterror = (info['srcHW'][0] - uiimageheight) / 2;
        } else {
          uiimagewidth = (info['srcHW'][0] / img.height) * img.width;
          uiimageheight = info['srcHW'][0];
          widtherror = (info['srcHW'][1] - uiimagewidth) / 2;
        }
      } else {
        debugPrint("Thiscase");
        if (info['srcHW'][1] > info['srcHW'][0]) {
          uiimagewidth = (info['srcHW'][0] / img.height) * img.width;
          uiimageheight = info['srcHW'][0];
          widtherror = (info['srcHW'][1] - uiimagewidth) / 2;
        } else {
          uiimagewidth = info['srcHW'][1];
          uiimageheight = (info['srcHW'][1] / img.width) * img.height;
          heighterror = (info['srcHW'][0] - uiimageheight) / 2;
        }
      }
    } else {
      if (info['srcHW'][1] > info['srcHW'][0]) {
        uiimagewidth = (info['srcHW'][0] / img.height) * img.width;
        uiimageheight = info['srcHW'][0];
        widtherror = (info['srcHW'][1] - uiimagewidth) / 2;
      } else {
        uiimagewidth = info['srcHW'][1];
        uiimageheight = (info['srcHW'][1] / img.width) * img.height;
        heighterror = (info['srcHW'][0] - uiimageheight) / 2;
      }
    }

    var uint8listImage = await img.toByteData(format: ui.ImageByteFormat.png);

    image.Image resizedImage = image.copyResize(
        image.decodeImage(uint8listImage!.buffer.asUint8List())!,
        width: (uiimagewidth * scale[index] * 2).toInt(),
        height: (uiimageheight * scale[index] * 2).toInt());

    ui.Codec codec =
        await ui.instantiateImageCodec(image.encodePng(resizedImage));
    ui.FrameInfo frameInfo = await codec.getNextFrame();

    debugPrint("${-srcloc[index][1] * 2}");
    debugPrint("${-srcloc[index][0] * 2}");
    debugPrint("$widtherror");
    debugPrint("$heighterror");
    debugPrint("${(uiimagewidth * scale[index] * 2).toInt()}");
    debugPrint("${(uiimageheight * scale[index] * 2).toInt()}");
    debugPrint("${info['srcHW'][1] * 2}");
    debugPrint("${info['srcHW'][0] * 2}");

    final Rect inputSubrect = Rect.fromLTWH(
        (-srcloc[index][1]) * 2,
        (-srcloc[index][0]) * 2,
        (info['srcHW'][1] * 2),
        (info['srcHW'][0] * 2));
    final Rect outputRect = Rect.fromLTWH(
        (info['srcloc'][index][1]) * 2,
        (info['srcloc'][index][0]) * 2,
        info['srcHW'][1] * 2,
        info['srcHW'][0] * 2);
    canvas.drawImageRect(frameInfo.image, inputSubrect, outputRect, paint);
  }

  Future<Uint8List> renderImage() async {
    ui.Picture? picture;
    late ui.PictureRecorder pictureRecorder = ui.PictureRecorder();

    Map info = findInfo()!;

    Canvas canvas = Canvas(pictureRecorder);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, (layout.value[0] == 'h' ? 1800 : 1200),
            (layout.value[0] == 'h' ? 1200 : 1800)),
        Paint());

    for (int i = 0; i < srcNum.value; i++) {
      if (srcPath[i] != null) {
        paintImg(
            await loadImagefromNetwork(srcPath[i]!), canvas, Paint(), i, info);
      }
    }

    paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(0, 0, (layout.value[0] == 'h' ? 1800 : 1200),
            (layout.value[0] == 'h' ? 1200 : 1800)),
        image: await loadImagefromAsset(layoutPath.value));

    picture ??= pictureRecorder.endRecording();
    ui.Image finalimage = await picture.toImage(
        (layout.value[0] == 'h' ? 1800 : 1200),
        (layout.value[0] == 'h' ? 1200 : 1800));

    var output = await finalimage.toByteData(format: ui.ImageByteFormat.png);
    cartImage.add(output!.buffer.asUint8List());
    Get.back();
    update();
    return output.buffer.asUint8List();
  }

  void uploadPhoto(Future<Uint8List> imageByte) async {
    DateTime dt = DateTime.now();
    int timestamp = dt.millisecondsSinceEpoch;
    cartName.add(timestamp);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref("Cart/renderedPhoto_$timestamp");
    ref.putData(
      await imageByte,
      SettableMetadata(
        contentType: "image/png",
      ),
    );
  }

  Function deepEq = const DeepCollectionEquality().equals;

  void deletePhoto(index) async {
    ListResult result = await FirebaseStorage.instance.ref("Cart/").listAll();
    await FirebaseStorage.instance.ref(result.items[index].fullPath).delete();
  }

  List cartName = [];

  void pushCart() {
    List nowList = [
      color.value,
      logo.value,
      layout.value,
      layoutPath.value,
      srcCP,
      srcHW,
      layoutHW,
      srcNum.value,
      srcPath,
      srcloc,
      srcimageHW,
      scale
    ];

    if (cartCount.length < 8) {
      List copiedlist = [...nowList];
      cartData.add(copiedlist);
      cartCount.add(1);
      uploadPhoto(renderImage());
    } else {
      Get.dialog(AlertDialog(
        content: Container(
          width: 700,
          height: 150,
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: const Text(
            '장바구니에는 최대 8개의\n사진만 담을 수 있습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 35,
              fontFamily: 'Happiness-sans',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 500,
              height: 70,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color(0xfffff44f),
                    ),
                    fixedSize:
                        MaterialStatePropertyAll<Size>(Size(160.0, 70.0))),
                child: const Text(
                  '확인',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 38,
                      fontFamily: 'Happiness-sans',
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ));
    }
  }

  Future<void> _downloadImage() async {
    DateTime now = DateTime.now();
    String nowFormat =
        "${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}";
    for (int i = 0; i < cartName.length; i++) {
      int max = cartCount[i];
      for (int j = 0; j < max; j++) {
        await ImageSaver.save(
            "PrintImage_${nowFormat}_${i}_$j.png", cartImage[i]);
      }
    }
  }

  Stream<Uint8List?> showImage(Uint8List imagelist) async* {
    yield imagelist;
  }

  void pullCart(index) {
    cartData.removeAt(index);
    cartCount.removeAt(index);
    cartName.removeAt(index);
    cartImage.removeAt(index);
    update();
  }

  void plusCart(index) {
    if (cartCount[index] < 10) {
      cartCount[index]++;
      update();
    }
  }

  void minusCart(index) {
    if (cartCount[index] > 1) {
      cartCount[index]--;
      update();
    }
  }

  void makelog() {
    DateTime now = DateTime.now();
    String nowFormat =
        "${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}";

    List layoutdatalist = [];

    for (int i = 0; i < cartData.length; i++) {
      List tempsrclist = [];
      for (int j=0; j < cartData[i][7]; j++){
        tempsrclist.add({'srcPath': cartData[i][8][j],
          'srcloc': cartData[i][9][j],
          'scale': cartData[i][11][j],
        });
      }
      layoutdatalist.add({
        'color': cartData[i][0],
        'logo': cartData[i][1],
        'layout': cartData[i][2],
        'count': cartCount[i],
        'srcData': tempsrclist
      });
    }

    debugPrint(layoutdatalist.toString());

    FirebaseFirestore.instance
        .collection('photo_log')
        .doc(nowFormat)
        .set({"time": nowFormat, "LayoutsData": layoutdatalist});
  }

  void stockManage() async {
    int stock = await showStock();
    num changedstock = stock - (cartCount.reduce((v, e) => (v + e)));
    FirebaseFirestore.instance
        .collection('kiosk')
        .doc('limit')
        .update({"limitNum": changedstock});
    if (changedstock < 20) {
      sendMessage("", ,
          "현재 재고량 20개 이하, 재고관리 요망\n현재 재고량: $changedstock");
      sendMessage("", ,
          "현재 재고량 20개 이하, 재고관리 요망\n현재 재고량: $changedstock");
    }
  }

  Future<int> showStock() async {
    var result =
        await FirebaseFirestore.instance.collection('kiosk').doc('limit').get();
    int stockNow = result.data()!['limitNum'];
    return stockNow;
  }

  Future<bool> isStockMore() async {
    int stock = await showStock();
    if (cartCount.reduce((v, e) => (v + e)) <= stock) {
      return true;
    } else {
      return false;
    }
  }

  void resetBorder() {
    sourceborderColor = [
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent
    ].obs;
    update();
    Future.delayed(const Duration(milliseconds: 1000));
  }

  void resetSource() {
    srcPath = [null, null, null, null, 'http'].obs;
    sourceborderColor = [
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent
    ].obs;
  }

  void resetPallete() {
    layoutPath =
        'assets/images/${layout.value}-${color.value}-${logo.value}.png'.obs;
    update();
  }

  void resetPalleteInfo(newlayoutHW, newsrcCP, newsrcHW, newsrcNum, newindex) {
    layoutHW = newlayoutHW;
    srcCP = newsrcCP;
    srcHW = newsrcHW;
    srcNum = newsrcNum;
    index = newindex;
    update();
  }

  void changeEditScreen(layoutName) {
    for (int i = 0; i < layOutDisplayInfoList.length; i++) {
      if (layoutName != layOutDisplayInfoList[i]['layoutname']) {
        controllLayoutList[i] = false;
      } else {
        controllLayoutList[i] = true;
      }
    }
    update();
  }

  void chooselayout(layoutnewval) {
    layout = layoutnewval;
    if ((layoutnewval == 'ho-0-basic') || (layoutnewval == 've-0-basic')) {
      logoedit = true.obs;
    } else {
      logoedit = false.obs;
    }
    update();
  }

  void chooselogo(logonewval) {
    if (colorMatchList.keys.toList().contains(logonewval)) {
      logo = logonewval;
    } else {
      logo = logonewval;
      color = 'black'.obs;
    }
    chooseedit(logonewval);
    update();
  }

  void chooseedit(logonewval) {
    logoPath = "assets/images/${logonewval}_use.png".obs;
  }

  void choosecolor(colornewval) {
    if (colornewval.value == 'signature') {
      if (colorMatchList.keys.toList().contains(logo.value)) {
        color = colornewval;
      }
    } else {
      color = colornewval;
    }
    update();
  }

  dynamic colorDecision(logoVal) {
    if (colorMatchList.keys.toList().contains(logoVal)) {
      update();
      return colorMatchList[logoVal];
    } else {
      update();
      return Colors.transparent;
    }
  }

  void chooseSource(index, currentTouch) {
    srcPath[currentTouch] = photoCount[index];
    srcloc[currentTouch] = [0.0, 0.0].obs;
    scale[currentTouch] = 1.0;
    update();
  }

  void changeCurrentTouch(index) {
    currentTouch = index;
    update();
  }

  void changeCurrentTouchBorder(currentTouch) {
    for (int i = 0; i < sourceborderColor.length; i++) {
      if (i == currentTouch) {
        sourceborderColor[i] = Colors.blue;
      } else {
        sourceborderColor[i] = Colors.transparent;
      }
    }
    update();
  }

  RxBool isClick = false.obs;

  bool isRegion(index, xPos, yPos) {
    if (((xPos >= srcloc[index][0]) ||
            (xPos <= srcloc[index][0] + srcHW[0] * scale[index])) &&
        ((yPos >= srcloc[index][1]) ||
            (yPos <= srcloc[index][1] + srcHW[1] * scale[index]))) {
      return true;
    } else {
      return false;
    }
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  @override
  double get minFlingVelocity => 2.0;

  @override
  double get maxFlingVelocity => 5.0;

  @override
  double get dragStartDistanceMotionThreshold => 120.0;

  @override
  double get minFlingDistance => 10.0;

  @override
  CustomScrollPhysics applyTo(ancestor) {
    return CustomScrollPhysics();
  }
}

class EditMainPage extends StatelessWidget {
  const EditMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Home());
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  final controller = Get.put(PalleteStateController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1080,
      height: 1920,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 1080,
                height: 200,
                color: const Color(0xfffff44f),
              )),
          Positioned(
              top: 20,
              left: 40,
              child: Container(
                  width: 850,
                  height: 160,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: GetBuilder<PalleteStateController>(
                      init: PalleteStateController(),
                      builder: (_) {
                        return ListView.builder(
                          itemCount: controller.cartCount.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                                width: 200.0,
                                height: 140.0,
                                child: Row(children: [
                                  Container(
                                    width: 140,
                                    height: 140,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Stack(children: [
                                      Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Container(
                                            width: 140,
                                            height: 140,
                                            color: Colors.grey,
                                            child: Image.memory(
                                                controller.cartImage[index]),
                                          )),
                                      Positioned(
                                        top: -6,
                                        right: -10,
                                        child: TextButton(
                                            onPressed:
                                                () => Get.dialog(AlertDialog(
                                                      title: Container(
                                                        width: 900,
                                                        height: 120,
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                5, 5, 5, 5),
                                                        child: const Text(
                                                          '선택한 사진을 삭제하시겠습니까?',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 60,
                                                            fontFamily:
                                                                'Happiness-sans',
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                          ),
                                                        ),
                                                      ),
                                                      content: Container(
                                                        width: 700,
                                                        height: 110,
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                5, 5, 5, 5),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              width: 700,
                                                              height: 100,
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              child: const Text(
                                                                '사진이 영구적으로 삭제됩니다.',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 40,
                                                                  fontFamily:
                                                                      'Happiness-sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: SizedBox(
                                                            width: 500,
                                                            height: 70,
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                      controller
                                                                          .pullCart(
                                                                              index);
                                                                      controller
                                                                          .deletePhoto(
                                                                              index);
                                                                    },
                                                                    style: const ButtonStyle(
                                                                        backgroundColor: MaterialStatePropertyAll<Color>(
                                                                          Color(
                                                                              0xfffff44f),
                                                                        ),
                                                                        fixedSize: MaterialStatePropertyAll<Size>(Size(160.0, 70.0))),
                                                                    child:
                                                                        const Text(
                                                                      '예',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              38,
                                                                          fontFamily:
                                                                              'Happiness-sans',
                                                                          fontWeight:
                                                                              FontWeight.w900),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () => Get
                                                                            .back(),
                                                                    style: const ButtonStyle(
                                                                        backgroundColor: MaterialStatePropertyAll<Color>(
                                                                          Color(
                                                                              0xfffff44f),
                                                                        ),
                                                                        fixedSize: MaterialStatePropertyAll<Size>(Size(160.0, 70.0))),
                                                                    child:
                                                                        const Text(
                                                                      '아니오',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              38,
                                                                          fontFamily:
                                                                              'Happiness-sans',
                                                                          fontWeight:
                                                                              FontWeight.w900),
                                                                    ),
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                          Color>(
                                                      Colors.transparent),
                                              fixedSize:
                                                  MaterialStatePropertyAll<
                                                      Size>(Size(60.0, 60.0)),
                                              iconColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(Colors.red),
                                            ),
                                            child: const Icon(
                                                Icons.delete_forever,
                                                size: 37)),
                                      ),
                                    ]),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 140,
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: TextButton(
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(Color(0xff000000)),
                                              fixedSize:
                                                  MaterialStatePropertyAll<
                                                      Size>(Size(30.0, 30.0)),
                                            ),
                                            onPressed: () {
                                              controller.plusCart(index);
                                            },
                                            child: const Icon(Icons.add,
                                                color: Color(0xfffff44f),
                                                size: 30),
                                          ),
                                        ),
                                        Text(
                                          '${controller.cartCount[index]}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Happiness-sans',
                                              fontSize: 40,
                                              decoration: TextDecoration.none),
                                        ),
                                        SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: TextButton(
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(Color(0xff000000)),
                                              fixedSize:
                                                  MaterialStatePropertyAll<
                                                      Size>(Size(30.0, 30.0)),
                                            ),
                                            onPressed: () {
                                              controller.minusCart(index);
                                            },
                                            child: const Icon(Icons.remove,
                                                color: Color(0xfffff44f),
                                                size: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]));
                          },
                        );
                      }))),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 1080,
                height: 413,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Color(0xfffff44f),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 90,
                      top: 45,
                      child: Container(
                        width: 226,
                        height: 111,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                          color: const Color(0xffffffb7),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 90,
                      top: 45,
                      child: SizedBox(
                        width: 226,
                        height: 111,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                color: const Color(0xffffffb7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () => Get.dialog(
                                          barrierDismissible: false,
                                          AlertDialog(
                                            backgroundColor:
                                                const Color(0xfffff44f),
                                            title: const Text(
                                              '틀 테마 색상 변경',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily: 'Happiness-sans',
                                                fontWeight: FontWeight.w700,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            content:
                                                const SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text('변경하고 싶은 색상을 선택해 주세요.'),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Container(
                                                  width: 68,
                                                  height: 50,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  controller
                                                      .choosecolor('black'.obs);
                                                  controller.resetPallete();
                                                  Get.back();
                                                  controller.callStatus();
                                                },
                                              ),
                                              TextButton(
                                                child: Container(
                                                  width: 68,
                                                  height: 50,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  controller
                                                      .choosecolor('white'.obs);
                                                  controller.resetPallete();
                                                  Get.back();
                                                  controller.callStatus();
                                                },
                                              ),
                                              TextButton(
                                                child: Container(
                                                  width: 68,
                                                  height: 50,
                                                  color: controller
                                                      .colorDecision(controller
                                                          .logo.value),
                                                ),
                                                onPressed: () {
                                                  controller.choosecolor(
                                                      'signature'.obs);
                                                  controller.resetPallete();
                                                  Get.back();
                                                  controller.callStatus();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll<
                                                    Color>(Color(0xffffffb7)),
                                            shape: MaterialStatePropertyAll<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            fixedSize:
                                                const MaterialStatePropertyAll<
                                                    Size>(Size(220.0, 111.0))),
                                        child: const Text(
                                          '색상 선택',
                                          style: TextStyle(
                                            fontFamily: 'Happiness-Sans',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 428,
                      top: 45,
                      child: SizedBox(
                        width: 226,
                        height: 111,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                color: const Color(0xffffffb7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.dialog(Dialog(
                                            backgroundColor:
                                                const Color(0xffffffb7),
                                            child: SizedBox(
                                                width: 900,
                                                height: 1500,
                                                child: Column(children: [
                                                  Container(
                                                      width: 900,
                                                      height: 1400,
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 10, 10, 10),
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: PageView(
                                                            physics:
                                                                CustomScrollPhysics(),
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      "분할 선택",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            65,
                                                                        fontFamily:
                                                                            'Happiness-sans',
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        decoration:
                                                                            TextDecoration.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                      height:
                                                                          40,
                                                                      width: 10,
                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          10)),
                                                                  Expanded(
                                                                      child: GridView
                                                                          .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount:
                                                                        layOutDisplayInfoList
                                                                            .length,
                                                                    gridDelegate:
                                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          2,
                                                                      childAspectRatio:
                                                                          1 / 1,
                                                                      mainAxisSpacing:
                                                                          20,
                                                                      crossAxisSpacing:
                                                                          20,
                                                                    ),
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Get.back();
                                                                            String
                                                                                newlayoutVal =
                                                                                layOutDisplayInfoList[index]['layoutname'];
                                                                            controller.chooselayout(newlayoutVal.obs);
                                                                            List<double>
                                                                                newlayoutHWval =
                                                                                layOutDisplayInfoList[index]['layoutHW'];
                                                                            List<List<double>>
                                                                                newsrcCPval =
                                                                                layOutDisplayInfoList[index]['srcloc'];
                                                                            List<double>
                                                                                newsrcHWval =
                                                                                layOutDisplayInfoList[index]['srcHW'];
                                                                            int newsrcNumval =
                                                                                layOutDisplayInfoList[index]['srcNum'];
                                                                            int newindexval =
                                                                                index;
                                                                            controller.changeEditScreen(controller.layout.value);
                                                                            controller.resetPalleteInfo(
                                                                                newlayoutHWval.obs,
                                                                                newsrcCPval.obs,
                                                                                newsrcHWval.obs,
                                                                                newsrcNumval.obs,
                                                                                newindexval.obs);
                                                                            controller.resetSource();
                                                                            controller.resetPallete();
                                                                            controller.callStatus();
                                                                          },
                                                                          child:
                                                                              SizedBox(child: Center(child: Image.asset(layOutDisplayInfoList[index]['sampleimage']))));
                                                                    },
                                                                  )),
                                                                ],
                                                              ),
                                                            ],
                                                          ))),
                                                  Container(
                                                    width: 900,
                                                    height: 100,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 5, 5, 5),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: ElevatedButton(
                                                          style:
                                                              const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll<
                                                                        Color>(
                                                                    Colors.red),
                                                            fixedSize:
                                                                MaterialStatePropertyAll<
                                                                    Size>(
                                                              Size(150.0, 70.0),
                                                            ),
                                                          ),
                                                          onPressed: () =>
                                                              Get.back(),
                                                          child: const Text(
                                                            "닫기",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 40,
                                                              fontFamily:
                                                                  'Happiness-sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ])),
                                          ));
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll<
                                                    Color>(Color(0xffffffb7)),
                                            shape: MaterialStatePropertyAll<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            fixedSize:
                                                const MaterialStatePropertyAll<
                                                    Size>(Size(220.0, 111.0))),
                                        child: const Text(
                                          '분할 선택',
                                          style: TextStyle(
                                            fontFamily: 'Happiness-Sans',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 766,
                      top: 45,
                      child: SizedBox(
                        width: 226,
                        height: 111,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                color: const Color(0xffffffb7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () => Get.dialog(Dialog(
                                          backgroundColor:
                                              const Color(0xffffffb7),
                                          child: SizedBox(
                                              width: 900,
                                              height: 1500,
                                              child: Column(children: [
                                                Container(
                                                    width: 900,
                                                    height: 1400,
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: PageView(
                                                          physics:
                                                              CustomScrollPhysics(),
                                                          children: [
                                                            Column(
                                                              children: [
                                                                const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "학생단체",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          65,
                                                                      fontFamily:
                                                                          'Happiness-sans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    height: 40,
                                                                    width: 10,
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            10)),
                                                                Expanded(
                                                                    child: GridView
                                                                        .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      logoDisplayInfoList
                                                                          .length,
                                                                  gridDelegate:
                                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        4,
                                                                    childAspectRatio:
                                                                        1 / 1.2,
                                                                    mainAxisSpacing:
                                                                        20,
                                                                    crossAxisSpacing:
                                                                        20,
                                                                  ),
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    return TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                          String
                                                                              newlogoVal =
                                                                              logoDisplayInfoList[index]['logoname'];
                                                                          controller
                                                                              .chooselogo(newlogoVal.obs);
                                                                          controller
                                                                              .resetPallete();
                                                                          controller
                                                                              .callStatus();
                                                                        },
                                                                        child: Column(
                                                                            children: [
                                                                              Container(
                                                                                width: 150,
                                                                                height: 150,
                                                                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                                                                child: Center(
                                                                                  child: Image.asset(
                                                                                    logoDisplayInfoList[index]['sampleimage'],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 150,
                                                                                height: 60,
                                                                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                                                child: Text(
                                                                                  logoDisplayInfoList[index]['showname'],
                                                                                  textAlign: TextAlign.center,
                                                                                  style: const TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 20,
                                                                                    fontFamily: 'Happiness-sans',
                                                                                    fontWeight: FontWeight.w700,
                                                                                    decoration: TextDecoration.none,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ]));
                                                                  },
                                                                )),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "일반",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          65,
                                                                      fontFamily:
                                                                          'Happiness-sans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    height: 40,
                                                                    width: 10,
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            10)),
                                                                Expanded(
                                                                  child: GridView
                                                                      .count(
                                                                    crossAxisCount:
                                                                        4,
                                                                    mainAxisSpacing:
                                                                        20,
                                                                    crossAxisSpacing:
                                                                        20,
                                                                    childAspectRatio:
                                                                        1 / 1,
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        const ScrollPhysics(),
                                                                    children: List
                                                                        .generate(
                                                                            5,
                                                                            (index) {
                                                                      return Container(
                                                                        color: Colors
                                                                            .lightGreen,
                                                                        child: Text(
                                                                            ' Item : $index'),
                                                                      );
                                                                    }),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "자치회",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          65,
                                                                      fontFamily:
                                                                          'Happiness-sans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    height: 40,
                                                                    width: 10,
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            10)),
                                                                Expanded(
                                                                  child: GridView
                                                                      .count(
                                                                    crossAxisCount:
                                                                        4,
                                                                    mainAxisSpacing:
                                                                        20,
                                                                    crossAxisSpacing:
                                                                        20,
                                                                    childAspectRatio:
                                                                        1 / 1,
                                                                    shrinkWrap:
                                                                        true,
                                                                    physics:
                                                                        const ScrollPhysics(),
                                                                    children: List
                                                                        .generate(
                                                                            5,
                                                                            (index) {
                                                                      return Container(
                                                                        color: Colors
                                                                            .lightGreen,
                                                                        child: Text(
                                                                            ' Item : $index'),
                                                                      );
                                                                    }),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ))),
                                                Container(
                                                  width: 900,
                                                  height: 100,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: ElevatedButton(
                                                        style:
                                                            const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll<
                                                                      Color>(
                                                                  Colors.red),
                                                          fixedSize:
                                                              MaterialStatePropertyAll<
                                                                  Size>(
                                                            Size(150.0, 70.0),
                                                          ),
                                                        ),
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: const Text(
                                                          "닫기",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 40,
                                                            fontFamily:
                                                                'Happiness-sans',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ])),
                                        )),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll<
                                                    Color>(Color(0xffffffb7)),
                                            shape: MaterialStatePropertyAll<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            fixedSize:
                                                const MaterialStatePropertyAll<
                                                    Size>(Size(220.0, 111.0))),
                                        child: const Text(
                                          '로고 선택',
                                          style: TextStyle(
                                            fontFamily: 'Happiness-Sans',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 602,
                      top: 233,
                      child: SizedBox(
                        width: 226,
                        height: 111,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                color: const Color(0xffffffb7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () {
                                          controller.resetBorder();
                                          Get.dialog(
                                              barrierDismissible: false,
                                              AlertDialog(
                                                content: Container(
                                                    width: 400,
                                                    height: 150,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 5, 5, 5),
                                                    child: const Text(
                                                      "렌더링 중입니다...",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 25,
                                                        fontFamily:
                                                            'Happiness-sans',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    )),
                                              ));
                                          Future.delayed(
                                              const Duration(milliseconds: 400),
                                              () {
                                            controller.pushCart();
                                          });
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                const MaterialStatePropertyAll<
                                                    Color>(Color(0xffffffb7)),
                                            shape: MaterialStatePropertyAll<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            fixedSize:
                                                const MaterialStatePropertyAll<
                                                    Size>(Size(220.0, 111.0))),
                                        child: const Text(
                                          '장바구니에 담기',
                                          style: TextStyle(
                                            fontFamily: 'Happiness-Sans',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 840,
                      top: 233,
                      child: SizedBox(
                        width: 226,
                        height: 111,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                color: const Color(0xffffffb7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                            onPressed: () async {
                                              controller
                                                  .bootpayReqeustDataInit();
                                              if (await controller
                                                  .isStockMore()) {
                                                Get.dialog(AlertDialog(
                                                  title: Container(
                                                    width: 900,
                                                    height: 120,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 5, 5, 5),
                                                    child: const Text(
                                                      '결제를 진행하시겠습니까?',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 60,
                                                        fontFamily:
                                                            'Happiness-sans',
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    ),
                                                  ),
                                                  content: Container(
                                                    width: 700,
                                                    height: 230,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 5, 5, 5),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 700,
                                                          height: 120,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: Text(
                                                            '총 수량: ${controller.cartCount.reduce((v, e) => (v + e))}\n총 가격: ${controller.cartCount.reduce((v, e) => (v + e)) * 1000}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 40,
                                                              fontFamily:
                                                                  'Happiness-sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 700,
                                                          height: 100,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: const Text(
                                                            '이후 더 이상의 사진 편집이 불가능합니다.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 40,
                                                              fontFamily:
                                                                  'Happiness-sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        width: 500,
                                                        height: 70,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                  controller
                                                                      .goBootpayTest(
                                                                          context);
                                                                },
                                                                style:
                                                                    const ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStatePropertyAll<
                                                                                Color>(
                                                                          Color(
                                                                              0xfffff44f),
                                                                        ),
                                                                        fixedSize: MaterialStatePropertyAll<Size>(Size(
                                                                            160.0,
                                                                            70.0))),
                                                                child:
                                                                    const Text(
                                                                  '예',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          38,
                                                                      fontFamily:
                                                                          'Happiness-sans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () =>
                                                                    Get.back(),
                                                                style:
                                                                    const ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStatePropertyAll<
                                                                                Color>(
                                                                          Color(
                                                                              0xfffff44f),
                                                                        ),
                                                                        fixedSize: MaterialStatePropertyAll<Size>(Size(
                                                                            160.0,
                                                                            70.0))),
                                                                child:
                                                                    const Text(
                                                                  '아니오',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          38,
                                                                      fontFamily:
                                                                          'Happiness-sans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                              } else {
                                                controller.sendMessage(
                                                    "6591480717:AAG0BG5mhilIYt-NzF6nxlg9yY3Wt9XC5j8",
                                                    5851722403,
                                                    "재고부족 알림:\n사용자가 재고가 부족해 사진 출력을 못했습니다.\n긴급한 상황이니 빠르게 재고관리 요망");
                                                controller.sendMessage(
                                                    "6591480717:AAG0BG5mhilIYt-NzF6nxlg9yY3Wt9XC5j8",
                                                    6307851322,
                                                    "재고부족 알림:\n사용자가 재고가 부족해 사진 출력을 못했습니다.\n긴급한 상황이니 빠르게 재고관리 요망");
                                                Get.dialog(AlertDialog(
                                                  title: Container(
                                                    width: 900,
                                                    height: 120,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 5, 5, 5),
                                                    child: const Text(
                                                      '재고가 부족합니다.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 60,
                                                        fontFamily:
                                                            'Happiness-sans',
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    ),
                                                  ),
                                                  content: Container(
                                                    width: 700,
                                                    height: 230,
                                                    padding: const EdgeInsets
                                                        .fromLTRB(5, 5, 5, 5),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 700,
                                                          height: 120,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: Text(
                                                            '재고량: ${await controller.showStock()}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 40,
                                                              fontFamily:
                                                                  'Happiness-sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 700,
                                                          height: 100,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: const Text(
                                                            '재고량보다 적거나 같은 수의 사진을 인화하거나, 사진대학 고객센터로 연락주세요.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 40,
                                                              fontFamily:
                                                                  'Happiness-sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        width: 500,
                                                        height: 70,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () =>
                                                                    Get.back(),
                                                                style:
                                                                    const ButtonStyle(
                                                                        backgroundColor:
                                                                            MaterialStatePropertyAll<
                                                                                Color>(
                                                                          Color(
                                                                              0xfffff44f),
                                                                        ),
                                                                        fixedSize: MaterialStatePropertyAll<Size>(Size(
                                                                            160.0,
                                                                            70.0))),
                                                                child:
                                                                    const Text(
                                                                  '닫기',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          38,
                                                                      fontFamily:
                                                                          'Happiness-sans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                              }
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll<
                                                            Color>(
                                                        Color(0xffffffb7)),
                                                shape: MaterialStatePropertyAll<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                                fixedSize:
                                                    const MaterialStatePropertyAll<
                                                            Size>(
                                                        Size(220.0, 111.0))),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Text(
                                                    '결제하기',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Happiness-Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 28,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Image.asset(
                                                      'assets/images/payment_icon_yellow_small.png')
                                                ]))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 10,
                      child: SizedBox(
                        width: 400,
                        height: 100,
                        child: Row(
                          children: [
                            SizedBox(
                              child: TextButton(
                                onPressed: () => Get.dialog(
                                  AlertDialog(
                                    title: Container(
                                      width: 900,
                                      height: 120,
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child: const Text(
                                        '처음으로 돌아가시겠습니까?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 60,
                                          fontFamily: 'Happiness-sans',
                                          fontWeight: FontWeight.w900,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    content: Container(
                                      width: 700,
                                      height: 60,
                                      padding: EdgeInsets.zero,
                                      child: const Text(
                                        '모든 작업이 초기화됩니다!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 35,
                                          fontFamily: 'Happiness-sans',
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 500,
                                          height: 70,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      Get.offAllNamed('/first'),
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll<
                                                              Color>(
                                                        Color(0xfffff44f),
                                                      ),
                                                      fixedSize:
                                                          MaterialStatePropertyAll<
                                                                  Size>(
                                                              Size(160.0,
                                                                  70.0))),
                                                  child: const Text(
                                                    '예',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 38,
                                                        fontFamily:
                                                            'Happiness-sans',
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () => Get.back(),
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll<
                                                              Color>(
                                                        Color(0xfffff44f),
                                                      ),
                                                      fixedSize:
                                                          MaterialStatePropertyAll<
                                                                  Size>(
                                                              Size(160.0,
                                                                  70.0))),
                                                  child: const Text(
                                                    '아니오',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 38,
                                                        fontFamily:
                                                            'Happiness-sans',
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: Image.asset(
                                    'assets/images/photodaehak_logo.png'),
                              ),
                            ),
                            SizedBox(
                              width: 220,
                              height: 40,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: TextButton(
                                  style: const ButtonStyle(
                                      fixedSize: MaterialStatePropertyAll<Size>(
                                          Size(220, 40))),
                                  onPressed: () => Get.dialog(
                                    AlertDialog(
                                      title: Container(
                                        width: 900,
                                        height: 120,
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 5),
                                        child: const Text(
                                          '처음으로 돌아가시겠습니까?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 60,
                                            fontFamily: 'Happiness-sans',
                                            fontWeight: FontWeight.w900,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      content: Container(
                                        width: 700,
                                        height: 60,
                                        padding: EdgeInsets.zero,
                                        child: const Text(
                                          '모든 작업이 초기화됩니다!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 35,
                                            fontFamily: 'Happiness-sans',
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: 500,
                                            height: 70,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        Get.offAllNamed(
                                                            '/first'),
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll<
                                                                Color>(
                                                          Color(0xfffff44f),
                                                        ),
                                                        fixedSize:
                                                            MaterialStatePropertyAll<
                                                                    Size>(
                                                                Size(160.0,
                                                                    70.0))),
                                                    child: const Text(
                                                      '예',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 38,
                                                          fontFamily:
                                                              'Happiness-sans',
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () => Get.back(),
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll<
                                                                Color>(
                                                          Color(0xfffff44f),
                                                        ),
                                                        fixedSize:
                                                            MaterialStatePropertyAll<
                                                                    Size>(
                                                                Size(160.0,
                                                                    70.0))),
                                                    child: const Text(
                                                      '아니오',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 38,
                                                          fontFamily:
                                                              'Happiness-sans',
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: const Text(
                                    "처음으로 돌아가기",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'Happiness-sans',
                                      fontWeight: FontWeight.w900,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            left: 930,
            top: 57,
            child: Icon(
              Icons.shopping_cart,
              size: 70,
            ),
          ),
          Positioned(
              top: 250,
              left: 20,
              child: Container(
                width: 1080,
                height: 1100,
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      left: 50,
                      top: 170,
                      child: Container(
                        width: 950,
                        height: 950,
                        color: const Color(0xffd9d9d9),
                        child: Stack(
                          children: [
                            Positioned(
                              child: GetBuilder<PalleteStateController>(
                                init: PalleteStateController(),
                                // GetBuilder안 init
                                builder: (_) {
                                  return Center(
                                    child: SizedBox(
                                      width: layOutDisplayInfoList[controller
                                          .index.value]['layoutHW'][1],
                                      height: layOutDisplayInfoList[controller
                                          .index.value]['layoutHW'][0],
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              width: layOutDisplayInfoList[
                                                      controller.index.value]
                                                  ['layoutHW'][1],
                                              height: layOutDisplayInfoList[
                                                      controller.index.value]
                                                  ['layoutHW'][0],
                                              child: ((controller
                                                              .layout.value ==
                                                          'ho-0-basic') ||
                                                      (controller
                                                              .layout.value ==
                                                          've-0-basic'))
                                                  ? Image.asset(
                                                      'assets/images/transparent.png')
                                                  : Image.asset(
                                                      controller
                                                          .layoutPath.value,
                                                      fit: BoxFit.fill),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                                child: Stack(
                                              children: List<Widget>.generate(
                                                controller.srcNum.value,
                                                (int srccode) => Positioned(
                                                  left: layOutDisplayInfoList[
                                                          controller
                                                              .index.value]
                                                      ['srcloc'][srccode][1],
                                                  top: layOutDisplayInfoList[
                                                          controller
                                                              .index.value]
                                                      ['srcloc'][srccode][0],
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: controller
                                                                      .sourceborderColor[
                                                                  srccode],
                                                              width: 3)),
                                                      width: layOutDisplayInfoList[
                                                              controller.index.value]
                                                          ['srcHW'][1],
                                                      height:
                                                          layOutDisplayInfoList[
                                                                  controller
                                                                      .index
                                                                      .value]
                                                              ['srcHW'][0],
                                                      child: GestureDetector(
                                                        behavior:
                                                            HitTestBehavior
                                                                .translucent,
                                                        onDoubleTapDown:
                                                            (values) {
                                                          controller.scale[
                                                                  srccode] =
                                                              (controller.scale[
                                                                      srccode] *
                                                                  1.1);
                                                        },
                                                        onHorizontalDragDown:
                                                            (details) {
                                                          if (controller.isRegion(
                                                              srccode,
                                                              details
                                                                  .localPosition
                                                                  .dx,
                                                              details
                                                                  .localPosition
                                                                  .dy)) {
                                                            controller.isClick =
                                                                true.obs;
                                                            controller
                                                                .changeCurrentTouch(
                                                                    srccode);
                                                            controller
                                                                .changeCurrentTouchBorder(
                                                                    controller
                                                                        .currentTouch);
                                                          }
                                                          controller
                                                                  .touchtempx =
                                                              details
                                                                  .localPosition
                                                                  .dx;
                                                          controller
                                                                  .touchtempy =
                                                              details
                                                                  .localPosition
                                                                  .dy;
                                                          controller
                                                                  .movedtempx =
                                                              controller.srcloc[
                                                                  srccode][1];
                                                          controller
                                                                  .movedtempy =
                                                              controller.srcloc[
                                                                  srccode][0];
                                                        },
                                                        onHorizontalDragEnd:
                                                            (details) {
                                                          controller.isClick =
                                                              false.obs;
                                                        },
                                                        onHorizontalDragUpdate:
                                                            (details) {
                                                          controller.srcloc[
                                                                  srccode]
                                                              [1] = details
                                                                  .localPosition
                                                                  .dx -
                                                              controller
                                                                  .touchtempx +
                                                              controller
                                                                  .movedtempx;
                                                          controller.srcloc[
                                                                  srccode]
                                                              [0] = details
                                                                  .localPosition
                                                                  .dy -
                                                              controller
                                                                  .touchtempy +
                                                              controller
                                                                  .movedtempy;
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Obx(
                                                              () => Positioned(
                                                                left: controller
                                                                        .srcloc[
                                                                    srccode][1],
                                                                top: controller
                                                                        .srcloc[
                                                                    srccode][0],
                                                                child: controller.srcPath[
                                                                            srccode] !=
                                                                        null
                                                                    ? Image
                                                                        .network(
                                                                        controller
                                                                            .srcPath[srccode]!,
                                                                        width: controller.srcHW[1] *
                                                                            controller.scale[srccode],
                                                                        height: controller.srcHW[0] *
                                                                            controller.scale[srccode],
                                                                        fit: BoxFit
                                                                            .contain,
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                      )
                                                                    : Image.asset(
                                                                        "assets/images/transparent.png"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            left: 95,
            top: 220,
            child: SizedBox(
              width: 880,
              height: 180,
              child: ListView.builder(
                itemCount: controller.photoCount.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextButton(
                          style: const ButtonStyle(
                              fixedSize: MaterialStatePropertyAll<Size>(
                                  Size(180.0, 180.0))),
                          onPressed: () {
                            controller.chooseSource(
                                index, controller.currentTouch);
                          },
                          child: Image.network(
                            controller.photoCount[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          GetBuilder<PalleteStateController>(
            init: PalleteStateController(),
            // GetBuilder안 init
            builder: (_) {
              return Positioned(
                  top:
                      controller.layout.value == 'ho-0-basic' ? 1100.5 : 1250.5,
                  left: controller.layout.value == 'ho-0-basic' ? 820.5 : 685.5,
                  child: Visibility(
                      visible: controller.logoedit.value,
                      child: SizedBox(
                          width: 200,
                          height: 100,
                          child: Image.asset(
                            controller.logoPath.value,
                          ))));
            },
          )
        ],
      ),
    );
  }
}
