// import 'package:azo_auth/bloc/auth_bloc.dart';
// import 'package:azo_auth/ui/pages/enter_pin_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SuccessfulPinPage extends StatefulWidget {
//   final AuthBloc authBloc;
//   const SuccessfulPinPage({super.key, required this.authBloc});

//   @override
//   State<SuccessfulPinPage> createState() => _SuccessfulPinPageState();
// }

// class _SuccessfulPinPageState extends State<SuccessfulPinPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//                 child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 120,
//                     width: 120,
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage(
//                                 'assets/profileimage/checkIcon.png'))),
//                   ),
//                   Text(
//                     'PIN set up successfully',
//                     style: GoogleFonts.notoSans(
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.w700,
//                         color: const Color(0xFF161616),
//                         wordSpacing: 2.0),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     'You can now use your PIN to \nsecurely access the app.',
//                     style: GoogleFonts.notoSans(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w400,
//                         color: const Color(0xFF161616),
//                         wordSpacing: 2.0),
//                     textAlign: TextAlign.center,
//                   )
//                 ],
//               ),
//             )),
//             Padding(
//                 padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
//                 child: ConstrainedBox(
//                     constraints:
//                         BoxConstraints.tightFor(width: 366.w, height: 62.h),
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => EnterPinPage(
//                                         authBloc: widget.authBloc,
//                                       )));
//                         },
//                         child: Text('Finish Set Up',
//                             style: GoogleFonts.notoSans(
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 16.sp,
//                                 color: Colors.white)))))
//           ],
//         ),
//       ),
//     );
//   }
// }
