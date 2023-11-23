import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> getUploadedNum() async {
  var result = await FirebaseFirestore.instance
      .collection('uploads')
      .doc('upload_name')
      .get();
  int photoNum = result.data()!['upload_number'];
  return photoNum;
}

class PhotoUploadController extends GetxController {
  void isTherePhoto() async {
    var number = await getUploadedNum();
    ListResult mobileresult =
        await FirebaseStorage.instance.ref("Mobile/").listAll();
    List itemlist = mobileresult.items;
    if ((number == itemlist.length) && (itemlist.isNotEmpty)) {
      waitsometimeDialog();
      List<String> values = await callMobilePhoto(mobileresult);
      if (values.isNotEmpty) {
        Timer(const Duration(milliseconds: 500), () {
          Get.toNamed('/edit_main', arguments: values);
        });
      }
    }
    else if (itemlist.isNotEmpty){
      stillUploadingDialog();
      Timer(const Duration(milliseconds: 1000), () {
        Get.back();
      });
    }
    else {
      noPhotoinDBDialog();
      Timer(const Duration(milliseconds: 1000), () {
        Get.back();
      });
    }
  }

  Future<List<String>> callMobilePhoto(ListResult a) async {
    List<String> imageList = [];
    for (int i = 0; i < a.items.length; i++) {
      Reference ref = FirebaseStorage.instance.ref().child(a.items[i].fullPath);
      imageList.add(await ref.getDownloadURL());
    }
    return imageList;
  }
}

