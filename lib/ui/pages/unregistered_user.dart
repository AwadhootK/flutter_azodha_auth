import 'dart:developer';

import 'package:azo_auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


class Unregistered extends StatefulWidget {
  final AuthBloc authBloc;
  const Unregistered({super.key, required this.authBloc});
  static const routeName = '/Unregistered';
  @override
  State<Unregistered> createState() => _UnregisteredState();
}

class _UnregisteredState extends State<Unregistered> {
  // final Auth0Bloc authbloc = Auth0Bloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff8f8f8),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
            child: BlocConsumer<AuthBloc, AuthState>(
              bloc: widget.authBloc,
              listener: (context, state) {},
              builder: (context, state) {
                return ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: 366.w, height: 62.h),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF424BF9)),
                    child: Text(
                      "Find Out More",
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      if (!await launchUrl(Uri.parse('https://www.ripple.sg/'),
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch https://www.ripple.sg/';
                      }
                      widget.authBloc.add(AuthLogoutEvent());
                    },
                  ),
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 39.h,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.w, 39.h, 0.w, 0.h),
                    child: SizedBox(
                        width: 144.w,
                        height: 46.h,
                        child:
                            Image.asset('assets/landingimage/ripplelogo.png')),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25.w, 0.h, 0.w, 0.h),
                    child: SizedBox(
                      width: 286.w,
                      child: Text(
                        "Looks like you haven't registered with us yet!",
                        style: GoogleFonts.notoSans(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF161616),
                            wordSpacing: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 62.h,
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0.r)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25.w, 30.h, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 336.w,
                            child: Text(
                              "Interested in joining our Ripple Health Coaching programme? Find out more on our website.",
                              style: GoogleFonts.notoSans(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF161616),
                                  wordSpacing: 2.0),
                            ),
                          ),
                          SizedBox(
                            height: 320.h,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
