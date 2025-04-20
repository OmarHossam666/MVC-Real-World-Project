



class AppValidations {
  static bool emailRegExp(email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  static emailValidation(String email) => email.isEmpty
      ? "Please Enter your Email"
      : !emailRegExp(email)
          ? "Please Enter Your Email"
          : null;
  static nameValidation(String name) => name.isEmpty
      ? ("Please Enter Your Name")
  
              : null;
  
 



  static generalValidation(String name) =>
      name.isEmpty ? ("Please Enter This Field") : null;

  static password(String password) => password.isEmpty
      ? "Please Enter Password"

          : null;
  static confirmPasswordvalidation(String password, String confirmPassword) =>
      confirmPassword.isEmpty
          ? "Please Enter Password"
          : password != confirmPassword
              ? "Passwords are not the same"
              : null;

}
