import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/helpers/constants/assets.dart';
import 'package:tracking_app/helpers/constants/colors.dart';
import 'package:tracking_app/helpers/utils/build_context/build_context.dart';
import 'package:tracking_app/helpers/utils/build_context/text_theme.dart';
import 'package:tracking_app/ui/views/login_view/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => SafeArea(
              top: true,
              bottom: true,
              child: Scaffold(
                backgroundColor: AppColors.primaryBackground,
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          AppAssets.logo,
                          width: context.widthPercent(0.3),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A simple order tracking app with Flutter using Firebase Auth and Ably Realtime",
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: context.heightPercent(0.2),
                      ),
                      InkWell(
                        onTap: () => model.loginWithGoogle(),
                        child: const SocialLoginButtons(
                          caption: "Google Sign In",
                          color: AppColors.black,
                          icon: Image(image: AssetImage(AppAssets.googleIcon)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => model.signInWithGitHub(),
                        child: const SocialLoginButtons(
                          caption: "Github Sign In",
                          icon: Image(image: AssetImage(AppAssets.githubIcon)),
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "By signing up, you indicate that you have read and agreed to the",
                        textAlign: TextAlign.center,
                        style: context.textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Terms of Service",
                        textAlign: TextAlign.center,
                        style: context.textTheme.labelMedium?.copyWith(
                            decoration: TextDecoration.underline,
                            color: AppColors.darkblue),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
    required this.caption,
    required this.icon,
    required this.color,
  });
  final String caption;
  final Widget icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.9),
            ),
            child: icon,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              caption,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge
                  ?.copyWith(color: AppColors.white),
            ),
          )
        ],
      ),
    );
  }
}
