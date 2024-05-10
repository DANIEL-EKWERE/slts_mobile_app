// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
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
    final String? username;
    final bool? accountNonExpired;
    final bool? accountNonLocked;
    final bool? credentialsNonExpired;

    UserModel({
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

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    final List<Permission>? permissions;

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
        permissions: json["permissions"] == null ? [] : List<Permission>.from(json["permissions"]!.map((x) => Permission.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tenantId": tenantId,
        "name": name,
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x.toJson())),
    };
}

class Permission {
    final dynamic id;
    final dynamic name;

    Permission({
        this.id,
        this.name,
    });

    factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
