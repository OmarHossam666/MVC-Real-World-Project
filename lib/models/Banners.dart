
import 'package:america/utils/TextUtils.dart';


class Banners {
  int? id;
  String photo;
 

  Banners(
      this.id , this.photo,);

  static fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());

    String photo = TextUtils.getImageUrl(jsonObject['photo'].toString());

    return Banners(id,photo,);
  }

  static List<Banners> getListFromJson(List<dynamic> jsonArray) {
    List<Banners> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Banners.fromJson(jsonArray[i]));
    }
    return list;
  }


  @override
  String toString() {
    return 'Banners{id: $id, photo: $photo,}';
  }
}
