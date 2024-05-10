// To parse this JSON data, do
//
//     final violationsModel = violationsModelFromJson(jsonString);

import 'dart:convert';

ViolationsModel violationsModelFromJson(String str) => ViolationsModel.fromJson(json.decode(str));

String violationsModelToJson(ViolationsModel data) => json.encode(data.toJson());

class ViolationsModel {
    final int? totalItems;
    final List<Violation>? violations;
    final int? totalPages;
    final int? currentPage;

    ViolationsModel({
        this.totalItems,
        this.violations,
        this.totalPages,
        this.currentPage,
    });

    factory ViolationsModel.fromJson(Map<String, dynamic> json) => ViolationsModel(
        totalItems: json["totalItems"],
        violations: json["violations"] == null ? [] : List<Violation>.from(json["violations"]!.map((x) => Violation.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
    );

    Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "violations": violations == null ? [] : List<dynamic>.from(violations!.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
    };
}

class Violation {
    final dynamic id;
    final dynamic tenantId;
    final dynamic chargeId;
    final dynamic vin;
    final dynamic violationLocation;
    final dynamic violationType;
    final dynamic violationCode;
    final dynamic violation;
    final dynamic fine;
    final dynamic plateNumber;
    final dynamic vehicleType;
    final dynamic vehicleMake;
    final dynamic vehicleYear;
    final dynamic firstName;
    final dynamic lastName;
    final dynamic gender;
    final Creator? creator;
    final dynamic approvalStatus;
    final dynamic approver;
    final List<Evidence>? evidences;
    final Payment? payment;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Violation({
        this.id,
        this.tenantId,
        this.chargeId,
        this.vin,
        this.violationLocation,
        this.violationType,
        this.violationCode,
        this.violation,
        this.fine,
        this.plateNumber,
        this.vehicleType,
        this.vehicleMake,
        this.vehicleYear,
        this.firstName,
        this.lastName,
        this.gender,
        this.creator,
        this.approvalStatus,
        this.approver,
        this.evidences,
        this.payment,
        this.createdAt,
        this.updatedAt,
    });

    factory Violation.fromJson(Map<String, dynamic> json) => Violation(
        id: json["id"],
        tenantId: json["tenantId"],
        chargeId: json["chargeId"],
        vin: json["vin"],
        violationLocation: json["violationLocation"],
        violationType: json["violationType"],
        violationCode: json["violationCode"],
        violation: json["violation"],
        fine: json["fine"],
        plateNumber: json["plateNumber"],
        vehicleType: json["vehicleType"],
        vehicleMake: json["vehicleMake"],
        vehicleYear: json["vehicleYear"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
        approvalStatus: json["approvalStatus"],
        approver: json["approver"],
        evidences: json["evidences"] == null ? [] : List<Evidence>.from(json["evidences"]!.map((x) => Evidence.fromJson(x))),
        payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tenantId": tenantId,
        "chargeId": chargeId,
        "vin": vin,
        "violationLocation": violationLocation,
        "violationType": violationType,
        "violationCode": violationCode,
        "violation": violation,
        "fine": fine,
        "plateNumber": plateNumber,
        "vehicleType": vehicleType,
        "vehicleMake": vehicleMake,
        "vehicleYear": vehicleYear,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "creator": creator?.toJson(),
        "approvalStatus": approvalStatus,
        "approver": approver,
        "evidences": evidences == null ? [] : List<dynamic>.from(evidences!.map((x) => x.toJson())),
        "payment": payment?.toJson(),
        "createdAt": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updatedAt": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
    };
}

class Creator {
    final dynamic id;
    final dynamic firstname;
    final dynamic lastname;
    final dynamic email;
    final dynamic password;
    final dynamic activationStatus;
    final dynamic accountStatus;
    final Tenant? tenant;
    final Role? role;
    final dynamic picPath;
    final dynamic phoneNumber;
    final bool? twoFaEnabled;
    final dynamic secret;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final bool? enabled;
    final dynamic authorities;
    final dynamic username;
    final bool? accountNonExpired;
    final bool? accountNonLocked;
    final bool? credentialsNonExpired;

    Creator({
        this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.password,
        this.activationStatus,
        this.accountStatus,
        this.tenant,
        this.role,
        this.picPath,
        this.phoneNumber,
        this.twoFaEnabled,
        this.secret,
        this.createdAt,
        this.updatedAt,
        this.enabled,
        this.authorities,
        this.username,
        this.accountNonExpired,
        this.accountNonLocked,
        this.credentialsNonExpired,
    });

    factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        activationStatus: json["activation_status"],
        accountStatus: json["account_status"],
        tenant: json["tenant"] == null ? null : Tenant.fromJson(json["tenant"]),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        picPath: json["picPath"],
        phoneNumber: json["phoneNumber"],
        twoFaEnabled: json["twoFAEnabled"],
        secret: json["secret"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        enabled: json["enabled"],
        authorities: json["authorities"],
        username: json["username"],
        accountNonExpired: json["accountNonExpired"],
        accountNonLocked: json["accountNonLocked"],
        credentialsNonExpired: json["credentialsNonExpired"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "activation_status": activationStatus,
        "account_status": accountStatus,
        "tenant": tenant?.toJson(),
        "role": role?.toJson(),
        "picPath": picPath,
        "phoneNumber": phoneNumber,
        "twoFAEnabled": twoFaEnabled,
        "secret": secret,
        "createdAt": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updatedAt": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
        "enabled": enabled,
        "authorities": authorities,
        "username": username,
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
    };
}

class Role {
    final dynamic id;
    final dynamic tenantId;
    final dynamic name;
    final List<dynamic>? permissions;

    Role({
        this.id,
        this.tenantId,
        this.name,
        this.permissions,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        tenantId: json["tenantId"],
        name: json["name"],
        permissions: json["permissions"] == null ? [] : List<dynamic>.from(json["permissions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tenantId": tenantId,
        "name": name,
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
    };
}

class Tenant {
    final dynamic id;
    final dynamic name;
    final dynamic address;
    final dynamic amount;
    final dynamic activationStatus;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Tenant({
        this.id,
        this.name,
        this.address,
        this.amount,
        this.activationStatus,
        this.createdAt,
        this.updatedAt,
    });

    factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        amount: json["amount"],
        activationStatus: json["activation_status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "amount": amount,
        "activation_status": activationStatus,
        "createdAt": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updatedAt": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
    };
}

class Evidence {
    final dynamic id;
    final dynamic filePath;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Evidence({
        this.id,
        this.filePath,
        this.createdAt,
        this.updatedAt,
    });

    factory Evidence.fromJson(Map<String, dynamic> json) => Evidence(
        id: json["id"],
        filePath: json["filePath"] ?? 'http://139.162.207.19:8080/api/v1/violation_evidences/00a8d7d7c11be1090663c0e30d63e631.jpg',
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "filePath": filePath,
        "createdAt": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updatedAt": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
    };
}

class Payment {
    final dynamic id;
    final dynamic tenantId;
    final dynamic trxRef;
    final dynamic amount;
    final dynamic paymentGateway;
    final dynamic paymentMethod;
    final dynamic status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Payment({
        this.id,
        this.tenantId,
        this.trxRef,
        this.amount,
        this.paymentGateway,
        this.paymentMethod,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        tenantId: json["tenantId"],
        trxRef: json["trxRef"],
        amount: json["amount"],
        paymentGateway: json["paymentGateway"],
        paymentMethod: json["paymentMethod"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tenantId": tenantId,
        "trxRef": trxRef,
        "amount": amount,
        "paymentGateway": paymentGateway,
        "paymentMethod": paymentMethod,
        "status": status,
        "createdAt": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updatedAt": "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
    };
}
