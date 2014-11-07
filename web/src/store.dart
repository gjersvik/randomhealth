part of randomhealth;

class Store{
  final Firebase fireStore;
  final Map<String,Category> _catergory = {};
  
  Future<Store> onReady;
  
  
  Store(String url): fireStore = new Firebase(url){
    onReady = fireStore.once('value')
        .then((DataSnapshot s) => s.forEach(_add))
        .then((_) => this);
    
    fireStore.onChildAdded.listen((Event e) => _add(e.snapshot));
    fireStore.onChildRemoved.listen((Event e) => _remove(e.snapshot));
    fireStore.onChildMoved.listen((Event e) => _move(e.snapshot, e.prevChild));
  }
  
  UnmodifiableMapView<String,Category> get catergory
    => new UnmodifiableMapView(_catergory);
  
  _add(DataSnapshot data){
    if(!_catergory.containsKey(data.name)){
      _catergory[data.name] = new Category(data);
    }
  }
  
  _remove(DataSnapshot data) => _catergory.remove(data.name);
  
  _move(DataSnapshot data, String prev)
    => _catergory[data.name]= _catergory.remove(prev);
}