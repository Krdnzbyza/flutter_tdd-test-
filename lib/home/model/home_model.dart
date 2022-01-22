import 'package:vexana/vexana.dart';

class TestRestModel extends INetworkModel<TestRestModel> {
  int? id;
  String? name;
  String? username;
  String? email;
  String? expiryTime;

  bool isExpiry() {
    if (expiryTime == null) return false;
    final currentDate = DateTime.parse(expiryTime!);
    return DateTime.now().isAfter(currentDate);
  }

  TestRestModel({this.id, this.name, this.username, this.email});

  @override
  TestRestModel fromJson(Map<String, dynamic> json) {
    return TestRestModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['expiryTime'] = expiryTime;

    return data;
  }

  TestRestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    expiryTime = json['expiryTime'];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TestRestModel &&
        other.id == id &&
        other.name == name &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ username.hashCode ^ email.hashCode ^ expiryTime.hashCode;
  }
}
