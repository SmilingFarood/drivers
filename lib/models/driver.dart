class Driver {
  String? name;
  String? phone;
  String? email;
  String? code;
  String? address;
  String? city;
  String? state;
  String? userId;
  String? driverLicense;
  String? companyId;
  DateTime? dateAdded;
  String? companyName;
  int? assigned;
  bool? vehicleAssigned;
  List<String?>? roles;
  String? walletId;
  String? walletUnit;
  String? walletFriendlyName;
  List? vehicles;
  String? id;
  Driver({
    this.name,
    this.phone,
    this.email,
    this.code,
    this.address,
    this.city,
    this.state,
    this.userId,
    this.driverLicense,
    this.companyId,
    this.dateAdded,
    this.companyName,
    this.assigned,
    this.vehicleAssigned,
    this.roles,
    this.walletId,
    this.walletUnit,
    this.walletFriendlyName,
    this.vehicles,
    this.id,
  });
  @override
  String toString() {
    return """\n
    Name: $name,
    Phone: $phone,
    Email: $email, 
    Code: $code,
    Address: $address,
    City: $city,
    State: $state, 
    User ID: $userId,
    Drivers License: $driverLicense,
    Company ID: $companyId
    """;
  }
}

class AddDriverReq {
  String companyId;
  String userId;
  String name;
  String phone;
  String email;
  String address;
  String city;
  String state;
  List<String> roles;
  String token;
  AddDriverReq({
    required this.companyId,
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.roles,
    required this.token,
  });
  @override
  String toString() {
    return """\n
    Company ID: $companyId,
    User ID: $userId,
    Name: $name,
    Phone: $phone, 
    Email: $email,
    Address: $address,
    City: $city,
    State: $state,
    Roles: $roles,
    Token: $token,
    """;
  }
}

class EditDriverReq {
  String companyId;
  String userId;
  String name;
  String phone;
  String email;
  String address;
  String city;
  String state;
  String token;
  String driverId;
  List<String> roles;
  EditDriverReq({
    required this.companyId,
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.roles,
    required this.token,
    required this.driverId,
  });
  @override
  String toString() {
    return """\n
    Company ID: $companyId,
    User ID: $userId,
    Name: $name,
    Phone: $phone,
    Email: $email, 
    Address: $address,
    City: $city,
    State: $state,
    Roles: $roles,
    Driver ID: $driverId,
    Token: $token,
    """;
  }
}
