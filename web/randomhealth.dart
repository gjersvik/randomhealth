library randomhealth;

import 'dart:async';
import 'dart:collection';
import 'dart:html' hide Event;

import 'package:firebase/firebase.dart';
import 'package:polymer/polymer.dart';

import 'package:paper_elements/paper_tabs.dart';
import 'package:paper_elements/paper_button.dart';
import 'package:paper_elements/paper_shadow.dart';
import 'package:core_elements/core_pages.dart';


part 'src/category.dart';
part 'src/ingredient.dart';
part 'src/recipe.dart';
part 'src/store.dart';
part 'src/store_list.dart';

void main() {
  var onReady = new Store('popping-inferno-887.firebaseio.com/store').onReady;
  initPolymer().run((){
    PaperTabs tabs = querySelector('paper-tabs');
    CorePages pages = querySelector('core-pages');
    tabs.on['core-select'].listen((CustomEvent test){
      pages.selected = tabs.selected;
    });
    
    onReady.then((Store store){
      var recipe = new Recipe(store);
      var storelist = new StoreList(store);
    });
  });
}