part of randomhealth;

class Ingredient{
  final type;
  final String name;
  int inStore = 0;
  
  Stream<Ingredient> changes;
  
  Firebase _fire;
  
  Ingredient(this.type, this.name, Firebase store, [this.inStore = 0]){
    _fire = store.child('$type/$name');
    changes = _fire.onValue.map((Event event){
      inStore = event.snapshot.val();
      return this;
    }).asBroadcastStream();
    
    // Make shure that the map is runned.
    changes.listen((_) => null);
  }
  
  inc(){
    _fire.set(inStore + 1);
  }
  
  dec(){
    if(inStore > 0){
      _fire.set(inStore - 1);
    }
  }
}