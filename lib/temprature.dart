class Temperature {
  final int current;
  final int min;
  final int max;

  Temperature({this.current, this.min, this.max});

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
        current: json['temp'], min: json['temp_min'], max: json['temp_max']);
  }
}