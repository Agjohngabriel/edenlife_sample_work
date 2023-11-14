import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/app/locator.dart';
import 'package:tracking_app/helpers/constants/colors.dart';
import 'package:tracking_app/helpers/utils/build_context/text_theme.dart';
import 'package:tracking_app/services/app_services/auth_service.dart';
import 'package:tracking_app/ui/views/home_view/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: AppColors.primaryBackground,
              appBar: AppBar(
                backgroundColor: AppColors.black,
                title: Text(
                  'Sample Tracker',
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: AppColors.white),
                ),
                actions: <Widget>[
                  if (model.user != null)
                    GestureDetector(
                      onTap: () {
                        showUserDetailsDialog(context, model.user!);
                      },
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(model.user?.photoURL ?? ''),
                          radius: 18.0,
                        ),
                      ),
                    ),
                ],
              ),
            ));
  }

  void showUserDetailsDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL ?? ''),
                  radius: 50.0,
                ),
                const SizedBox(height: 10.0),
                Text(
                  user.displayName ?? 'Name not available',
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  user.email ?? 'Email not available',
                  style: context.textTheme.labelMedium,
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppColors.black),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                          ),
                        ),
                        child: Text(
                          'Close',
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          locator<AuthService>().signOut();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppColors.red),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                          ),
                        ),
                        child: Text(
                          'Sign Out',
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
