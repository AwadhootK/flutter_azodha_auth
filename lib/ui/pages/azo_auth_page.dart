// import 'package:azo_auth/bloc/auth_bloc.dart';
// import 'package:azo_auth/core/di/app_dependency_injection.dart';
// import 'package:azo_auth/ui/pages/consent_form.dart';
// import 'package:azo_auth/ui/pages/create_new_pin_page.dart';
// import 'package:azo_auth/ui/pages/enter_pin_page.dart';
// import 'package:azo_auth/ui/pages/errorScreen.dart';
// import 'package:azo_auth/ui/pages/landing.dart';
// import 'package:azo_auth/ui/pages/local_auth_view_common.dart';
// import 'package:azo_auth/ui/pages/local_auth_view_face.dart';
// import 'package:azo_auth/ui/pages/local_auth_view_touch.dart';
// import 'package:azo_auth/ui/pages/pre_enrollment.dart';
// import 'package:azo_auth/ui/pages/unregistered_user.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:logging/logging.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   final AuthBloc authBloc = AuthDependencyInjector.getIt.get();
//   final logger = Logger('AuthPage');
//   @override
//   void initState() {
//     authBloc.add(AuthCheckAuthenticationEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       bloc: authBloc,
//       listenWhen: (previous, current) => current is AuthActionState,
//       buildWhen: (previous, current) => current is! AuthActionState,
//       listener: (context, state) {
//         if (state is NavigationToTab1ActionState) {
//           GoRouter.of(context).go(Tab1.routeName);
//         } else if (state is AuthSignedInState) {
//           authBloc.add(AuthGetPatientProgramEvent());
//         } else if (state is ShowConsentFormState) {
//           logger.info('AuthPage : ShowConsentFormState');
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ConsentForm(authBloc: authBloc)));
//         } else if (state is ShowEnterPinPageState) {
//           logger.info('AuthPage : ShowEnterPinPageState');
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => EnterPinPage(authBloc: authBloc)));
//         } else if (state is ShowCreatePinPageState) {
//           logger.info('AuthPage : ShowCreatePinPageState');
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => CreateNewPinPage(authBloc: authBloc)));
//         } else if (state is AuthShowEnableBiometricsPageActionState) {
//           logger.info('AuthPage : AuthShowEnableBiometricsPageActionState');
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => LocalAuthViewCommon(
//                         authBloc: authBloc,
//                       )));
//         } else if (state is AuthShowEnableFaceIdPageActionState) {
//           logger.info('AuthPage : AuthShowEnableFaceIdPageActionState');
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => LocalAuthViewFace(authBloc: authBloc)));
//         } else if (state is AuthShowEnableFingerPrintIdPageActionState) {
//           logger.info('AuthPage : AuthShowEnableFingerPrintIdPageActionState');
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) =>
//                       LocalAuthViewTouch(authBloc: authBloc)));
//         }
//       },
//       builder: (context, state) {
//         logger.info("AuthPage State : ${state.runtimeType}");
//         switch (state.runtimeType) {
//           // loading state
//           case AuthLoadingState:
//             return Center(
//               child: LoadingAnimationWidget.prograssiveDots(
//                 size: 55,
//                 color: const Color(0xFF3D42ED),
//               ),
//             );

//           // return Get Started Page when logged out
//           case AuthLogoutState:
//             return const Landing();

//           // return unregistered when found unauthorized
//           case AuthNotAuthorisedState:
//             return Unregistered(authBloc: authBloc);

//           case AuthSignedInState:
//             authBloc.add(AuthGetPatientProgramEvent());
//             // TODO
//             return Center(
//               child: LoadingAnimationWidget.prograssiveDots(
//                 size: 55,
//                 color: const Color(0xFF3D42ED),
//               ),
//             );

//           case ShowPreEnrollmentFormState:
//             return const PreEnrollScreen();

//           case ShowUnregisteredFormState:
//             return Unregistered(authBloc: authBloc);

//           default:
//             logger.info("Showing Error Page : ${state.runtimeType}");
//             return const ErrorScreen();
//         }
//       },
//     );
//   }
// }
