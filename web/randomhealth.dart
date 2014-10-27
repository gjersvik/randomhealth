import 'dart:html';
import 'package:firebase/firebase.dart';

void main() {
  var fire = new Firebase('popping-inferno-887.firebaseio.com/store/fruit');
  fire.onValue.listen((e) => print(e.snapshot.val()));
}
