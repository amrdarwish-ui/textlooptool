class Item {
  int _id;
  int _number;
  String _word;

  Item(dynamic obj) {
    _id = obj["id"];
    _number = obj["number"];
    _word = obj["word"];
  }
  Item.fromMap(Map<String, dynamic> data) {
    _id = data["id"];
    _number = data["number"];
    _word = data["word"];
  }
  Map<String, dynamic> toMap() => {'id': _id, 'number': _number, 'word': _word};

  int get id => _id;
  int get number => _number;
  String get word => _word;
}
