// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Feedback_Model {
  String dpurl;
  String number;
  String name;
  String cnic;
  String date;
  String feedback;
  Feedback_Model({
    required this.dpurl,
    required this.number,
    required this.name,
    required this.cnic,
    required this.date,
    required this.feedback,
  });

  Feedback_Model copyWith({
    String? dpurl,
    String? number,
    String? name,
    String? cnic,
    String? date,
    String? feedback,
  }) {
    return Feedback_Model(
      dpurl: dpurl ?? this.dpurl,
      number: number ?? this.number,
      name: name ?? this.name,
      cnic: cnic ?? this.cnic,
      date: date ?? this.date,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dpurl': dpurl,
      'number': number,
      'name': name,
      'cnic': cnic,
      'date': date,
      'feedback': feedback,
    };
  }

  factory Feedback_Model.fromMap(Map<String, dynamic> map) {
    return Feedback_Model(
      dpurl: map['dpurl'] as String,
      number: map['number'] as String,
      name: map['name'] as String,
      cnic: map['cnic'] as String,
      date: map['date'] as String,
      feedback: map['feedback'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback_Model.fromJson(String source) =>
      Feedback_Model.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Feedback_Model(dpurl: $dpurl, number: $number, name: $name, cnic: $cnic, date: $date, feedback: $feedback)';
  }

  @override
  bool operator ==(covariant Feedback_Model other) {
    if (identical(this, other)) return true;

    return other.dpurl == dpurl &&
        other.number == number &&
        other.name == name &&
        other.cnic == cnic &&
        other.date == date &&
        other.feedback == feedback;
  }

  @override
  int get hashCode {
    return dpurl.hashCode ^
        number.hashCode ^
        name.hashCode ^
        cnic.hashCode ^
        date.hashCode ^
        feedback.hashCode;
  }
}
