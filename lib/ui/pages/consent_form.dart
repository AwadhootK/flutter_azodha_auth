// import 'dart:developer';

// import 'package:azo_auth/bloc/auth_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ConsentForm extends StatefulWidget {
//   final AuthBloc authBloc;
//   const ConsentForm({super.key, required this.authBloc});
//   static const routeName = '/ConsentForm';
//   @override
//   State<ConsentForm> createState() => _ConsentFormState();
// }

// class _ConsentFormState extends State<ConsentForm> {
//   @override
//   void initState() {
//     widget.authBloc.add(FetchConsentFormEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isChecked = false;

//     return Scaffold(
//       body: BlocConsumer<AuthBloc, AuthState>(
//         bloc: widget.authBloc,
//         listener: (context, state) {
//           context.pop();
//         },
//         buildWhen: (previous, current) => current is! AuthActionState,
//         listenWhen: (previous, current) =>
//             current is ConsentFormAcceptedActionState,
//         builder: (context, state) {
//           log("hereeeee!");
//           switch (state.runtimeType) {
//             case AuthLoadingState:
//               return Center(
//                 child: LoadingAnimationWidget.prograssiveDots(
//                   size: 55,
//                   color: const Color(0xFF3D42ED),
//                 ),
//               );

//             case ConsentFormFetchedState:
//               final successState = state as ConsentFormFetchedState;

//               return Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 35.h,
//                       ),
//                       SizedBox(
//                           width: 105.w,
//                           height: 31.h,
//                           child: Image.asset(
//                               'assets/landingimage/ripplelogo.png')),
//                       SizedBox(height: 20.h),
//                       Stack(
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
//                               child: Html(
//                                 customRenders: {
//                                   (context) =>
//                                           context.tree.element?.localName ==
//                                           'a':
//                                       CustomRender.widget(
//                                           widget: (context, child) {
//                                     final String? href = context
//                                         .tree.element!.attributes['href'];
//                                     return GestureDetector(
//                                       onTap: () async {
//                                         if (!await launchUrl(Uri.parse(href!),
//                                             mode: LaunchMode
//                                                 .externalApplication)) {
//                                           throw 'Could not launch $href';
//                                         }
//                                       },
//                                       child: Text(
//                                         href.toString(),
//                                         style: const TextStyle(
//                                           decoration: TextDecoration.underline,
//                                           decorationColor: Colors
//                                               .black, // Set the underline color to black
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                                 },
//                                 onLinkTap:
//                                     (url, context, attributes, element) async {
//                                   if (!await launchUrl(Uri.parse(url!),
//                                       mode: LaunchMode.externalApplication)) {
//                                     throw 'Could not launch $url';
//                                   }
//                                 },
//                                 data: successState.consentModel.description,
//                               )),
//                         ],
//                       ),
//                       StatefulBuilder(builder: (context, setState) {
//                         return Column(
//                           children: [
//                             CheckboxListTile(
//                               title: Transform.translate(
//                                 offset: Offset(-20.w, 0),
//                                 child: Text(
//                                   'I Agree',
//                                   style: Theme.of(context).textTheme.bodyText2,
//                                 ),
//                               ),
//                               value: isChecked,
//                               activeColor: const Color(
//                                   0xff3D42ED), // Change the checkbox color to purple
//                               checkColor: Colors.white,
//                               controlAffinity: ListTileControlAffinity.leading,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   isChecked = value!;
//                                 });
//                               },
//                             ),
//                             SizedBox(
//                               height: 50.h,
//                             ),
//                             ConstrainedBox(
//                                 constraints: BoxConstraints.tightFor(
//                                     width: 330.w, height: 60.h),
//                                 child: ElevatedButton(
//                                   style: Theme.of(context)
//                                       .elevatedButtonTheme
//                                       .style!
//                                       .copyWith(
//                                         backgroundColor:
//                                             MaterialStateProperty.all<Color>(
//                                                 isChecked
//                                                     ? const Color(0xFF424BF9)
//                                                     : Colors.grey),
//                                       ),
//                                   onPressed: () async {
//                                     if (isChecked) {
//                                       widget.authBloc
//                                           .add(SubmitConsentFormEvent());
//                                     } else {}
//                                   },
//                                   child: const Text('Continue'),
//                                 ))
//                           ],
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//               );

//             default:
//               return Center(
//                 child: LoadingAnimationWidget.prograssiveDots(
//                   size: 55,
//                   color: const Color(0xFF3D42ED),
//                 ),
//               );
//           }
//         },
//       ),
//     );
//   }
// }
