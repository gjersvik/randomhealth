part of randomhealth;

class Ingredient{
  Stream<Ingredient> update;
  
  DataSnapshot _snapshot;
  Category _category;
  
  Ingredient(this._snapshot, this._category){
    update = fireStore.onValue.map((Event event){
      _snapshot = event.snapshot;
      return this;
    }).asBroadcastStream();
        
    // Make shure that the map is runned.
    update.listen((_) => null);
  }
  
  Firebase get fireStore => _snapshot.ref();
  String get type => _category.name;
  String get name => _snapshot.name;
  int get inStore => _snapshot.val();
  
  inc(){
    fireStore.set(inStore + 1);
  }
  
  dec(){
    if(inStore > 0){
      fireStore.set(inStore - 1);
    }
  }
}