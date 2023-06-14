// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class myUser {
  String name;
  String number;
  String cnic;
  String imageurl;
  myUser({
    required this.name,
    required this.number,
    required this.cnic,
    required this.imageurl,
  });

  myUser copyWith({
    String? name,
    String? number,
    String? cnic,
    String? imageurl,
  }) {
    return myUser(
      name: name ?? this.name,
      number: number ?? this.number,
      cnic: cnic ?? this.cnic,
      imageurl: imageurl ?? this.imageurl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'number': number,
      'cnic': cnic,
      'imageurl': imageurl,
    };
  }

  factory myUser.fromMap(Map<String, dynamic> map) {
    return myUser(
      name: map['name'] as String,
      number: map['number'] as String,
      cnic: map['cnic'] as String,
      imageurl: map['imageurl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory myUser.fromJson(String source) =>
      myUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'myUser(name: $name, number: $number, cnic: $cnic, imageurl: $imageurl)';
  }

  @override
  bool operator ==(covariant myUser other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.number == number &&
        other.cnic == cnic &&
        other.imageurl == imageurl;
  }

  @override
  int get hashCode {
    return name.hashCode ^ number.hashCode ^ cnic.hashCode ^ imageurl.hashCode;
  }
}
