extension TimeFormat on int {
  String toDeliveryTime() {
    if (this < 60) {
      return '${this}mins';
    } else {
      int hours = this ~/ 60;
      int minutes = this % 60;
      if (hours > 0 && minutes > 0) {
        return '$hours${hours > 1 ? 'hrs' : 'hr'} ${minutes}mins';
      } else if (hours > 0) {
        return '$hours${hours > 1 ? 'hrs' : 'hr'}';
      } else {
        return '${minutes}mins';
      }
    }
  }
}
