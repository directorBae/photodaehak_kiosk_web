import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> _showMoveFirstPageDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Container(width: 900, height: 120, padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: const Text('처음으로 돌아가시겠습니까?',
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
      content: Container( width: 700, height: 60, padding: EdgeInsets.zero, child:
      const Text('모든 작업이 초기화됩니다!', textAlign: TextAlign.center, style: TextStyle(
        color: Colors.red,
        fontSize: 35,
        fontFamily: 'Happiness-sans',
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      ),
      ),

      ),
      actions: <Widget>[
        Align( alignment: Alignment.center,
          child: SizedBox( width: 500, height: 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ ElevatedButton(
                  onPressed: () => Get.offAllNamed('/first'),
                  style: const ButtonStyle(backgroundColor:
                  MaterialStatePropertyAll<Color>(Color(0xfffff44f),),
                      fixedSize: MaterialStatePropertyAll<Size>(Size(160.0, 70.0))
                  ),
                  child: const Text('예', style: TextStyle(
                      color: Colors.black, fontSize: 38, fontFamily: 'Happiness-sans', fontWeight: FontWeight.w900),
                  ),
                ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                    style: const ButtonStyle(backgroundColor:
                    MaterialStatePropertyAll<Color>(Color(0xfffff44f),),
                        fixedSize: MaterialStatePropertyAll<Size>(Size(160.0, 70.0))
                    ),
                    child: const Text('아니오', style: TextStyle(
                        color: Colors.red, fontSize: 38, fontFamily: 'Happiness-sans', fontWeight: FontWeight.w900),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> _editFinish(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Container(width: 900, height: 120, padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: const Text('편집을 종료하시겠습니까?',
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
      content: Container( width: 700, height: 60, padding: EdgeInsets.zero, child:
      const Text('현재 편집한 버전이 반영됩니다.', textAlign: TextAlign.center, style: TextStyle(
        color: Colors.black,
        fontSize: 35,
        fontFamily: 'Happiness-sans',
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      ),
      ),

      ),
      actions: <Widget>[
        Align( alignment: Alignment.center,
          child: SizedBox( width: 500, height: 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  style: const ButtonStyle(backgroundColor:
                  MaterialStatePropertyAll<Color>(Color(0xfffff44f),),
                      fixedSize: MaterialStatePropertyAll<Size>(Size(160.0, 70.0))
                  ),
                  child: const Text('예', style: TextStyle(
                      color: Colors.black, fontSize: 38, fontFamily: 'Happiness-sans', fontWeight: FontWeight.w900),
                  ),
                ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: const ButtonStyle(backgroundColor:
                    MaterialStatePropertyAll<Color>(Color(0xfffff44f),),
                        fixedSize: MaterialStatePropertyAll<Size>(Size(160.0, 70.0))
                    ),
                    child: const Text('아니오', style: TextStyle(
                        color: Colors.red, fontSize: 38, fontFamily: 'Happiness-sans', fontWeight: FontWeight.w900),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ],
    ),
  );
}

Future<dynamic> _editCancel(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Container(width: 900, height: 120, padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: const Text('편집을 취소하시겠습니까?',
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
      content: Container( width: 700, height: 60, padding: EdgeInsets.zero, child:
      const Text('현재 편집하던 기록이 모두 삭제됩니다.', textAlign: TextAlign.center, style: TextStyle(
        color: Colors.red,
        fontSize: 35,
        fontFamily: 'Happiness-sans',
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      ),
      ),

      ),
      actions: <Widget>[
        Align( alignment: Alignment.center,
          child: SizedBox( width: 500, height: 70,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  style: const ButtonStyle(backgroundColor:
                  MaterialStatePropertyAll<Color>(Color(0xfffff44f),),
                      fixedSize: MaterialStatePropertyAll<Size>(Size(160.0, 70.0))
                  ),
                  child: const Text('예', style: TextStyle(
                      color: Colors.black, fontSize: 38, fontFamily: 'Happiness-sans', fontWeight: FontWeight.w900),
                  ),
                ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: const ButtonStyle(backgroundColor:
                    MaterialStatePropertyAll<Color>(Color(0xfffff44f),),
                        fixedSize: MaterialStatePropertyAll<Size>(Size(160.0, 70.0))
                    ),
                    child: const Text('아니오', style: TextStyle(
                        color: Colors.red, fontSize: 38, fontFamily: 'Happiness-sans', fontWeight: FontWeight.w900),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ],
    ),
  );
}

class Colorpopup extends StatelessWidget {
  const Colorpopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('틀 테마 색상 변경', style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Happiness-sans',
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.none,
        ),),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('변경하고 싶은 색상을 선택해 주세요.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Container(width: 68, height: 50, color: Colors.black,),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Container(width: 68, height: 50, color: Colors.red,),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Container(width: 68, height: 50, color: const Color(0xff43c1c3),),
            onPressed: () {
              Get.back();
            },
          ),
        ],
    );
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

class Layoutpopup extends StatefulWidget {
  const Layoutpopup({Key? key}) : super(key: key);

  @override
  State<Layoutpopup> createState() => _LayoutpopupState();
}

class _LayoutpopupState extends State<Layoutpopup> {
  final num currentPage = 0;
  final PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xffffffb7),
      child: SizedBox(
        width: 900,
        height: 1500,
        child: Column(
          children: [
          Container(
            width: 900,
            height: 1400,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Align(
              alignment: Alignment.center,
              child: PageView(
                physics: CustomScrollPhysics(),
                children: [
                  Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text("무틀", style: TextStyle(
                        color: Colors.black,
                        fontSize: 65,
                        fontFamily: 'Happiness-sans',
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.none,
                      ),
                      ),
                    ),
                    Container(height: 40, width: 10, padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                    Expanded(
                      child:
                      GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: List.generate(5, (index) {
                        return Container(
                          color: Colors.lightGreen,
                          child: Text(' Item : $index'),
                        );
                      }),
                    ),
                    ),
            ],
                  ),
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text("1분할", style: TextStyle(
                          color: Colors.black,
                          fontSize: 65,
                          fontFamily: 'Happiness-sans',
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none,
                        ),
                        ),
                      ),
                      Container(height: 40, width: 10, padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Expanded(
                        child:
                        GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1 / 1,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: List.generate(5, (index) {
                            return Container(
                              color: Colors.lightGreen,
                              child: Text(' Item : $index'),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text("2분할", style: TextStyle(
                          color: Colors.black,
                          fontSize: 65,
                          fontFamily: 'Happiness-sans',
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none,
                        ),
                        ),
                      ),
                      Container(height: 40, width: 10, padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Expanded(
                        child:
                        GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1 / 1,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: List.generate(5, (index) {
                            return Container(
                              color: Colors.lightGreen,
                              child: Text(' Item : $index'),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text("4분할", style: TextStyle(
                          color: Colors.black,
                          fontSize: 65,
                          fontFamily: 'Happiness-sans',
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none,
                        ),
                        ),
                      ),
                      Container(height: 40, width: 10, padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Expanded(
                        child:
                        GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1 / 1,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: List.generate(5, (index) {
                            return Container(
                              color: Colors.lightGreen,
                              child: Text(' Item : $index'),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            )
          ),
          Container(
            width: 900,
            height: 100,
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                  fixedSize: MaterialStatePropertyAll<Size>(Size(150.0, 70.0),),
                  ),
                onPressed: () => Get.back(),
                child: const Text("닫기", style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'Happiness-sans',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  ),
                ),
              )
            ),
          ),
        ]
      )
      ),
    );
  }
}

class Logopopup extends StatefulWidget {
  const Logopopup({Key? key}) : super(key: key);

  @override
  State<Logopopup> createState() => _LogopopupState();
}

class _LogopopupState extends State<Logopopup> {
  final num currentPage = 0;
  final PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xffffffb7),
      child: SizedBox(
          width: 900,
          height: 1500,
          child: Column(
              children: [
                Container(
                    width: 900,
                    height: 1400,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Align(
                        alignment: Alignment.center,
                        child: PageView(
                          physics: CustomScrollPhysics(),
                          children: [
                            Column(
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text("일반", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 65,
                                    fontFamily: 'Happiness-sans',
                                    fontWeight: FontWeight.w900,
                                    decoration: TextDecoration.none,
                                  ),
                                  ),
                                ),
                                Container(height: 40, width: 10, padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                                Expanded(
                                  child:
                                  GridView.count(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 1 / 1,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    children: List.generate(5, (index) {
                                      return Container(
                                        color: Colors.lightGreen,
                                        child: Text(' Item : $index'),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text("동아리", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 65,
                                    fontFamily: 'Happiness-sans',
                                    fontWeight: FontWeight.w900,
                                    decoration: TextDecoration.none,
                                  ),
                                  ),
                                ),
                                Container(height: 40, width: 10, padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                                Expanded(
                                  child:
                                  GridView.count(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 1 / 1,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    children: List.generate(5, (index) {
                                      return Container(
                                        color: Colors.lightGreen,
                                        child: Text(' Item : $index'),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text("학과", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 65,
                                    fontFamily: 'Happiness-sans',
                                    fontWeight: FontWeight.w900,
                                    decoration: TextDecoration.none,
                                  ),
                                  ),
                                ),
                                Container(height: 40, width: 10, padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                                Expanded(
                                  child:
                                  GridView.count(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 1 / 1,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    children: List.generate(5, (index) {
                                      return Container(
                                        color: Colors.lightGreen,
                                        child: Text(' Item : $index'),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text("자치회", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 65,
                                    fontFamily: 'Happiness-sans',
                                    fontWeight: FontWeight.w900,
                                    decoration: TextDecoration.none,
                                  ),
                                  ),
                                ),
                                Container(height: 40, width: 10, padding: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                                Expanded(
                                  child:
                                  GridView.count(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 1 / 1,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    children: List.generate(5, (index) {
                                      return Container(
                                        color: Colors.lightGreen,
                                        child: Text(' Item : $index'),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                    )
                ),
                Container(
                  width: 900,
                  height: 100,
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                          fixedSize: MaterialStatePropertyAll<Size>(Size(150.0, 70.0),),
                        ),
                        onPressed: () => Get.back(),
                        child: const Text("닫기", style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: 'Happiness-sans',
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none,
                        ),
                        ),
                      )
                  ),
                ),
              ]
          )
      ),
    );
  }
}

class EditSubPage extends StatelessWidget {
  const EditSubPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Home(title: 'edit sub home page');
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1080,
      height: 1920,
      color: Colors.white,
      child: Stack(
        children:[
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 1080,
                height: 413,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0), ),
                  color: Color(0xfffff44f),
                ),
                child: Stack(
                  children:[
                    Positioned(
                      left: 90,
                      top: 45,
                      child: Container(
                        width: 226,
                        height: 111,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 3, ),
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
                          children:[
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black, width: 3, ),
                                color: const Color(0xffffffb7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(context: context, barrierDismissible: false, builder: (context){
                                            return const Colorpopup();
                                          });
                                        },
                                        style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xffffffb7)),
                                            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                                            fixedSize: const MaterialStatePropertyAll<Size>(Size(220.0, 111.0))),
                                        child: const Text(
                                          '색상 선택',
                                          style: TextStyle(fontFamily: 'Happiness-Sans', fontWeight: FontWeight.w700,
                                            fontSize: 28, color: Colors.black, ),
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
                          children:[
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black, width: 3, ),
                                color: const Color(0xffffffb7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          onPressed: () {
                                            showDialog(context: context, barrierDismissible: false, builder: (context){
                                              return const Layoutpopup();
                                            });
                                          },
                                          style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xffffffb7)),
                                              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                                              fixedSize: const MaterialStatePropertyAll<Size>(Size(220.0, 111.0))),
                                          child: const Text(
                                            '분할 선택',
                                            style: TextStyle(fontFamily: 'Happiness-Sans', fontWeight: FontWeight.w700,
                                              fontSize: 28, color: Colors.black, ),
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
                          children:[
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black, width: 3, ),
                                color: const Color(0xffffffb7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(context: context, barrierDismissible: false, builder: (context){
                                            return const Logopopup();
                                          });
                                        },
                                        style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xffffffb7)),
                                            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                                            fixedSize: const MaterialStatePropertyAll<Size>(Size(220.0, 111.0))),
                                        child: const Text(
                                          '로고 선택',
                                          style: TextStyle(fontFamily: 'Happiness-Sans', fontWeight: FontWeight.w700,
                                            fontSize: 28, color: Colors.black, ),
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
                          children:[
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black, width: 3, ),
                                color: const Color(0xffffffb7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          onPressed: ()
                                          {
                                            _editFinish(context);
                                          },
                                          style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xffffffb7)),
                                              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                                              fixedSize: const MaterialStatePropertyAll<Size>(Size(220.0, 111.0))),
                                          child: const Text(
                                            '편집 끝내기',
                                            style: TextStyle(fontFamily: 'Happiness-Sans', fontWeight: FontWeight.w700,
                                              fontSize: 28, color: Colors.black, ),
                                          ),
                                        )
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
                          children:[
                            Container(
                              width: 226,
                              height: 111,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black, width: 3, ),
                                color: const Color(0xfff16363),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                                  SizedBox(
                                    width: 220,
                                    height: 111,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          onPressed: ()
                                          {
                                            _editCancel(context);
                                          },
                                          style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xfff16363)),
                                              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                                              fixedSize: const MaterialStatePropertyAll<Size>(Size(220.0, 111.0))),
                                          child: const Text(
                                            '편집 취소하기',
                                            style: TextStyle(fontFamily: 'Happiness-Sans', fontWeight: FontWeight.w700,
                                              fontSize: 28, color: Colors.black, ),
                                          ),
                                        )
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
                      left: 20,
                      bottom: 10,
                      child: SizedBox(
                        width: 400,
                        height: 100,
                        child: Row(
                          children:[
                            SizedBox(
                              child: TextButton(
                                onPressed: () async {
                                  _showMoveFirstPageDialog(context);
                                },
                                child: Image.asset('images/photodaehak_logo.png'),
                              ),
                        ),
                            SizedBox(
                              width: 220,
                              height: 40,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: TextButton(
                                  style: const ButtonStyle(fixedSize: MaterialStatePropertyAll<Size>(Size(220, 40))),
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
              ),
            ),
          ),
          Positioned(
            left: 240,
            top: 546,
            child: Container(
              width: 600,
              height: 900,
              color: const Color(0xffd9d9d9),
            ),
          ),
          Positioned(
            left: 100,
            top: 223,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 250,
            top: 223,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 400,
            top: 223,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 550,
            top: 223,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 700,
            top: 223,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 850,
            top: 223,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 100,
            top: 373,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 250,
            top: 373,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 400,
            top: 373,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 550,
            top: 373,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 700,
            top: 373,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
          Positioned(
            left: 850,
            top: 373,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1, ),
                color: const Color(0xffd9d9d9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
