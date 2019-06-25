import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'appmenu.dart';
import 'slideshow.dart';
import 'dictionary.dart';
import 'fauna_meta_data.dart';

class SlideCordinator extends StatefulWidget {
  final BaseDictionary baseDictionary;
  List<FaunaMetaData> _animalList;
  FaunaMetaData _currentAnimal;
  SlideCordinator({this.baseDictionary}):super(){
    print(this.baseDictionary.getName());
    this.baseDictionary.getList().then((data){_animalList = data;  _currentAnimal = _animalList.first; print(_currentAnimal.name); });

  }
  @override
  _SlideCordinatorState createState() => _SlideCordinatorState();
}

class _SlideCordinatorState extends State<SlideCordinator> {

  int currentIndex = 1;
  static AudioPlayer audioPlayer = new AudioPlayer();
  static AudioCache audioCache = new AudioCache(fixedPlayer: audioPlayer);


  Future<void> play(url) async {
    audioCache.play(url);
  }

  Future<void> stop() async{
    var result = await audioPlayer.stop();
  }

  @override
  void initState()
  {
   //print('size${widget._animalList.length}');
   // _currentAnimal = widget._animalList[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget._currentAnimal != null){
      return MaterialApp(
        title: 'Jungle Book',
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Jungle Book'),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.mic), onPressed: (){})
            ],
          ),
          drawer: new AppMenu(),
          body: new GestureDetector(
            child: new SlideShow(animalPath: widget._currentAnimal.imageFilePath),
            onHorizontalDragEnd: (DragEndDetails details){
              stop();
              setState(() {
                currentIndex+=1;
                widget._currentAnimal = widget._animalList.elementAt(currentIndex);
              });
            },
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: (){
              play(widget.baseDictionary.getCryAudioFilePath(widget._currentAnimal.cryAudioFilePath));
            },
            child: new Icon(Icons.navigate_next),),
        ),
      );
    }
    else{
      return new Container();
      }

  }
}