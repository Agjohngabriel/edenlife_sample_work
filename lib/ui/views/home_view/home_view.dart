import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/helpers/constants/colors.dart';
import 'package:tracking_app/ui/views/home_view/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: AppColors.black,
              body: Center(
                child: Text("${model.user?.displayName}"),
              ),
            ));
  }
}
