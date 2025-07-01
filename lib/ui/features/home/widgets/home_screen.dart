import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/ui/core/themes/app_styles.dart';
import 'package:agenda_wizard/ui/core/themes/theme_util.dart';
import 'package:agenda_wizard/ui/features/home/view_model/home_viewmodel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context
          .theme.colorScheme.surfaceContainer, // Example background color
      child: Row(
        children: [
          //SafeArea(child: Navigation()),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListenableBuilder(
                    listenable: viewModel,
                    builder: (BuildContext context, _) {
                      if (viewModel.loadHomeData.isExecuting.value) {
                        return const Text('Loading . . .');
                      } else if (viewModel.loadHomeData.results.value.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color:
                                context.theme.colorScheme.surfaceContainerLow,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Welcome!',
                                  style: AppTextStyle.headline2,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Welcome to Agenda Builder. Here, you can create an agenda that will foster the type of dialogue you\'d like to have for your next event.',
                                    style: AppTextStyle.eyebrow,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          context.theme.colorScheme.primary,
                                    ),
                                    onPressed: () =>
                                        router.go(Routes.buildAgenda),
                                    child: Text('Create Agenda',
                                        style: AppTextStyle.bodyMedium.copyWith(
                                            color: context
                                                .theme.colorScheme.onPrimary))),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (viewModel
                          .loadHomeData.results.value.hasError) {
                        return Text(
                            'An error has ocurred: ${viewModel.loadHomeData.results.value.error}');
                      }
                      return const Text('A very unforseen error has ocurred.');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
