part of randomhealth;

class Recipe{
  
  Recipe(Store store){
    var list = store.catergory['veg'].pick(2);
    querySelector('#breakfast').innerHtml = toHtml(list);
    
    list = store.catergory['fruit'].pick(2);
    querySelector('#afternoon').innerHtml = toHtml(list);
    
    list = ['meat','gravy','veg'].map((cat) => store.catergory[cat].pick(1).single).toList();
    querySelector('#dinner').innerHtml = toHtml(list);
  }
  
  String toHtml(List<Ingredient> ingedience){
    return ingedience.map((i) => "${i.name} 1 av ${i.inStore}").join('<br>');
  }
}