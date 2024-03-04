import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/routes/routes.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'screen/home_screen.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TABLET = size.width > 600;
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: Text(
            "Korea Made 💕",
            style: TextStyle(fontSize: TABLET ? 20 : 14),
            textAlign: TextAlign.center,
          ),
          bodyWidget: Text(
            'အလှတပ် မျက်ကပ်မှန် ၊ ပါဝါ မျက်ကပ်မှန်များကို ဝယ်ယူရရှိနိုင်ပါပြီ',
            style: TextStyle(fontSize: TABLET ? 20 : 14),
            textAlign: TextAlign.center,
          ),
          image: buildImage('assets/logo.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          titleWidget: Text(
            'ထူးခြားလှပတဲ့ မျက်ကပ်မှန်ဒီဇိုင်း\n'
            'အစုံအလင်ရရှိနိုင်တဲ့ 𝐇𝐌𝐌 𝐂𝐨𝐧𝐭𝐚𝐜𝐭𝐥𝐞𝐧𝐬',
            style: TextStyle(fontSize: TABLET ? 20 : 14),
            textAlign: TextAlign.center,
          ),
          bodyWidget: TABLET
              ? Text(
                  'လူအများကြား ထင်ပေါ်စေဖို့ အဝတ်အစားလှလှလေး​တွေလဲ\n မလိုအပ်သလို ရုပ်ရည်အရမ်းချောမောလှပနေဖို့ မလိုပါဘူး🙅🏻‍♀\n\n'
                  'တောက်ပလင်းလက်ပြီး ညှို့အားကောင်းတဲ့မျက်ဝန်းတစ်စုံသာ\nလိုအပ်ပါတယ် သဲလေးတို့ရေ 👁',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                )
              : Text(
                  'လူအများကြား ထင်ပေါ်စေဖို့ အဝတ်အစားလှလှလေး​တွေလဲ မလိုအပ်သလို ရုပ်ရည်အရမ်းချောမောလှပနေဖို့ မလိုပါဘူး🙅🏻‍♀\n\n'
                  'တောက်ပလင်းလက်ပြီး ညှို့အားကောင်းတဲ့မျက်ဝန်းတစ်စုံသာလိုအပ်ပါတယ် သဲလေးတို့ရေ 👁',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
          footer: ButtonWidget(
            text: "LET'S GET STARTED",
            onClicked: () => goToHome(context),
          ),
          image: buildImage('assets/logo.png'),
          decoration: getPageDecoration(),
        ),
      ],
      done: Text("", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: Text(
        'SKIP',
        style: TextStyle(fontSize: 16, color: Colors.orange),
      ),
      onSkip: () => goToHome(context),
      next: Icon(Icons.forward_outlined, size: 30, color: Colors.orange),
      dotsDecorator: getDotDecoration(),
      onChange: (index) => print('Page $index selected'),
      globalBackgroundColor: Colors.white,
      skipFlex: 0,
      nextFlex: 0,
      isProgressTap: true,
      isProgress: true,
      showNextButton: true,
      // freeze: true,
      animationDuration: 100,
    );
  }

  void goToHome(context) => Get.offNamed(redirectRoute());

  Widget buildImage(String path) => Center(
          child: Image.asset(
        path,
        width: 250,
        height: 300,
      ));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.indigo,
        activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 18),
        titlePadding: EdgeInsets.only(top: 0),
        descriptionPadding: EdgeInsets.only(top: 20).copyWith(bottom: 0),
        // imagePadding: EdgeInsets.only(top: 100),
        pageColor: Colors.white,
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
}
