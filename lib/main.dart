import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'dart:async';

void main(){
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
    return MaterialApp(
      title: 'Radio Uno',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Radio Uno'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.green,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Icon(
                  Icons.radio,
                  size: 250,

                )
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: FractionalOffset.center,
                  child: FlatButton(
                    child: !isPlaying ?
                    Icon(
                      Icons.pause_circle_outline,
                      size: 100,
                      color: Colors.white,
                    )
                    :
                    Icon(
                      Icons.play_circle_outline,
                      size: 100,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      setState(() {
                        FlutterRadio.playOrPause(url: url);
                        isPlaying = !isPlaying;
                        isVisible = !isVisible;
                      });
                    },
                  )
                ),
              ),
              SizedBox(
                height: 50,
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
