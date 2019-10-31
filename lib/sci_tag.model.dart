class SCITag {
  final String id;
  final double temperature;
  final double batteryVoltage;
  final double humidity;
  final int rssi;
  final int rxTime;
  final int sequenceNumber;
  SCITag(this.id, this.temperature, this.batteryVoltage, this.humidity, this.rssi, this.rxTime, this.sequenceNumber);
  factory SCITag.fromJSON(Map<String, dynamic> jsonTag) {
    return SCITag(
      jsonTag['id'],
      jsonTag['temperature'],
      jsonTag['batteryVoltage'],
      jsonTag['humidity'],
      jsonTag['rssi'],
      jsonTag['rxTime'],
      jsonTag['sequenceNumber'],
    );
  }
}