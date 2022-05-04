


class Bus{
  final String id;
  final String imageUrl;
  final String busRegistrationNumber;
  final int maxCapacity;

  Bus({
    required this.id,
    required this.imageUrl,
    required this.busRegistrationNumber,
    // required this.driver,
    // required this.departureTime,
    required this.maxCapacity,
    // required this.bookedSeats,
    // required this.pickup,
    // required this.dropOff,

});


  factory Bus.fromJson(Map<String,dynamic> map) {
    print(map["maxCapacity"]);
    return Bus(
      id: map["id"] ?? "",
      imageUrl:  map["imageUrl"] ?? "",
      busRegistrationNumber:  map["busRegistrationNumber"] ?? "",
      maxCapacity: int.parse(map["maxCapacity"].toString()) ,
    );
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "imageUrl" : imageUrl,
    "busRegistrationNumber" : busRegistrationNumber,
    "maxCapacity" : maxCapacity,
  };
}


