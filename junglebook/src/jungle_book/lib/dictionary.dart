import 'birds_collection_local.dart';
import 'fauna_meta_data.dart';

abstract class BaseDictionary{
  String getName();
  String getImageFilePath(String key);
  String getCryAudioFilePath(String key);
  String getPronunciationAudioFilePath(String key);
  Future<List<FaunaMetaData>> getList();
}

class BirdsLocalDictionary extends BaseDictionary{
  BirdsLocalDictionary():super();

  @override
  getName () => 'birds';

  @override
  getImageFilePath (String key)=> 'images/birds/$key.jpg';

  @override
  getCryAudioFilePath(String key)=> '$key.mp3';

  @override
  getPronunciationAudioFilePath(String key)=> '';

  @override
  getList() async{
    var collection = new BirdsLocalCollection();
    var _birds = await collection.GetList();

    _birds.shuffle();
    return _birds;
  }


}



