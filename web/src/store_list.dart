part of randomhealth;

class StoreList{
  final Store _store;
  Element _elem;
  
  StoreList(this._store){
    _elem = querySelector('#store');
    
    _elem.children = _store.catergory.values.expand((category){
      var list = [new Element.tag('h1')..text = category.name];
      list.addAll(category.ingredient.values.map(addIngredient));
      return list;
    }).toList();
  }
  
  Element addIngredient(Ingredient food){
    var div = new Element.div();
    var inStore = new Element.span()..text = food.inStore.toString();
    
    food.update.listen((f) => inStore.text = f.inStore.toString());
    
    div.append(inStore);
    div.appendText(food.name);
    div.append(new ButtonElement()
      ..text = '+'
      ..onClick.listen((_) => food.inc()));
    div.append(new ButtonElement()
      ..text = '-'
      ..onClick.listen((_) => food.dec()));
    return div;
  }
}