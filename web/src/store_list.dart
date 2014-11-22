part of randomhealth;

class StoreList{
  final Store _store;
  Element _elem;
  
  StoreList(this._store){
    _elem = querySelector('#store');
    
    _elem.children = _store.catergory.values.map((category){
      var cat = new Element.div();
      cat.classes.add('category');
      cat.classes.add(category.name);
      cat.append(new Element.tag('h1')..text = category.name);
      cat.children.addAll(category.ingredient.values.map(addIngredient));
      cat.append(new PaperShadow()..attributes['z'] = '1');
      return cat;
    }).toList();
  }
  
  Element addIngredient(Ingredient food){
    var div = new Element.div();
    div.classes.add('line');
    div.attributes['layout'] = '';
    div.attributes['horizontal'] = '';
    
    var inStore = new Element.div()..text = food.inStore.toString();
    inStore.classes.add('instore');
    food.update.listen((f) => inStore.text = f.inStore.toString());
    div.append(inStore);
    
    div.append(new Element.span()
      ..classes.add('name')
      ..attributes['flex'] = ''
      ..text = food.name);
    div.append(new PaperButton()
      ..attributes['raised'] = ''
      ..text = '+'
      ..onClick.listen((_) => food.inc()));
    div.append(new PaperButton()
      ..attributes['raised'] = ''
      ..text = '-'
      ..onClick.listen((_) => food.dec()));
    return div;
  }
}