class LocationModel {
  final String city;
  final String street;
  final String firstTurnOffStarts;
  final String firstTurnOffEnds;
  final String secondTurnOffStarts;
  final String secondTurnOffEnds;
  final DateTime date;

  // ignore: sort_constructors_first
  LocationModel(this.city, this.street, this.firstTurnOffStarts, this.firstTurnOffEnds, this.secondTurnOffStarts,
      this.secondTurnOffEnds, this.date);
}

