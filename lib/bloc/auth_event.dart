part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Authentication Events

class AuthInitialEvent extends AuthEvent {
  final String? serverBaseUrl;
  final String? chatConstantPath;
  final Config? authConfig;
  final AuthDesignConfig? designConfig;


  const AuthInitialEvent({
    required this.serverBaseUrl,
    required this.designConfig,
    required this.authConfig,
    required this.chatConstantPath,
  });
}

class AuthCheckAuthenticationEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {}

// class AuthCreateAccountEvent extends AuthEvent {
//   final PatientModel patientModel;
//   final String gender;
//   final bool dependant;
//   const AuthCreateAccountEvent({
//     required this.patientModel,
//     required this.gender,
//     required this.dependant,
//   });
// }

// Patient Program Events
class AuthGetPatientProgramEvent extends AuthEvent {}

// Biometrics
class EnableBiometricsEvent extends AuthEvent {}

// Logout Events
class AuthLogoutEvent extends AuthEvent {}

// Consent Form Events
class FetchConsentFormEvent extends AuthEvent {}

class SubmitConsentFormEvent extends AuthEvent {}

// Pin Events
class PinCheckingForAuthEvent extends AuthEvent {
  final String pin;
  const PinCheckingForAuthEvent({
    required this.pin,
  });
}

class PinAddedForAuthEvent extends AuthEvent {
  final String pin;
  const PinAddedForAuthEvent({
    required this.pin,
  });
}
