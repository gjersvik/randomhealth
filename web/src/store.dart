part of randomhealth;

class Store{
  final Firebase fireStore;
  
  final Map<String,Category> _catergory = {};
  
  Store(String url): fireStore = new Firebase(url){
    fireStore.onChildAdded.listen((Event e) => _add(e.snapshot));
    fireStore.onChildRemoved.listen((Event e) => _remove(e.snapshot));
    fireStore.onChildMoved.listen((Event e) => _move(e.snapshot, e.prevChild));
  }
  
  UnmodifiableMapView<String,Category> get catergory
    => new UnmodifiableMapView(_catergory);
  
  _add(DataSnapshot data) => _catergory[data.name] = new Category(data);
  
  _remove(DataSnapshot data) => _catergory.remove(data.name);
  
  _move(DataSnapshot data, String prev)
    => _catergory[data.name]= _catergory.remove(prev);
}