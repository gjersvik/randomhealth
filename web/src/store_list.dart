part of randomhealth;



storeList(Firebase fire){
  var elem = querySelector('#store');
  fire.onValue.map((Event e) => e.snapshot.val()).listen((Map store){
    elem.children = store.keys.expand((category){
      var list = [new Element.tag('h1')..text = category];
      list.addAll(store[category].keys.map((food){
        return new Element.div()..text = food;
      }));
      return list;
    }).toList();
  });
}