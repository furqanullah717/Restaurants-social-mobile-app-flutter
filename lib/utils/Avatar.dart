import 'dart:math';

class Avatar {
  List<String> list = new List();

  Avatar() {
    list.add(
        "https://gravatar.com/avatar/8b0e22012d0805265973955760b64c99?s=400&d=robohash&r=x");
    list.add(
        "https://gravatar.com/avatar/76af697c27e6ac478cb96aec534edccc?s=400&d=robohash&r=x");
    list.add(
        "https://gravatar.com/avatar/088918a72a765da847b9a459b854b1ee?s=400&d=robohash&r=x");
    list.add(
        "https://gravatar.com/avatar/5ae8e673dde77d716ab00d346ddc3ce8?s=400&d=robohash&r=x");
    list.add(
        "https://gravatar.com/avatar/448e8be4742b12226043dbb2e2b8d1c4?s=400&d=robohash&r=x");
    list.add(
        "https://gravatar.com/avatar/18bab70d5f6a60db68f2e1b9791efacb?s=400&d=robohash&r=x");
    list.add(
        "https://gravatar.com/avatar/8c28c291d3f9eb0c399cdc603ce42833?s=400&d=robohash&r=x");
    list.add(
        "https://gravatar.com/avatar/eb725cd85d4b1b06246c3ee2457c21ab?s=400&d=robohash&r=x");
    list.add(
        "https://gravatar.com/avatar/79dab7b7bbb43530540e3b9edd188472?s=400&d=robohash&r=x");
    list.add(
        "https://gravatar.com/avatar/cc72bb5079948b0dc1e9847bbd66c313?s=400&d=robohash&r=x");
  }

  String getAvatar() {
    Random random = Random();
    var val = random.nextInt(list.length - 1);
    return list[val];
  }
}
