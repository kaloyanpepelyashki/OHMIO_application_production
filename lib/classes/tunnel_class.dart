class Tunnel {
  late String macAddress;
  late String deviceName;

  Tunnel({required this.macAddress, required this.deviceName});

  void getMACAddress(String macAddress) {
    this.macAddress = macAddress;
  }

  void nameDevice(String deviceName) {
    this.deviceName = deviceName;
  }
}
