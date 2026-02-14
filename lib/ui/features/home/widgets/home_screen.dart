import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/styles/app_asset.dart';
import 'package:agenda_wizard/ui/core/widgets/main_button.dart';
import 'package:flutter/gestures.dart';
import '../../../../../styles/app_styles.dart';
import '../../../../../styles/theme_util.dart';
import 'package:agenda_wizard/ui/features/home/view_model/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewmodel viewModel;

  void goToBuildAgenda() {
    router.go(Routes.buildAgenda);
  }

  Future<void> goBuildSampleAgenda() async {
    await viewModel.buildSampleAgenda();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAsset.background.path),
          alignment: Alignment.centerRight,
          fit: BoxFit.contain,
        ),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(238, 240, 239, 1),
            Colors.white
          ], // Define your gradient colors
          begin: Alignment.centerLeft, // Starting point of the gradient
          end: Alignment.centerRight, // Ending point of the gradient
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ListenableBuilder(
              listenable: viewModel,
              builder: (BuildContext context, _) {
                if (viewModel.loadHomeData.isExecuting.value) {
                  return const Text('Loading . . .');
                } else if (viewModel.loadHomeData.results.value.hasData) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 450,
                      minHeight: MediaQuery.of(context).size.height - 100,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Agenda Builder',
                              style: AppTextStyle.agendaLogoThick.copyWith(
                                  color: context.theme.colorScheme.tertiary)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('by Frankly',
                              style: AppTextStyle.agendaByFrankly.copyWith(
                                  color: context.theme.colorScheme.tertiary)),
                          Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: accentColor,
                                    width: 5,
                                  ),
                                ),
                              ),
                              child: const SizedBox(
                                height: 30,
                                width: 28,
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Welcome',
                            style: context.theme.textTheme.displayLarge!
                                .copyWith(
                                    color: context.theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Frankly’s Agenda Builder enables you to facilitate constructive discourse. We help you create an agenda for whatever type of discussion you need.',
                            style: context.theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 40),
                          MainButton(
                            buttonText: 'Create Agenda',
                            callBack: goToBuildAgenda,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (kDebugMode) MainButton(
                            buttonText: 'Create Sample Agenda',
                            callBack: goBuildSampleAgenda,
                            isSecondary: true,
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (viewModel.loadHomeData.results.value.hasError) {
                  return Text(
                      'An error has ocurred: ${viewModel.loadHomeData.results.value.error}');
                }
                return const Text('A very unforseen error has ocurred.');
              },
            ),
          ],
        ),
      ),
    );
  }
}
