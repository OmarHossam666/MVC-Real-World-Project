


import 'dart:developer';

import 'package:america/utils/TextUtils.dart';

class Setting {
  int? id;
  String? table_name;
  String? photo;
  String? color;
  String? name; // Optional field
  String? link;

  Setting(
  {this.id ,this.table_name, this.photo,this.color,   this.name,
this.link,});

  static fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());

    String tableName = jsonObject['table_name'].toString();
    String name = jsonObject['name'].toString();
    String link = jsonObject['link'].toString();
    log("link : $link");
    String color = jsonObject['color'].toString();

    String photo = TextUtils.getImageUrl(jsonObject['photo'].toString());

    return Setting(id:id, table_name: tableName, photo: photo,color :color,name:name,link:link);
  }

  static List<Setting> getListFromJson(List<dynamic> jsonArray) {
    List<Setting> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Setting.fromJson(jsonArray[i]));
    }
  
    return list;
  }


  @override
  String toString() {
    return 'Setting{id: $id, table_name: $table_name, photo: $photo,color:$color , link:$link}';
  }
}
