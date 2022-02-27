class Contact {
  List<Map<String, String>> list = List<Map<String, String>>();

  bool add(String name, int uid) {
    list.forEach((element) {
      if (element[name] != "") {
        return false;
      }
    });
    list.add({
      "name": name,
      "uid": uid.toString(),
    });
  }
}
