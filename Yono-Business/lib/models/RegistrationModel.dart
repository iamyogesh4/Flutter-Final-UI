class RegistrationModel {
  String name = '';

  String email = '';

  String username = '';

  String password = '';

  String address = '';

  String mobileNo = '';

  set setName(String pname) {
    name = pname;
  }

  String get getName {
    return name;
  }

  set setEmail(String pemail) {
    email = pemail;
  }

  String get getEmail {
    return email;
  }

  set setUsername(String pusername) {
    username = pusername;
  }

  String get getUsername {
    return username;
  }

  set setPassword(String password1) {
    password = password1;
  }

  String get getPassword {
    return password;
  }

  set setAddress(String paddress) {
    address = paddress;
  }

  String get getAddress {
    return address;
  }

  set setMobileno(String pmobileNo) {
    mobileNo = pmobileNo;
  }

  String get getMobileno {
    return mobileNo;
  }
}
