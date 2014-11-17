part of randomhealth;

class Recipe{
  
  Recipe(Store store){
    var list = store.catergory['veg'].pick(2);
    querySelector('#breakfast .ingredients').innerHtml = toHtml(list);
    
    list = store.catergory['fruit'].pick(2);
    querySelector('#afternoon .ingredients').innerHtml = toHtml(list);
    
    list = ['meat','gravy','veg'].map((cat) => store.catergory[cat].pick(1).single).toList();
    querySelector('#dinner .ingredients').innerHtml = toHtml(list);
  }
  
  String toHtml(List<Ingredient> ingedience){
    return ingedience.map((i) => '<div class="${i.type}">${i.name} 1 av ${i.inStore}</div>').join('');
  }
}