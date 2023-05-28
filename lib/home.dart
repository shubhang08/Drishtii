import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

class Home extends StatefulWidget {
  final List<CameraDescription> cameras;

  Home(this.cameras);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  late List<dynamic> _recognitions=[];
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
  }

  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = (await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
        ))!;
        break;

      case mobilenet:
        res = (await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt"))!;
        break;

      case posenet:
        res = (await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite"))!;
        break;

      default:
        res = (await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt"))!;
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Detection'),
        centerTitle: true,
        backgroundColor: Color(0xFF3C3E52),
      ),
      backgroundColor: Color(0xBE3C3E52),
      body:

      _model == ""
          ? Center(
        heightFactor: double.infinity,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(vertical: 15),
            //   child: FloatingActionButton(
            //     onPressed: onSelect(ssd),
            //     // color: Color(0xFF04A5ED),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(
            //           vertical: 14, horizontal: 24),
            //       child: Text("Start Detecting",
            //           style: TextStyle(color: Colors.white,fontSize: 20)),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(vertical: 15),
            //   child: FloatingActionButton(
            //     onPressed: onSelect(yolo),
            //     // color: Color(0xFF04A5ED),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(
            //           vertical: 14, horizontal: 24),
            //       child: Text("Start Detecting",
            //           style: TextStyle(color: Colors.white,fontSize: 20)),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(vertical: 15),
            //   child: FloatingActionButton(
            //     onPressed: onSelect(mobilenet),
            //     // color: Color(0xFF04A5ED),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(
            //           vertical: 14, horizontal: 24),
            //       child: Text("Start Detecting",
            //           style: TextStyle(color: Colors.white,fontSize: 20)),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(vertical: 15),
            //   child: FloatingActionButton(
            //     onPressed: onSelect(posenet),
            //     // color: Color(0xFF04A5ED),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(
            //           vertical: 14, horizontal: 24),
            //       child: Text("Start Detecting",
            //           style: TextStyle(color: Colors.white,fontSize: 20)),
            //     ),
            //   ),
            // ),
            ElevatedButton(
              child: const Text(ssd),
              onPressed: () => onSelect(ssd),
            ),
            ElevatedButton(
              child: const Text(yolo),
              onPressed: () => onSelect(yolo),
            ),
            ElevatedButton(
              child: const Text(mobilenet),
              onPressed: () => onSelect(mobilenet),
            ),
            ElevatedButton(
              child: const Text(posenet),
              onPressed: () => onSelect(posenet),
            ),
          ],
        ),
      )
          : Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          BndBox(
              _recognitions == null ? [] : _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.height,
              screen.width,
              _model),
        ],
      ),
    );
  }
}