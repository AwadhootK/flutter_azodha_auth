// To parse this JSON data, do
//
//     final Welkinusermodel = WelkinusermodelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
part 'membershipmodel.g.dart';

@JsonSerializable(explicitToJson: true)
class Welkinusermodel {
  Welkinusermodel({
    required this.id,
    this.firstName,
    this.preferredName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.sourceHealthId,
    this.accountDeactivated,
    this.messagingDeactivated,
    this.medicalProvider,
    this.dietician,
    this.waitlistUser,
    this.stripeCustomer,
    this.smsPreference,
  });

  String id;
  String? firstName;
  String? preferredName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? sourceHealthId;
  bool? accountDeactivated;
  bool? messagingDeactivated;
  dynamic medicalProvider;
  dynamic dietician;
  WaitlistUser? waitlistUser;
  StripeCustomer? stripeCustomer;
  SmsPreference? smsPreference;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Welkinusermodel.fromJson(Map<String, dynamic> json) =>
      _$WelkinusermodelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WelkinusermodelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SmsPreference {
  SmsPreference({
    required this.sourceHealthId,
    required this.sms,
  });

  String sourceHealthId;
  bool sms;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory SmsPreference.fromJson(Map<String, dynamic> json) =>
      _$SmsPreferenceFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SmsPreferenceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StripeCustomer {
  StripeCustomer({
    required this.id,
    this.subscriptionId,
    this.product,
    this.tier,
    this.subscriptionStart,
    this.subscriptionEnd,
    this.subscriptionStatus,
  });

  String id;
  String? subscriptionId;
  Product? product;
  String? tier;
  DateTime? subscriptionStart;
  DateTime? subscriptionEnd;
  String? subscriptionStatus;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory StripeCustomer.fromJson(Map<String, dynamic> json) =>
      _$StripeCustomerFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StripeCustomerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Product {
  Product({
    required this.id,
    this.type,
    this.tagId,
    this.acListId,
  });

  String id;
  String? type;
  String? tagId;
  String? acListId;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WaitlistUser {
  WaitlistUser({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.gender,
    this.zipCode,
    this.phoneNumber,
    this.isDirectSignUp,
    this.source,
    this.medium,
    this.campaign,
    this.activeCampaignContactId,
    this.isCommunityMember,
    this.insuranceProvider,
    this.state,
    this.reason,
    this.insuranceState,
    this.eligibleProducts,
    this.selectedProduct,
    this.howDidYouHear,
  });

  String id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? dob;
  String? gender;
  String? zipCode;
  String? phoneNumber;
  bool? isDirectSignUp;
  dynamic source;
  dynamic medium;
  dynamic campaign;
  String? activeCampaignContactId;
  bool? isCommunityMember;
  dynamic insuranceProvider;
  State? state;
  Reason? reason;
  dynamic insuranceState;
  List<Product>? eligibleProducts;
  Product? selectedProduct;
  List<dynamic>? howDidYouHear;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory WaitlistUser.fromJson(Map<String, dynamic> json) =>
      _$WaitlistUserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WaitlistUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Reason {
  Reason({
    required this.value,
  });

  String value;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Reason.fromJson(Map<String, dynamic> json) => _$ReasonFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReasonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class State {
  State({
    required this.code,
    required this.fullName,
    required this.eligible,
    required this.eligibleNutrition,
  });

  String code;
  String fullName;
  bool eligible;
  bool eligibleNutrition;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory State.fromJson(Map<String, dynamic> json) => _$StateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StateToJson(this);
}
