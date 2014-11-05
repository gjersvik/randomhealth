part of randomhealth;



storeList(Firebase fire){
  var elem = querySelector('#store');
  fire.onValue.map((Event e) => e.snapshot.val()).listen((Map store){
    elem.children = store.keys.expand((category){
      var list = [new Element.tag('h1')..text = category];
      list.addAll(store[category].keys.map((food){
        var div = new Element.div();
        div.append(new Element.span()..text = store[category][food].toString());
        div.appendText(food);
        div.append(new ButtonElement()..text = '+');
        div.append(new ButtonElement()..text = '-');
        return div;
      }));
      return list;
    }).toList();
  });
}