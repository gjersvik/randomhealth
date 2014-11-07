library randomhealth;

import 'dart:async';
import 'dart:collection';
import 'dart:html' hide Event;

import 'package:firebase/firebase.dart';
import 'package:polymer/polymer.dart';

import 'package:paper_elements/paper_tabs.dart';
import 'package:core_elements/core_pages.dart';

part 'src/category.dart';
part 'src/ingredient.dart';
part 'src/store.dart';
part 'src/store_list.dart';

void main() {
  var store = new Store('popping-inferno-887.firebaseio.com/store');
  store.fireStore.onValue.first.then((_){
    print(store.catergory);
    
    var list = store.catergory['veg'].pick(2);
    querySelector('#breakfast').innerHtml = toHtml(list);
    
    list = store.catergory['fruit'].pick(2);
    querySelector('#afternoon').innerHtml = toHtml(list);
    
    list = ['meat','gravy','veg'].map((cat) => store.catergory[cat].pick(1).single).toList();
    querySelector('#dinner').innerHtml = toHtml(list);
  });
  
  var storelist = new StoreList(store.fireStore);
  
  initPolymer().run((){
    PaperTabs tabs = querySelector('paper-tabs');
    CorePages pages = querySelector('core-pages');
    print(tabs.runtimeType);
    tabs.on['core-select'].listen((CustomEvent test){
      print(tabs.selected);
      pages.selected = tabs.selected;
    });
  });
}

String toHtml(List<Ingredient> ingedience){
  return ingedience.map((i) => "${i.name} 1 av ${i.inStore}").join('<br>');
}