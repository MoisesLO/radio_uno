import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const url = "http://listen.shoutcast.com/radiounotacna";
  bool isPlaying = true;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    audioStart();
    playingStatus();
    FlutterRadio.play(url: url);
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-5852042324891789~4137851755");
    // myBanner..load()..show();
    myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
    return MaterialApp(
      title: 'Radio Uno',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.green,
        backgroundColor: Colors.green,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.accent, //  <-- this auto selects the right color
          )
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.radio),
          title: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.radio), Text('  Radio Uno Tacna - Peru')],
          )),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 8,
                  child: Image(
                    image: AssetImage('assets/img/radio_uno.jpg'),
                  )
              ),
              Expanded(
                flex: 2,
                child: Align(
                    alignment: FractionalOffset.center,
                    child: FlatButton(
                      child: !isPlaying
                          ? Icon(
                              Icons.pause_circle_outline,
                              size: 110,
                            )
                          : Icon(
                              Icons.play_circle_outline,
                              size: 110,
                            ),
                      onPressed: () {
                        setState(() {
                          FlutterRadio.playOrPause(url: url);
                          isPlaying = !isPlaying;
                          isVisible = !isVisible;
                        });
                      },
                    )),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }

  // IconButton(
  // icon: isPlaying ?
  // Icon(
  // Icons.pause_circle_outline,
  // size: 80,
  // color: Colors.white,
  // )
  //     :
  // Icon(
  // Icons.play_circle_outline,
  // size: 80,
  // color: Colors.white,
  // ),
  // onPressed: (){
  // setState(() {
  // FlutterRadio.playOrPause(url: url);
  // isPlaying = !isPlaying;
  // isVisible = !isVisible;
  // });
  // },
  // ),

  Future playingStatus() async {
    bool isP = await FlutterRadio.isPlaying();
    setState(() {
      isPlaying = isP;
    });
  }
}


MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['php', 'laravel'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male,
  testDevices: <String>[],
);

// BannerAd myBanner = BannerAd(
//   adUnitId: "ca-app-pub-5852042324891789/4041151393",
//   size: AdSize.smartBanner,
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("BannerAd event is $event");
//   },
// );

InterstitialAd myInterstitial = InterstitialAd(
  adUnitId: 'ca-app-pub-5852042324891789/7316189605',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);