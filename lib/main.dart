import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:my_app/Authentication.dart';
import 'package:my_app/about_app.dart';
import 'package:my_app/developer_info.dart';
import 'package:my_app/gps.dart';
import 'package:my_app/home.dart';
import 'package:my_app/speech_to_text.dart';
import 'package:my_app/tts.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras=[];

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drishti',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FingerprintApp(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState(){

    AlanVoice.addButton(
        "ff50709cf76da188105fdc2bfd9a66952e956eca572e1d8b807a3e2338fdd0dc/stage",
    buttonAlign:AlanVoice.BUTTON_ALIGN_LEFT,

    );
    AlanVoice.onCommand.add((command)=>handleCommand(command.data));

    /// ... or init Alan Button with project key and additional params
    // var params = jsonEncode({"uuid":"111-222-333-444"});
    // AlanVoice.addButton("8e0b083e795c924d64635bba9c3571f42e956eca572e1d8b807a3e2338fdd0dc/stage", authJson: params);

    /// Set log level - "all", "none"
    AlanVoice.setLogLevel("none");

    /// Add button state handler
    AlanVoice.onButtonState.add((state) {
      debugPrint("got new button state ${state.name}");
    });

    /// Add command handler
    // AlanVoice.onCommand.add((command) {
    //   debugPrint("got new command ${command.toString()}");
    // });

    /// Add event handler
    AlanVoice.onEvent.add((event) {
      debugPrint("got new event ${event.data.toString()}");
    });

    /// Activate Alan Button
    // ignore: unused_element
    void _activate() {
      AlanVoice.activate();
    }

    /// Deactivate Alan Button
    // ignore: unused_element
    void _deactivate() {
      AlanVoice.deactivate();
    }

    /// Send any text via Alan Button
    // ignore: unused_element
    void _sendText() {
      /// Provide text as string param
      AlanVoice.sendText("Hello from Alan");
    }

    /// Play any text via Alan Button
    // ignore: unused_element
    void _playText() {
      /// Provide text as string param
      AlanVoice.playText("Hello from Alan");
    }

    /// Execute any command locally (and handle it with onCommand callback)
    // ignore: unused_element
    // void _playCommand() {
    //   /// Provide any params with json
    //   var command = jsonEncode({"command": "commandName"});
    //   AlanVoice.playCommand(command);
    // }

    /// Call project API from Alan Studio script
    // ignore: unused_element
    // void _callProjectApi() {
    //   /// Provide any params with json
    //   var params = jsonEncode({"apiParams": "paramsValue"});
    //   AlanVoice.callProjectApi("projectAPI", params);
    // }

    /// Set visual state in Alan Studio script
    // ignore: unused_element
    // void _setVisualState() {
    //   /// Provide any params with json
    //   var visualState = jsonEncode({"visualState": "stateValue"});
    //   AlanVoice.setVisualState(visualState);
    // }
  }
  void handleCommand(Map<String, dynamic> command){
    switch(command["command"]){
      case "text": _texttS();
      break;
      case "location": _gps();
      break;
      case "Speech":_speechS();
      break;
      case "Object":_object();
      break;

      default: debugPrint("unknown command");
    }
  }
  void _texttS(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => TTS()));
  }
  void _speechS(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SpeechScreen()));
  }
  void _gps(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => GPS()));
  }
  void _object(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(cameras)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Color(0xFF3C3E52),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFC3C3E52),
        child: ListView(
          children: <Widget>[
            ListTile(

            ),Divider(),
            ListTile(
              title: Text('For Object Dectection Say "Object Detection"',style: TextStyle(color: Colors.white)),
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Home(cameras))),
            ),
            Divider(),
            ListTile(
              title: Text('For Text To Speech Say "Text To Speech"',style: TextStyle(color: Colors.white),),
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>TTS())),
            ),Divider(),
            ListTile(
              title: Text('For Speech to text Say "Speech To Text"',style: TextStyle(color: Colors.white)),
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>SpeechScreen())),
            ),Divider(),
            ListTile(
              title: Text('For Your Location Say "Location"',style: TextStyle(color: Colors.white)),
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>GPS())),
            ),Divider(),
            ListTile(
              title: Text('About Application',style: TextStyle(color: Colors.white)),
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>AboutApp())),

            ),Divider(),
            ListTile(
              title: Text('About Developers',style: TextStyle(color: Colors.white)),
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>DeveloperInfoPage())),

            ),
          ],
        ),
      ),
      backgroundColor: Color(0xBE3C3E52),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              'Please Give Your Command By Tapping The Button Below',
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
