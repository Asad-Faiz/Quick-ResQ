// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmergencyRequestModel {
  double lan;
  double lon;
  String emergencyurl;
  String dpurl;
  String number;
  String name;
  String cnic;
  String date;
  String EmergencyType;
  String fullAddress;
  String Status;
  EmergencyRequestModel({
    required this.lan,
    required this.lon,
    required this.emergencyurl,
    required this.dpurl,
    required this.number,
    required this.name,
    required this.cnic,
    required this.date,
    required this.EmergencyType,
    required this.fullAddress,
    required this.Status,
  });

  EmergencyRequestModel copyWith({
    double? lan,
    double? lon,
    String? emergencyurl,
    String? dpurl,
    String? number,
    String? name,
    String? cnic,
    String? date,
    String? EmergencyType,
    String? fullAddress,
    String? Status,
  }) {
    return EmergencyRequestModel(
      lan: lan ?? this.lan,
      lon: lon ?? this.lon,
      emergencyurl: emergencyurl ?? this.emergencyurl,
      dpurl: dpurl ?? this.dpurl,
      number: number ?? this.number,
      name: name ?? this.name,
      cnic: cnic ?? this.cnic,
      date: date ?? this.date,
      EmergencyType: EmergencyType ?? this.EmergencyType,
      fullAddress: fullAddress ?? this.fullAddress,
      Status: Status ?? this.Status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lan': lan,
      'lon': lon,
      'emergencyurl': emergencyurl,
      'dpurl': dpurl,
      'number': number,
      'name': name,
      'cnic': cnic,
      'date': date,
      'EmergencyType': EmergencyType,
      'fullAddress': fullAddress,
      'Status': Status,
    };
  }

  factory EmergencyRequestModel.fromMap(Map<String, dynamic> map) {
    return EmergencyRequestModel(
      lan: map['lan'] as double,
      lon: map['lon'] as double,
      emergencyurl: map['emergencyurl'] as String,
      dpurl: map['dpurl'] as String,
      number: map['number'] as String,
      name: map['name'] as String,
      cnic: map['cnic'] as String,
      date: map['date'] as String,
      EmergencyType: map['EmergencyType'] as String,
      fullAddress: map['fullAddress'] as String,
      Status: map['Status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmergencyRequestModel.fromJson(String source) => EmergencyRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmergencyRequestModel(lan: $lan, lon: $lon, emergencyurl: $emergencyurl, dpurl: $dpurl, number: $number, name: $name, cnic: $cnic, date: $date, EmergencyType: $EmergencyType, fullAddress: $fullAddress, Status: $Status)';
  }

  @override
  bool operator ==(covariant EmergencyRequestModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.lan == lan &&
      other.lon == lon &&
      other.emergencyurl == emergencyurl &&
      other.dpurl == dpurl &&
      other.number == number &&
      other.name == name &&
      other.cnic == cnic &&
      other.date == date &&
      other.EmergencyType == EmergencyType &&
      other.fullAddress == fullAddress &&
      other.Status == Status;
  }

  @override
  int get hashCode {
    return lan.hashCode ^
      lon.hashCode ^
      emergencyurl.hashCode ^
      dpurl.hashCode ^
      number.hashCode ^
      name.hashCode ^
      cnic.hashCode ^
      date.hashCode ^
      EmergencyType.hashCode ^
      fullAddress.hashCode ^
      Status.hashCode;
  }
}
