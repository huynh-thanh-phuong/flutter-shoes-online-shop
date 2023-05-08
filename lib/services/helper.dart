import 'package:flutter/services.dart' as the_bundle;
import 'package:flutter_online_shop/models/sneaker_model.dart';
//this class fetches data from the json file and return it to the app
class Helper{
  //List male
  Future<List<Sneakers>> getMaleSneaker()async{
    final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);

    return maleList;
  }

  //List female
  Future<List<Sneakers>> getFemaleSneaker()async{
    final data = await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final womenList = sneakersFromJson(data);

    return womenList;
  }
  //List kids
  Future<List<Sneakers>> getKidsSneaker()async{
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final kidsList = sneakersFromJson(data);

    return kidsList;
  }
  //single male
  Future<Sneakers> getMaleSneakerById(String id)async{
    final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneakers) => sneakers.id == id);
    return sneaker;
  }
  //single female
  Future<Sneakers> getFemaleSneakerById(String id)async{
    final data = await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final womenList = sneakersFromJson(data);
    final sneaker = womenList.firstWhere((sneakers) => sneakers.id == id);
    return sneaker;
  }

    //single kid
  Future<Sneakers> getKidSneakerById(String id)async{
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final kidsList = sneakersFromJson(data);
    final sneaker = kidsList.firstWhere((sneakers) => sneakers.id == id);
    return sneaker;
  }
}