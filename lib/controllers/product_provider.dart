
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/models/sneaker_model.dart';
import 'package:flutter_online_shop/services/helper.dart';
import 'package:hive/hive.dart';

class ProductNotifier extends ChangeNotifier{
  int _activePage = 0;
  List<dynamic> _shoesSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;

  set activePage(int newIndex){
    _activePage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoesSizes => _shoesSizes;

  set shoesSizes(List<dynamic>newSize){
    _shoesSizes = newSize;
    notifyListeners();
  }

  //function is called with an index, it will toggle the section
  //of that item and leave selection of all other items as they were.
  //This will alow for mutiple items to be selectedat once.
 void toggleCheck(int index) {
    for (int i = 0; i < _shoesSizes.length; i++) {
      if (i == index) {
        _shoesSizes[i]['isSelected'] = !_shoesSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  //add List size
  List<String> get sizes => _sizes;

  set sizes (List<String> newSizes){
    _sizes = newSizes;
    notifyListeners();
  }

  //home page
  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  

  void getMale() {
    male = Helper().getMaleSneaker();
  }

  void getFemale() {
    female = Helper().getFemaleSneaker();
  }

  void getKids() {
    kids = Helper().getKidsSneaker();
  }
  //product page
    final _cartBox = Hive.box('cart_box');

  
  Future<void> createCart(Map<String,dynamic> newCart)async{
    await _cartBox.add(newCart);
  }

  late Future<Sneakers> sneaker;
  void getShoes(String category, String id) {
    if (category == "Men's Running") {
      sneaker = Helper().getMaleSneakerById(id);
    } else if (category == "Women's Running") {
      sneaker = Helper().getFemaleSneakerById(id);
    } else {
      sneaker = Helper().getKidSneakerById(id);
    }
  }
}