import 'package:ecohero/locator.dart';
import 'package:flutter/material.dart';

import '../../common.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _navigate();
  }

  void _navigate() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(
          context,
          sl<UserCubit>().state.isAlreadyLogin ? PagePath.home : PagePath.login,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xff26B4A1),
        ),
        Positioned(
          child: Center(
            child: Image.asset(AppIcons.foreground, width: 138),
          ),
        ),
      ],
    );
  }
}
