

import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Application'),
        centerTitle: true,
        backgroundColor: Color(0xFF3C3E52),
      ),
      backgroundColor: Color(0x993C3E52),
      body: Center(
        child: Column(
          children: <Widget>[
        Container(
        height: MediaQuery.of(context).size.height*0.20,
        child: Center(
          child: Image(image: AssetImage('assets/logoo.png'),),
        ),
      ),
      Center(
        child: Text(
          "DRISHTI",
          style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 25),
        child: Column(
          children: <Widget>[
            Text(
              "An Application for visually impaired people",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 15,
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                  "This is a Flutter app that uses Firebase ML vision, Tensorflow Lite, and in-built speech recognition and text-to-speech capabilities to act like a third eye for blind people. It uses SSD MobileNetV2 to perform object detection. The blind user can authenticate with fingerprint, issue voice commands , object detection, trqce GPS location, and use voice assistant to perform any task. The app responds appropriately via voice output for every command issued. The blind user can use this app to detect objects in front of him/her, get voice output of text within objects, and also send his/her GPS location for tracing purposes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, height: 1.5,fontSize: 16)),
            ),],),
      )
          ],
        ),
      ),
    );
  }
}
