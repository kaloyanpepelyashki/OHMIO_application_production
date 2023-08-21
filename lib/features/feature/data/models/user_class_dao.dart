import '../../domain/entities/user_class.dart';

class UserProfileDAO extends User_Profile {
  UserProfileDAO({
    required super.userId,
    required super.email,
    required super.username,
    required super.firstName,
    required super.lastName,
    required super.tunnelDevice,
    required super.tunnelMACAddress,
    required super.tunnelState,
  });

  factory UserProfileDAO.fromJSON(Map<String, dynamic> map){
    return UserProfileDAO(
      userId: map['userId'] ?? "",
      email: map['email'] ?? "",
      username: map['username'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      tunnelDevice: map['tunnelDevice'] ?? "",
      tunnelMACAddress: map['tunnelMACAddress'] ?? "",
      tunnelState: map['tunnelState'] ?? ""
    );
  }
}
