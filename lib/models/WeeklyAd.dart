


import 'package:america/utils/TextUtils.dart';

class WeeklyAd {
  int? id;
  String? photo;
 


  WeeklyAd(
      this.id ,this.photo, );

  static fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());


    String photo = TextUtils.getImageUrl(jsonObject['photo'].toString());

    return WeeklyAd(id,  photo, );
  }

  static List<WeeklyAd> getListFromJson(List<dynamic> jsonArray) {
    List<WeeklyAd> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(WeeklyAd.fromJson(jsonArray[i]));
    }
    return list;
  }


  @override
  String toString() {
    return 'WeeklyAd{id: $id, pdf: $photo, }';
  }
}
