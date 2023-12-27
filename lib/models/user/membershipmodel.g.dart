// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membershipmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Welkinusermodel _$WelkinusermodelFromJson(Map<String, dynamic> json) =>
    Welkinusermodel(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      preferredName: json['preferredName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      sourceHealthId: json['sourceHealthId'] as String?,
      accountDeactivated: json['accountDeactivated'] as bool?,
      messagingDeactivated: json['messagingDeactivated'] as bool?,
      medicalProvider: json['medicalProvider'],
      dietician: json['dietician'],
      waitlistUser: json['waitlistUser'] == null
          ? null
          : WaitlistUser.fromJson(json['waitlistUser'] as Map<String, dynamic>),
      stripeCustomer: json['stripeCustomer'] == null
          ? null
          : StripeCustomer.fromJson(
              json['stripeCustomer'] as Map<String, dynamic>),
      smsPreference: json['smsPreference'] == null
          ? null
          : SmsPreference.fromJson(
              json['smsPreference'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WelkinusermodelToJson(Welkinusermodel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'preferredName': instance.preferredName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'sourceHealthId': instance.sourceHealthId,
      'accountDeactivated': instance.accountDeactivated,
      'messagingDeactivated': instance.messagingDeactivated,
      'medicalProvider': instance.medicalProvider,
      'dietician': instance.dietician,
      'waitlistUser': instance.waitlistUser?.toJson(),
      'stripeCustomer': instance.stripeCustomer?.toJson(),
      'smsPreference': instance.smsPreference?.toJson(),
    };

SmsPreference _$SmsPreferenceFromJson(Map<String, dynamic> json) =>
    SmsPreference(
      sourceHealthId: json['sourceHealthId'] as String,
      sms: json['sms'] as bool,
    );

Map<String, dynamic> _$SmsPreferenceToJson(SmsPreference instance) =>
    <String, dynamic>{
      'sourceHealthId': instance.sourceHealthId,
      'sms': instance.sms,
    };

StripeCustomer _$StripeCustomerFromJson(Map<String, dynamic> json) =>
    StripeCustomer(
      id: json['id'] as String,
      subscriptionId: json['subscriptionId'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      tier: json['tier'] as String?,
      subscriptionStart: json['subscriptionStart'] == null
          ? null
          : DateTime.parse(json['subscriptionStart'] as String),
      subscriptionEnd: json['subscriptionEnd'] == null
          ? null
          : DateTime.parse(json['subscriptionEnd'] as String),
      subscriptionStatus: json['subscriptionStatus'] as String?,
    );

Map<String, dynamic> _$StripeCustomerToJson(StripeCustomer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subscriptionId': instance.subscriptionId,
      'product': instance.product?.toJson(),
      'tier': instance.tier,
      'subscriptionStart': instance.subscriptionStart?.toIso8601String(),
      'subscriptionEnd': instance.subscriptionEnd?.toIso8601String(),
      'subscriptionStatus': instance.subscriptionStatus,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      type: json['type'] as String?,
      tagId: json['tagId'] as String?,
      acListId: json['acListId'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'tagId': instance.tagId,
      'acListId': instance.acListId,
    };

WaitlistUser _$WaitlistUserFromJson(Map<String, dynamic> json) => WaitlistUser(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      gender: json['gender'] as String?,
      zipCode: json['zipCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isDirectSignUp: json['isDirectSignUp'] as bool?,
      source: json['source'],
      medium: json['medium'],
      campaign: json['campaign'],
      activeCampaignContactId: json['activeCampaignContactId'] as String?,
      isCommunityMember: json['isCommunityMember'] as bool?,
      insuranceProvider: json['insuranceProvider'],
      state: json['state'] == null
          ? null
          : State.fromJson(json['state'] as Map<String, dynamic>),
      reason: json['reason'] == null
          ? null
          : Reason.fromJson(json['reason'] as Map<String, dynamic>),
      insuranceState: json['insuranceState'],
      eligibleProducts: (json['eligibleProducts'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedProduct: json['selectedProduct'] == null
          ? null
          : Product.fromJson(json['selectedProduct'] as Map<String, dynamic>),
      howDidYouHear: json['howDidYouHear'] as List<dynamic>?,
    );

Map<String, dynamic> _$WaitlistUserToJson(WaitlistUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'dob': instance.dob?.toIso8601String(),
      'gender': instance.gender,
      'zipCode': instance.zipCode,
      'phoneNumber': instance.phoneNumber,
      'isDirectSignUp': instance.isDirectSignUp,
      'source': instance.source,
      'medium': instance.medium,
      'campaign': instance.campaign,
      'activeCampaignContactId': instance.activeCampaignContactId,
      'isCommunityMember': instance.isCommunityMember,
      'insuranceProvider': instance.insuranceProvider,
      'state': instance.state?.toJson(),
      'reason': instance.reason?.toJson(),
      'insuranceState': instance.insuranceState,
      'eligibleProducts':
          instance.eligibleProducts?.map((e) => e.toJson()).toList(),
      'selectedProduct': instance.selectedProduct?.toJson(),
      'howDidYouHear': instance.howDidYouHear,
    };

Reason _$ReasonFromJson(Map<String, dynamic> json) => Reason(
      value: json['value'] as String,
    );

Map<String, dynamic> _$ReasonToJson(Reason instance) => <String, dynamic>{
      'value': instance.value,
    };

State _$StateFromJson(Map<String, dynamic> json) => State(
      code: json['code'] as String,
      fullName: json['fullName'] as String,
      eligible: json['eligible'] as bool,
      eligibleNutrition: json['eligibleNutrition'] as bool,
    );

Map<String, dynamic> _$StateToJson(State instance) => <String, dynamic>{
      'code': instance.code,
      'fullName': instance.fullName,
      'eligible': instance.eligible,
      'eligibleNutrition': instance.eligibleNutrition,
    };
