// import 'package:azo_auth/bloc/auth_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pinput/pinput.dart';

// import 'successful_pin_page.dart';

// class CreateNewPinPage extends StatefulWidget {
//   final AuthBloc authBloc;
//   static const routeName = '/createNewPin';
//   const CreateNewPinPage({super.key, required this.authBloc});

//   @override
//   State<CreateNewPinPage> createState() => _CreateNewPinPageState();
// }

// class _CreateNewPinPageState extends State<CreateNewPinPage> {
//   TextEditingController pinController = TextEditingController();
//   TextEditingController confirmPinController = TextEditingController();
//   bool showError = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<AuthBloc, AuthState>(
//         bloc: widget.authBloc,
//         listener: (context, state) {
//           if (state is PinNewAddedActionState) {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => SuccessfulPinPage(
//                           authBloc: widget.authBloc,
//                         )));
//           }
//         },
//         builder: (context, state) {
//           return Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 26.w, right: 26.w),
//                 height: 240.h,
//                 width: double.maxFinite,
//                 color: Colors.grey.shade100,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 80),
//                     Text(
//                       "Set up your PIN",
//                       style: GoogleFonts.notoSans(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                     SizedBox(height: 14.h),
//                     Text(
//                       "To keep your account secure, please set up a 6-digit PIN. This is a code that you'll use to access the app.",
//                       style: GoogleFonts.notoSans(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w400,
//                           color: const Color(0xFF161616),
//                           wordSpacing: 2.0),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.only(left: 26, right: 26),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 30),
//                               Text(
//                                 'PIN',
//                                 style: GoogleFonts.notoSans(
//                                     fontSize: 18.sp,
//                                     fontWeight: FontWeight.w400,
//                                     color: const Color(0xFF161616),
//                                     wordSpacing: 2.0),
//                               ),
//                               const SizedBox(height: 12),
//                               Pinput(
//                                 length: 6,
//                                 obscureText: true,
//                                 obscuringCharacter: '*',
//                                 defaultPinTheme: PinTheme(
//                                   width: 56,
//                                   height: 56,
//                                   textStyle: TextStyle(
//                                       fontSize: 20.sp,
//                                       color:
//                                           const Color.fromRGBO(30, 60, 87, 1),
//                                       fontWeight: FontWeight.w600),
//                                   decoration: BoxDecoration(
//                                     border:
//                                         Border.all(color: Colors.grey.shade300),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 controller: pinController,
//                               ),
//                               SizedBox(height: 30.h),
//                               Text('Confirm PIN',
//                                   style: GoogleFonts.notoSans(
//                                       fontSize: 18.sp,
//                                       fontWeight: FontWeight.w400,
//                                       color: const Color(0xFF161616),
//                                       wordSpacing: 2.0)),
//                               SizedBox(height: 12.h),
//                               Pinput(
//                                 length: 6,
//                                 obscureText: true,
//                                 obscuringCharacter: '*',
//                                 onCompleted: (value) {
//                                   if (value != pinController.text) {
//                                     setState(() {
//                                       showError = true;
//                                     });
//                                   } else if (value == pinController.text) {
//                                     setState(() {
//                                       showError = false;
//                                     });
//                                   }
//                                 },
//                                 defaultPinTheme: PinTheme(
//                                   width: 56,
//                                   height: 56,
//                                   textStyle: const TextStyle(
//                                       fontSize: 20,
//                                       color: Color.fromRGBO(30, 60, 87, 1),
//                                       fontWeight: FontWeight.w600),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: showError
//                                             ? Colors.red
//                                             : Colors.grey.shade300),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 controller: confirmPinController,
//                               ),
//                               SizedBox(height: 12.h),
//                               if (showError)
//                                 Column(
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(8.h),
//                                       decoration: BoxDecoration(
//                                           color: const Color(0xffFFE9F0),
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       child: Row(
//                                         children: [
//                                           const Icon(
//                                             Icons.warning,
//                                             color: Colors.red,
//                                           ),
//                                           SizedBox(width: 8.h),
//                                           const Expanded(
//                                             child: Text(
//                                                 'The PINs you entered do not match. Please check and try again.'),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                         margin: EdgeInsets.only(
//                             left: 26.w, right: 26.w, bottom: 30.h),
//                         height: 62.h,
//                         width: double.maxFinite,
//                         child: ElevatedButton(
//                             onPressed: () {
//                               if (pinController.text ==
//                                       confirmPinController.text &&
//                                   pinController.text.length == 6 &&
//                                   confirmPinController.text.length == 6) {
//                                 setState(() {
//                                   showError = false;
//                                 });
//                                 widget.authBloc.add(PinAddedForAuthEvent(
//                                     pin: confirmPinController.text));
//                               } else if (pinController.text !=
//                                       confirmPinController.text &&
//                                   pinController.text.length == 6 &&
//                                   confirmPinController.text.length == 6) {
//                                 setState(() {
//                                   showError = true;
//                                 });
//                               }
//                             },
//                             child: const Text('Set Up PIN')))
//                   ],
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
