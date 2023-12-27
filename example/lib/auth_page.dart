import 'dart:developer';

import 'package:azo_auth/bloc/auth_bloc.dart';
import 'package:azo_auth/ui/pages/landing.dart';
import 'package:example/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthPage extends StatefulWidget {
  final String? serverBaseUrl;
  final String? chatConfigPath;

  const AuthPage({
    required this.serverBaseUrl,
    required this.chatConfigPath,
    super.key,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final authBloc = AuthBloc();
  @override
  void initState() {
    authBloc.add(AuthInitialEvent(
      serverBaseUrl: widget.serverBaseUrl,
      authConfig: Constants.config,
      designConfig: Constants.authDesignConfig,
      chatConstantPath: widget.chatConfigPath,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 750),
      minTextAdapt: true,
      splitScreenMode: false,
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          bloc: authBloc,
          listenWhen: (previous, current) => current is AuthActionState,
          buildWhen: (previous, current) => current is! AuthActionState,
          listener: (context, state) {},
          builder: (context, state) {
            log('State: $state');
            switch (state.runtimeType) {
              case AuthLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case AuthNotAuthorisedState:
                return const Center(
                  child: Text('Not Authorised'),
                );
              case AuthSignedInState:
                return const Center(
                  child: Text('Signed In'),
                );
              case AuthCreateAccountSuccessful:
                return const Center(
                  child: Text('Create Account Successful'),
                );
              case AuthCreateAccountUnSuccessful:
                return const Center(
                  child: Text('Create Account UnSuccessful'),
                );
              case AuthLogoutState:
                return Landing(
                  authBloc: authBloc,
                );

              case AuthShowLandingState:
                return Landing(
                  authBloc: authBloc,
                );
              case NavigationToTab1ActionState:
                return const Center(
                  child: Text('Navigation To Tab 1'),
                );
              case AuthShowEnableBiometricsPageActionState:
                return const Center(
                  child: Text('Show Enable Biometrics Page'),
                );
              case AuthShowEnableFaceIdPageActionState:
                return const Center(
                  child: Text('Show Enable Face Id Page'),
                );
              case AuthShowEnableFingerPrintIdPageActionState:
                return const Center(
                  child: Text('Show Enable Finger Print Id Page'),
                );
              case AuthBiometricsDoneActionState:
                return const Center(
                  child: Text('Biometrics Done'),
                );
              case ShowPreEnrollmentFormState:
                return const Center(
                  child: Text('Show Pre Enrollment Form'),
                );
              case ShowUnregisteredFormState:
                return const Center(
                  child: Text('Show Unregistered Form'),
                );
              case ConsentFormFetchedState:
                return const Center(
                  child: Text('Consent Form Fetched'),
                );
              case ShowConsentFormState:
                return const Center(
                  child: Text('Show Consent Form'),
                );
              case ConsentFormAcceptedActionState:
                return const Center(
                  child: Text('Consent Form Accepted'),
                );
              case PinVerifiedActionState:
                return const Center(
                  child: Text('Pin Verified'),
                );
              case PinRejectedActionState:
                return const Center(
                  child: Text('Pin Rejected'),
                );
              default:
                return Center(
                  child: Text('Unknown State: ${state.toString()}'),
                );
            }
          },
        ),
      ),
    );
  }
}
