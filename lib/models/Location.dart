


class Locations {
  int? id;
  String name;
  String lat;
  String lng;
  dynamic phone;

  Locations(
      this.id ,this.name, this.lat,this.lng,this.phone);

  static fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());

    String name = jsonObject['name'].toString();
    String lat = jsonObject['lat'].toString();
    String lng = jsonObject['lng'].toString();

     String phone = jsonObject['phone'].toString();


    return Locations(id,  name,  lat,lng,phone);
  }

  static List<Locations> getListFromJson(List<dynamic> jsonArray) {
    List<Locations> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Locations.fromJson(jsonArray[i]));
    }
    return list;
  }



}
