

class User{

  int id;
  String? name, email;
  
  String? phone;
  

  User(this.id, this.name, this.email, this.phone,
      );

  static User fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());

    String? name = jsonObject['name'].toString();
    String? email = jsonObject['email'].toString();

    String? phone = jsonObject['mobile'].toString();


    return User(id, name, email, phone);
  }

  static List<User> getListFromJson(List<dynamic> jsonArray) {
    List<User> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(User.fromJson(jsonArray[i]));
    }
    return list;
  }





}