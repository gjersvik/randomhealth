import 'dart:html';
import 'package:firebase/firebase.dart';

void main() {
  var fire = new Firebase('popping-inferno-887.firebaseio.com/store/fruit');
  fire.onValue.listen((e) => print(pic3(e.snapshot.val())));
}

List pic3(Map data){
  var validKeys = data.keys.where((name) => data[name] > 0).toList();
  validKeys.shuffle();
  return validKeys.take(3).toList();
}