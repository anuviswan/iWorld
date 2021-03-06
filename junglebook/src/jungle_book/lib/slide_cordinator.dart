import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'slideshow.dart';
import 'dictionary.dart';
import 'fauna_meta_data.dart';
import 'hint.dart';



class SlideCordinator extends StatefulWidget {
  final BaseDictionary baseDictionary;
  List<FaunaMetaData> _animalList;
  FaunaMetaData _currentAnimal;
  SlideCordinator({this.baseDictionary}):super(){
    print(this.baseDictionary.getName());
  }

  Future<String> LoadFaunaCollection() async{

    if(_animalList==null) {
      _animalList = await this.baseDictionary.getList();
    }

    _currentAnimal = _animalList.last;
    return _currentAnimal.name;
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
    super.initState();
  }



  Widget getOnSuccessWidget(BuildContext context, AsyncSnapshot snapshot){
    return MaterialApp(
      title: 'Jungle Book',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Jungle Book'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.mic), onPressed: (){
              play(widget._currentAnimal.pronunciationFilePath);
            }),
            new Hint.loadFauna(faunaName: widget._currentAnimal.name,interestingFact: widget._currentAnimal.interestingFact,),
          ],
        ),

        body: new GestureDetector(
          child: new SlideShow(animalPath: widget._currentAnimal.imageFilePath),
          onHorizontalDragEnd: (DragEndDetails details){
            play(widget._currentAnimal.cryAudioFilePath);

          },
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: (){
            print('number of elemetns left ${widget._animalList.length}');
            if(widget._animalList.length == 1){
              Navigator.pop(context);
            }
            else {
              stop();
              setState(() {
                widget._animalList.removeLast();
                widget._currentAnimal = widget._animalList.last;
              });
            }
          },
          child: new Icon(Icons.arrow_forward),),
      ),
    );
  }


  Widget getOnError(BuildContext context, AsyncSnapshot snapshot){
    return new Text('Error Loading');
  }

  Widget getOnLoading(BuildContext context, AsyncSnapshot snapshot){
    return new CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: widget.LoadFaunaCollection(), // a Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none: return new Text('Press button to start');
          case ConnectionState.waiting: return getOnLoading(context,snapshot);
        default:
            return getOnSuccessWidget(context,snapshot);
        }
      },
    );

  }
}

