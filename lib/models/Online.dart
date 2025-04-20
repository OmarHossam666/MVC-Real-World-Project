

class Online {
  int? id;
  String name;
  String link;


  Online(
      this.id ,this.link,this.name);

  static fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());

    String link = jsonObject['link'].toString();

    String name = jsonObject['name'].toString();

    return Online(id, link, name,);
  }

  static List<Online> getListFromJson(List<dynamic> jsonArray) {
    List<Online> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Online.fromJson(jsonArray[i]));
    }
    return list;
  }


  @override
  String toString() {
    return 'Online{id: $id, link: $link,name : $name}';
  }
}
