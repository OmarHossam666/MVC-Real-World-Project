


import 'package:america/utils/TextUtils.dart';

class Social {
  int? id;
  String name;
  String photo;
  String link;

  Social(
      this.id ,this.name, this.photo,this.link ,);

  static fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());

    String name = jsonObject['name'].toString();

    String photo = TextUtils.getImageUrl(jsonObject['photo'].toString());

    String link = jsonObject['link'].toString();


    return Social(id,  name,  photo,link,);
  }

  static List<Social> getListFromJson(List<dynamic> jsonArray) {
    List<Social> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Social.fromJson(jsonArray[i]));
    }
    return list;
  }


  @override
  String toString() {
    return 'Social{id: $id, name: $name, photo: $photo,link:$link,}';
  }
}
