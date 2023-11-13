import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/ui/views/startup_logic_view/startup_logic_viewmodel.dart';

class StartupLogicView extends StatelessWidget {
  const StartupLogicView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupLogicViewModel>.reactive(
        viewModelBuilder: () => StartupLogicViewModel(),
        onViewModelReady: (model) => model.startUp(context),
        builder: (context, model, child) => const Scaffold());
  }
}
