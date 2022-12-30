class AddressModel {
  final String localArea;
  final String state;
  final String pincode;
  final String city;
  final String district;

  final String id;

  AddressModel({
    required this.localArea,
    required this.district,
    required this.id,
    required this.state,
    required this.pincode,
    required this.city,
  });
  Map<String, dynamic> toJson() => {
        'district': district,
        'localarea': localArea,
        'city': city,
        'state': state,
        'pincode': pincode,
        'id': id,
      };

  static AddressModel fromJson(Map<String, dynamic> json) => AddressModel(
      district: json['district'],
      localArea: json['localarea'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      id: json['id']);
}
