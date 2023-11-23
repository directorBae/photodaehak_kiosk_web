import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key});

  @override
  FinalPageState createState() => FinalPageState();
}

class FinalPageState extends State<FinalPage> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: 1080,
          height: 1920,
          color: Colors.white,
          child: Stack(
            children:[
              Positioned(
                left: 2,
                top: 1565,
                child: SizedBox(
                  width: 800,
                  height: 100,
                  child: StreamBuilder(
                    stream: timer(),
                    builder: (context, snapshot) {
                      return Text(
                        "${snapshot.data} 초 후 첫 화면으로 돌아갑니다.",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontFamily: 'Happiness-sans',
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 559,
                    height: 140,
                    color: const Color(0xfffff44f),
                  ),
                ),
              ),
              Positioned(
                left: 105,
                top: 49,
                child: SizedBox(
                  width: 871,
                  height: 393,
                  child: Image.asset('images/photounivlogo_withText.jpg'),
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
              const Positioned(
                left: 25,
                top: 925,
                child: SizedBox(
                  width: 630,
                  height: 104,
                  child: Text(
                    "이용해주셔서 감사합니다!",
                    style: TextStyle(
                      fontFamily: 'Happiness-sans',
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 55,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }

  Stream<int> timer() async* {
    int remainTime = 20;

    while (remainTime > 0) {
      await Future.delayed(const Duration(milliseconds: 1000));
      remainTime--;
      yield remainTime;
    }
    if (remainTime == 0){
      Get.offAllNamed('/first');
    }
  }
}
