import 'package:tonganhymn/Models/model.dart';

class HymnItem extends Model {
  static String table = 'items';

  int? id;
  String? number;
  String? lyrics;

  HymnItem({id, number, lyrics});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'number': number, 'lyrics': lyrics};

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static HymnItem fromMap(Map<String, dynamic> map) {
    return HymnItem(
      id: map['id'],
      number: map['number'],
      lyrics: map['lyrics'],
    );
  }
}
