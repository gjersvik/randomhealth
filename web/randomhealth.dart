import 'dart:html';

import 'package:firebase/firebase.dart';
import 'package:polymer/polymer.dart';

import 'package:paper_elements/paper_tabs.dart';
import 'package:core_elements/core_pages.dart';

void main() {
  var fire = new Firebase('popping-inferno-887.firebaseio.com/store');
  fire.onValue.first.then((e){
    Map data = e.snapshot.val();
    
    var list = pick3(data['veg']);
    var map = new Map.fromIterables(list, list.map((e) => data['veg'][e]));
    querySelector('#breakfast').innerHtml = toHtml(map);
    
    list = pick3(data['fruit']);
    map = new Map.fromIterables(list, list.map((e) => data['fruit'][e]));
    querySelector('#afternoon').innerHtml = toHtml(map);
    
    list = [
              pick1(data['meat']),
              pick1(data['gravy']),
              pick1(data['veg'])
            ];
    var list2 = [
              data['meat'][list[0]],
              data['gravy'][list[1]],
              data['veg'][list[2]]
            ];
    
    querySelector('#dinner').innerHtml = toHtml(new Map.fromIterables(list,list2));
  });
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

List pick3(Map data){
  var validKeys = data.keys.where((name) => data[name] > 0).toList();
  validKeys.shuffle();
  return validKeys.take(3).toList();
}

dynamic pick1(Map data){
  var validKeys = data.keys.where((name) => data[name] > 0).toList();
  validKeys.shuffle();
  return validKeys.first;
}

String toHtml(Map data){
  return data.keys.map((n) => "$n 1 av ${data[n]}").join('<br>');
}