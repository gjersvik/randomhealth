part of randomhealth;

class Recipe{
  Store _store;
  Storage _storage;
  
  Recipe(this._store){
    _storage = window.localStorage;
    
    var breakfastElem = querySelector('#breakfast');
    breakfastElem.querySelector('.ingredients').children = toHtml(getBreakfast());
    breakfastElem.querySelector('.remake').onClick.listen((_) =>
        breakfastElem.querySelector('.ingredients').children = toHtml(newBreakfast()));
    breakfastElem.querySelector('.use').onClick.listen((_) =>
        getBreakfast().forEach((i) => i.dec()));
    
    var dinnerElem = querySelector('#dinner');
    dinnerElem.querySelector('.ingredients').children = toHtml(getDinner());
    dinnerElem.querySelector('.remake').onClick.listen((_) =>
        dinnerElem.querySelector('.ingredients').children = toHtml(newDinner()));
    dinnerElem.querySelector('.use').onClick.listen((_) =>
        getDinner().forEach((i) => i.dec()));
    
    var afternoonElem = querySelector('#afternoon');
    afternoonElem.querySelector('.ingredients').children = toHtml(getAfternoon());
    afternoonElem.querySelector('.remake').onClick.listen((_) =>
        afternoonElem.querySelector('.ingredients').children = toHtml(newAfternoon()));
    afternoonElem.querySelector('.use').onClick.listen((_) =>
        getAfternoon().forEach((i) => i.dec()));
  }
  
  List<Element> toHtml(List<Ingredient> ingedience){
    return ingedience.map((i){
      var div = new Element.div();
      div.className = i.type;
      div.text = '${i.name} 1 av ${i.inStore}';
      i.update.listen((_) => div.text = '${i.name} 1 av ${i.inStore}');
      return div;
    }).toList();
  }
  
  List<Ingredient> getBreakfast(){
    if(_hasResepe('breakfast')){
      return _deserialize(_storage['breakfast']);
    }
    return newBreakfast();
  }
  
  List<Ingredient> newBreakfast(){
    var resepe = _store.catergory['veg'].pick(2);
    resepe.addAll(_store.catergory['gravy'].pick(1));
    _storage['breakfast'] = _serialize(resepe);
    return resepe;
  }
  
  List<Ingredient> getDinner(){
    if(_hasResepe('dinner')){
      return _deserialize(_storage['dinner']);
    }
    return newDinner();
  }
  
  List<Ingredient> newDinner(){
    var resepe = _store.catergory['meat'].pick(1);
    resepe.addAll(_store.catergory['veg'].pick(1));
    _storage['dinner'] = _serialize(resepe);
    return resepe;
  }
  
  List<Ingredient> getAfternoon(){
    if(_hasResepe('afternoon')){
      return _deserialize(_storage['afternoon']);
    }
    return newAfternoon();
  }
  
  List<Ingredient> newAfternoon(){
    var resepe = _store.catergory['fruit'].pick(2);
    _storage['afternoon'] = _serialize(resepe);
    return resepe;
  }
  
  String _today(){
    var now = new DateTime.now();
    return '${now.day}.${now.month}.${now.year}';
  }
  
  bool _hasResepe(String resepeName){
    return _storage.containsKey(resepeName)
        && _storage[resepeName].startsWith(_today());
  }
  
  String _serialize(List<Ingredient> resepe){
    return '${_today()}|' + resepe.expand((ing) => [ing.type,ing.name]).join('|');
  }
  
  List<Ingredient> _deserialize(String resepeSerialized){
    var tokens = resepeSerialized.split('|');
    var resepe = [];
    for(var i = 1; i < tokens.length - 1; i += 2){
      resepe.add(_store.catergory[tokens[i]].ingredient[tokens[i+1]]);
    }
    return resepe;
  }
}