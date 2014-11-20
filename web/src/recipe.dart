part of randomhealth;

class Recipe{
  Store _store;
  
  Recipe(this._store){
    querySelector('#breakfast .ingredients').innerHtml = toHtml(getBreakfast());
    querySelector('#dinner .ingredients').innerHtml = toHtml(getDinner());
    querySelector('#afternoon .ingredients').innerHtml = toHtml(getAfternoon());
  }
  
  String toHtml(List<Ingredient> ingedience){
    return ingedience.map((i) => '<div class="${i.type}">${i.name} 1 av ${i.inStore}</div>').join('');
  }
  
  List<Ingredient> getBreakfast(){
    var list = _store.catergory['veg'].pick(2);
    list.addAll(_store.catergory['gravy'].pick(1));
    return list;
  }
  
  List<Ingredient> getDinner(){
    var list = _store.catergory['meat'].pick(1);
    list.addAll(_store.catergory['veg'].pick(1));
    return list;
  }
  
  List<Ingredient> getAfternoon(){
    return _store.catergory['fruit'].pick(2);
  }
}