Future<dynamic> _showMoveFirstPageDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Container(
        width: 900,
        height: 120,
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.offAllNamed('/first'),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color(0xfffff44f),
                        ),
                        fixedSize:
                            MaterialStatePropertyAll<Size>(Size(160.0, 70.0))),
                    child: const Text(
                      '예',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 38,
                          fontFamily: 'Happiness-sans',
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color(0xfffff44f),
                        ),
                        fixedSize:
                            MaterialStatePropertyAll<Size>(Size(160.0, 70.0))),
                    child: const Text(
                      '아니오',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 38,
                          fontFamily: 'Happiness-sans',
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ]),
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> _termsofUseDialog() async {
  return Get.dialog( AlertDialog(
      title: Container(
        width: 500,
        height: 60,
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: const Text(
          '이용약관\nTerms of Use',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Happiness-sans',
            fontWeight: FontWeight.w900,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      content: Container(
        width: 700,
        height: 900,
        padding: EdgeInsets.zero,
        child: const Text(
          """
1.	서비스 제공 범위
\t\t\t\t\tA.	당사는 사진 편집 기능과 사진틀 제공 서비스, 사진 출력 서비스를 제공합니다.\n\t\t\t\t\t\t\t\t\t\t이 서비스를 통해 사용자는 결제 후 자신이 편집한 사진을 출력할 수 있습니다.
\t\t\t\t\tB.	제공되는 사진틀은 다양한 디자인과 분할로 제공되며, 사용자가 편집한 사진과 함께 인쇄할 수 있도록 지원합니다.
\t\t\t\t\tC.	본 서비스는 인터넷 상의 웹을 통해 온라인으로 제공되나 당사가 설치하는 키오스크에서만 사용이 가능합니다.
\t\t\t\t\tD.	본사의 서비스는 일체의 개인정보를 수집하지 않습니다.

2.	서비스 제공
\t\t\t\t\tA.	당사의 서비스는 연중무휴, 1일 24시간 제공함을 원칙으로 합니다.

3.	저작권 및 지적재산권
\t\t\t\t\tA.	무단 도용 금지
\t\t\t\t\t\t\t\t\t\ti.	“사진대학” 로고의 무단 도용, 복제, 배포, 수정, 판매, 상업적 이용 또는 타인에게 양도하는 행위는 엄격히 금지됩니다.
\t\t\t\t\t\t\t\t\t\tii.	사용자는 당사로부터 사전에 서면으로 승인을 받은 경우를 제외하고,\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t “사진대학” 로고를 어떠한 방식으로도 사용하거나 이용해서는 안됩니다.

4.	결제 및 요금
\t\t\t\t\tA.	유료 서비스
\t\t\t\t\t\t\t\t\t\ti.	본 서비스 중 “사진틀 인화 서비스”는 유료로 제공됩니다. 사용자가 해당 서비스를 이용하려면 요금을 지불해야 합니다.
\t\t\t\t\tB.	결제 방식
\t\t\t\t\t\t\t\t\t\ti.	“사진틀 인화 서비스”의 가격과 결제 방법은 웹사이트 내에서 공지되며, 공지된 가격에 따라 결제를 진행해야 합니다.
\t\t\t\t\t\t\t\t\t\tii.	결제는 통상적으로 사용되는 온라인 결제 방식 중 “카카오페이” 결제 방식을 사용합니다.
\t\t\t\t\tC.	결제 절차
\t\t\t\t\t\t\t\t\t\ti.	“사진틀 인화 서비스”를 이용하고자 하는 사용자는 웹사이트 내에서 해당 서비스를 선택한 후 결제 절차를 진행합니다.
\t\t\t\t\t\t\t\t\t\tii.	결제 절차에는 카카오페이 로그인, 결제 금액 확인, 결제 방식 선택 등이 포함됩니다.
\t\t\t\t\t\t\t\t\t\tiii.	결제가 완료되면 사용자에게 사진을 인화하여 제공합니다.

5.	취소 및 환불
\t\t\t\t\tA.	주문 취소 및 환불
\t\t\t\t\t\t\t\t\t\ti.	본 온라인 판매 플랫폼에서 구매한 상품에 대한 취소 및 환불은 일반적으로 불가능합니다.
\t\t\t\t\t\t\t\t\t\tii.	단, 제품의 하자 또는 기기 오류로 인해 상품을 받을 수 없거나\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t상품에 문제가 발생한 경우에 한하여 예외적으로 취소 및 환불이 가능합니다.
\t\t\t\t\tB.	취소 및 환불 절차
\t\t\t\t\t\t\t\t\t\ti.	취소 및 환불 신청은 아래 연락처를 통해 문의하여 주시기 바랍니다.
\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t1.	전화번호 : 010-5062-8986
\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t2.	이메일 : ckdanr@unist.ac.kr
\t\t\t\t\tC.	기타 사항
\t\t\t\t\t\t\t\t\t\ti.	취소 및 환불 신청 시, 관련 정보를 정확하게 제공해주셔야 정확한 처리가 가능합니다.
\t\t\t\t\t\t\t\t\t\tii.	취소 및 환불 관련 절차 및 조건에 대한 상세한 내용은 문의를 통해 확인해주시기 바랍니다.

6.	서비스 제한 및 책임
\t\t\t\t\tA.	당사는 서비스를 지속적으로 제공하기 위해 최선을 다하며,\n\t\t\t\t\t\t\t\t\t\t기술적 또는 운영적 문제로 인한 문제로 인해 일시적인 서비스 중단이 발생할 수 있습니다.\n\t\t\t\t\t\t\t\t\t\t이러한 경우에는 빠른 시일 내에 서비스를 복구하도록 노력하겠습니다.
\t\t\t\t\tB.	당사는 서비스의 이용으로 발생하는 문제 또는 피해에 대해 책임을 부담하지 않습니다.\n\t\t\t\t\t\t\t\t\t\t당사의 고의 또는 중대한 과실이 없는 한, 모든 서비스 이용은 사용자 본인의 책임 하에 수행되는 것으로 간주됩니다.

7.	약관 변경
\t\t\t\t\tA.	약관 변경 권리
\t\t\t\t\t\t\t\t\t\ti.	당사는 약관을 변경 및 추가할 권리를 보유합니다.
\t\t\t\t\t\t\t\t\t\tii.	약관 변경은 온라인 판매 플랫폼의 개선, 법적 규정의 변경, 업무 확장, 제품 수정 등 기타 합리적인 사유에 의해 이루어질 수 있습니다.
\t\t\t\t\tB.	사전 공지
\t\t\t\t\t\t\t\t\t\ti.	당사가 약관을 변경 또는 추가하고자 할 경우, 이를 웹사이트 내에서 최소 7일 전에 사전 공지합니다.
\t\t\t\t\t\t\t\t\t\tii.	공지되는 내용에는 변경될 약관의 주요 내용 및 적용 예정일 등이 명시됩니다.
\t\t\t\t\t\t\t\t\t\tiii.	사용자는 약관에 대한 사전 공지 후, 변경된 약관의 효력 발생일 전까지 이의를 제기할 수 있습니다.
\t\t\t\t\tC.	변경된 약관의 효력
\t\t\t\t\t\t\t\t\t\ti.	사전 공지 기간이 지나고 변경된 약관의 적용일이 도래하면, 변경된 약관은 사용자와 당사 사이의 새로운 합의로 간주됩니다.
\t\t\t\t\t\t\t\t\t\tii.	변경된 약관은 적용일 이후의 모든 서비스 이용에 적용되며, 기존 서비스 이용에 대해서도 변경된 약관이 적용됩니다.
""",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'Happiness-sans',
            fontWeight: FontWeight.w500,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color(0xfffff44f),
                        ),
                        fixedSize:
                            MaterialStatePropertyAll<Size>(Size(80.0, 40.0))),
                    child: const Text(
                      '닫기',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontFamily: 'Happiness-sans',
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ]),
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> waitsometimeDialog() {
  return Get.dialog(
      barrierDismissible: true,
      AlertDialog(
        content: Container(
          width: 300,
          height: 40,
          padding: EdgeInsets.zero,
          child: const Text(
            """잠시만 기다려주세요...""",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Happiness-sans',
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ));
}

Future<dynamic> stillUploadingDialog() {
  return Get.dialog(
      barrierDismissible: true,
      AlertDialog(
        content: Container(
          width: 300,
          height: 60,
          padding: EdgeInsets.zero,
          child: const Text(
            """아직 업로드 중입니다.\n잠시만 기다려주세요.""",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Happiness-sans',
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ));
}

Future<dynamic> noPhotoinDBDialog() {
  return Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        content: Container(
          width: 500,
          height: 80,
          padding: EdgeInsets.zero,
          child: const Text(
            """
          업로드된 사진이 없습니다!\n시간차 등으로 인해 오류가 발생했을 수 있습니다.\n한번 더 시도하거나, 처음으로 다시 돌아가주세요.
          """,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Happiness-sans',
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ));
}

Future<dynamic> notyetDialog() {
  return Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        content: Container(
          width: 500,
          height: 80,
          padding: EdgeInsets.zero,
          child: const Text(
            """사진이 업로드 중입니다!\n조금만 기다려주세요.""",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Happiness-sans',
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ));
}

class PhotoUploadPage extends StatelessWidget {
  PhotoUploadPage({Key? key}) : super(key: key);
  final controller = Get.put(PhotoUploadController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      width: 1080,
      height: 1920,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            left: 1024,
            top: 810,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            left: 21,
            top: 17,
            child: SizedBox(
              width: 676,
              height: 88,
              child: Text(
                "사진대학을 이용하려면?\n",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Happiness-sans',
                    color: Colors.black,
                    fontSize: 66,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
            left: -300,
            top: 200,
            child: Transform.rotate(
              angle: 2.79,
              child: Container(
                width: 1800,
                height: 473.71,
                color: const Color(0xfffff44f),
              ),
            ),
          ),
          Positioned(
            left: -300,
            top: 1030,
            child: Transform.rotate(
              angle: 2.79,
              child: Container(
                width: 1800.11,
                height: 473.71,
                color: const Color(0xfffff44f),
              ),
            ),
          ),
          Positioned(
            left: 309.23,
            top: 570.59,
            child: Transform.rotate(
              angle: 0.57,
              child: Container(
                width: 531.28,
                height: 544.77,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 630,
            top: 240,
            child: SizedBox(
              width: 361,
              height: 70,
              child: Text(
                "1. 인터넷 접속",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Happiness-sans',
                    color: Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const Positioned(
            left: 190,
            top: 1200,
            child: SizedBox(
              width: 272,
              height: 70,
              child: Text(
                "3. 사진 선택",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Happiness-sans',
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const Positioned(
            left: 213,
            top: 1453,
            child: SizedBox(
              width: 240,
              height: 61,
              child: Text(
                "최대 8장까지\n선택 가능",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Happiness-sans',
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 40,
            top: 1630,
            child: SizedBox(
              width: 1000,
              height: 120,
              child: Text(
                "휴대폰에서 업로드 완료 메시지가 뜨면\n화면을 눌러주세요.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 44,
                  fontFamily: 'Happiness-sans',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 410,
            top: 983,
            child: SizedBox(
              width: 332,
              height: 61,
              child: Text(
                "2. QR코드 접속",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Happiness-sans',
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            left: 426,
            top: 669,
            child: Container(
              width: 300,
              height: 300,
              color: const Color(0xffd9d9d9),
              padding: const EdgeInsets.symmetric(
                horizontal: 39,
                vertical: 38,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 222,
                    height: 50,
                    child: Text(
                      "QR 코드",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Happiness-sans',
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  QrImageView(
                    data: "https://photodaehak.shop/#/upload_mobile",
                    version: QrVersions.auto,
                    size: 170,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 269,
            top: 1301,
            child: SizedBox(
              width: 127,
              height: 115,
              child: Image.asset("assets/images/gallery_icon.png"),
            ),
          ),
          Positioned(
            left: 712,
            top: 320,
            child: SizedBox(
              width: 131,
              height: 141,
              child: Image.asset("assets/images/wifi_icon.png"),
            ),
          ),
          Positioned(
            left: 1,
            top: 1,
            child: SizedBox(
              width: 1075,
              height: 1915,
              child: TextButton(
                onPressed: () async {
                  controller.isTherePhoto();
                },
                child: const Text(""),
              ),
            ),
          ),
          Positioned(
            left: 70,
            top: 250,
            child: SizedBox(
              width: 400,
              height: 300,
              child: Column(children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Happiness-sans',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none),
                      "사진대학의 서비스를 이용할 경우 이용약관에 동의한 것으로 간주합니다."),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: const ButtonStyle(alignment: Alignment.centerRight),
                    onPressed: () => _termsofUseDialog(),
                    child: const Text(
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            decoration: TextDecoration.underline),
                        "이용약관 보기"),
                  ),
                ),
                const Text(
                  """
                          상호명 : 주식회사 트립빌더
                          사업자등록번호 : 639-86-02358
                          대표자명 : 김명준
                          주소 : 울산광역시 울주군 언양읍 유니스트길 \n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t50, 114동 806-9호(울산과학기술원)
                          전화번호 : 010-5062-8986
                          """,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Happiness-sans',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: SizedBox(
              width: 400,
              height: 100,
              child: Row(
                children: [
                  SizedBox(
                    width: 220,
                    height: 40,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        style: const ButtonStyle(
                            fixedSize:
                                MaterialStatePropertyAll<Size>(Size(220, 40))),
                        onPressed: () async {
                          _showMoveFirstPageDialog(context);
                        },
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
    ));
  }
}
