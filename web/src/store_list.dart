part of randomhealth;

class StoreList{
  final Firebase _fire;
  Element _elem;
  
  StoreList(this._fire){
    _elem = querySelector('#store');
    _fire.onValue.map((Event e) => e.snapshot.val()).listen(update);
  }
  
  update(Map store){
    _elem.children = store.keys.expand((category){
      var list = [new Element.tag('h1')..text = category];
      list.addAll(store[category].keys.map((food){
        var div = new Element.div();
        div.append(new Element.span()..text = store[category][food].toString());
        div.appendText(food);
        div.append(new ButtonElement()
          ..text = '+'
          ..onClick.listen((_) => add('$category/$food')));
        div.append(new ButtonElement()
          ..text = '-'
          ..onClick.listen((_) => sub('$category/$food')));
        return div;
      }));
      return list;
    }).toList();
  }
  
  add(String path){
    var item = _fire.child(path);
    item.once('value').then((DataSnapshot data){
      item.set(data.val() + 1);
    });
  }

  sub(String path){
    var item = _fire.child(path);
    item.once('value').then((DataSnapshot data){
      if(data.val() > 0)
        item.set(data.val() - 1);
    });
  }
}