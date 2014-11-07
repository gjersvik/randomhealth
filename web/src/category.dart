part of randomhealth;

class Category{
  final Firebase fireStore;
  final Map<String,Ingredient> _ingredient = {};

  Category( DataSnapshot snapshot): fireStore = snapshot.ref(){
    fireStore.onChildAdded.listen((Event e) => _add(e.snapshot));
    fireStore.onChildRemoved.listen((Event e) => _remove(e.snapshot));
    fireStore.onChildMoved.listen((Event e) => _move(e.snapshot, e.prevChild));
  }
  
  UnmodifiableMapView<String,Category> get ingredient
    => new UnmodifiableMapView(_ingredient);
  
  List<Ingredient> pick(n){
    var validKeys = _ingredient.values.where((i) => i.inStore > 0).toList();
    validKeys.shuffle();
    return validKeys.take(n).toList();
  }
  
  _add(DataSnapshot data) => _ingredient[data.name] = new Ingredient(data);
  
  _remove(DataSnapshot data) => _ingredient.remove(data.name);
  
  _move(DataSnapshot data, String prev)
    => _ingredient[data.name]= _ingredient.remove(prev);
}