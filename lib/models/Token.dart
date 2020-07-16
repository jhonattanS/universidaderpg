import 'package:aqueduct/aqueduct.dart';

class Token extends Serializable {
  Token({this.expires, this.token});

  int expires;
  String token;

  @override
  Map<String, dynamic> asMap() => {"expires": expires, "token": token};

  @override
  void readFromMap(Map<String, dynamic> map) {
    expires = map['expires'] as int;
    token = map['token'] as String;
  }
}
