abstract class HouseState {}

class HouseLoading extends HouseState {}

class HouseLoaded extends HouseState {
  final List<Map<String, dynamic>> houses;
  HouseLoaded(this.houses);
}

class HouseError extends HouseState {
  final String message;
  HouseError(this.message);
}
