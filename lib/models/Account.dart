

class Account{

  int? id;
  String? name, email, token,phone;

  Account(this.id,this.name, this.email, this.token,this.phone );

  Account.empty() {
    name = "";
    email = "";
    token = "";
    phone = "";
  }





}