part of 'auth_bloc.dart';

abstract class AuthActionState extends AuthState {}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// Authentication States
class AuthInitialState extends AuthState {}

class AuthLogoutState extends AuthState {}

class AuthNotAuthorisedState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSignedInState extends AuthState {}

class AuthShowLandingState extends AuthState {}

class AuthCreateAccountSuccessful extends AuthState {
  final PatientModel patientModel;
  const AuthCreateAccountSuccessful({required this.patientModel});
}

class AuthCreateAccountUnSuccessful extends AuthState {}

class NavigationToTab1ActionState extends AuthActionState {}

// Biometrics
class AuthShowEnableBiometricsPageActionState extends AuthActionState {}

class AuthShowEnableFaceIdPageActionState extends AuthActionState {}

class AuthShowEnableFingerPrintIdPageActionState extends AuthActionState {}

class AuthBiometricsDoneActionState extends AuthState {}

// Enrollement States
class ShowPreEnrollmentFormState extends AuthState {}

class ShowUnregisteredFormState extends AuthState {}

// Consent Form States
class ConsentFormFetchedState extends AuthState {
  final ConsentModel consentModel;
  const ConsentFormFetchedState({
    required this.consentModel,
  });
}

class ShowConsentFormState extends AuthActionState {}

class ConsentFormAcceptedActionState extends AuthActionState {}

// Pin states
class PinVerifiedActionState extends AuthActionState {}

class PinRejectedActionState extends AuthActionState {
  final DateTime dateTime;
  PinRejectedActionState({
    required this.dateTime,
  });
  @override
  List<Object> get props => [dateTime];
}

class PinNewAddedActionState extends AuthActionState {}

class ShowCreatePinPageState extends AuthActionState {}

class ShowEnterPinPageState extends AuthActionState {}
