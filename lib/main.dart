import 'dart:async';

import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isvisible = true;
  bool isnotvisible = false;
  bool startispressed = true;
  bool stoptispressed = true;
  bool resettispressed = true;
  String time = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void startTimer()
  {
    Timer(dur, keeprunning);
  }

  void keeprunning()
  {
    if(swatch.isRunning){
      startTimer();
    }
    setState(() {
      time = swatch.elapsed.inHours.toString().padLeft(2,'0') + ":" +(swatch.elapsed.inMinutes%60).toString().padLeft(2,'0') + ":" + (swatch.elapsed.inSeconds%60).toString().padLeft(2,'0');
    });
  }


  void startwatch()
  {
    setState(() {
      isvisible = !isvisible;
      isnotvisible = !isnotvisible;
      stoptispressed = false;
      startispressed = false;
    });
    swatch.start();
    startTimer();
  }

  void stopwatch()
  {
    setState(() {
      stoptispressed = true;
      resettispressed = false;
      isvisible = !isvisible;
      isnotvisible = !isnotvisible;
    });
    swatch.stop();
  }

  void resetwatch()
  {
    setState(() {
      startispressed = true;
      resettispressed = true;
    });
    swatch.reset();
    time = "00:00:00";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
              child: Image.asset("assets/bg.jpeg",
                height: double.infinity,
                fit: BoxFit.cover,
              )
          ),
          Column(
            children: [
              SizedBox(height: 100,),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 50,right: 50,top: 50),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(width: 4,color: Colors.red.shade400,
                    )
                ),
                child: Text(time,style: TextStyle(
                    fontSize: 50,
                    color: Colors.red
                ),),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: isvisible,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: InkWell(
                      onTap: startispressed ? startwatch: null,
                      child: Container(
                        height:40,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            border: Border.all(color: Colors.red.shade200)
                        ),
                        child: Text("Start",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isnotvisible,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: InkWell(
                      onTap: stoptispressed ? null : stopwatch,
                      child: Container(
                        height:40,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            border: Border.all(color: Colors.red.shade400)
                        ),
                        child: Text("Stop",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: resettispressed ? null : resetwatch,
                    child: Container(
                      height:40,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          border: Border.all(color: Colors.red.shade400)
                      ),
                      child: Text("Reset",
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}


