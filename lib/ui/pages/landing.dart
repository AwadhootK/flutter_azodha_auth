import 'package:azo_auth/bloc/auth_bloc.dart';
import 'package:azo_auth/ui/utils/authLiterals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Landing extends StatefulWidget {
  final AuthBloc authBloc;

  const Landing({
    required this.authBloc,
    super.key,
  });

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(50.w, 0.h, 20.w, 0.h),
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(0 / 360),
                          child: Container(
                            width: 200.w,
                            height: 64.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    widget.authBloc.authDesignConfig!
                                        .rippleLogoImage,
                                  ),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 225.w,
                        alignment: Alignment.center,
                        child: Text(
                          Literals.landingPageDescription,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 24.sp),
                        ),
                      ),
                      SizedBox(
                        height: 90.h,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: -165.h,
                  left: -170.w,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(0 / 360),
                    child: Container(
                      width: 750.w,
                      height: 500.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              widget
                                  .authBloc.authDesignConfig!.topDecoratorImage,
                            ),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -200.h,
                  right: -170.w,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(0 / 360),
                    child: Container(
                      width: 750.w,
                      height: 500.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              widget.authBloc.authDesignConfig!
                                  .bottomDecoratorImage,
                            ),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 85.h,
                  left: 20.w,
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 374.w, height: 60.h),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.authBloc.add(AuthLoginEvent());
                      },
                      child: Text(
                        Literals.getStarted,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
