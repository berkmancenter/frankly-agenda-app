import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import '../../../../../styles/styles.dart';
import '../../../../../styles/theme_util.dart';
import 'package:agenda_wizard/ui/features/list_agendas/view_model/list_agendas_viewmodel.dart';
import 'package:agenda_wizard/ui/features/list_agendas/widgets/eventplan_list_item.dart';
import 'package:flutter/material.dart';

class ListAgendasScreen extends StatelessWidget {
  final ListAgendasViewModel viewmodel;

  const ListAgendasScreen({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: Container(
              color: context.theme.colorScheme.surfaceContainer,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Previous Event Agendas",
                        style: context.theme.textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 800.0,
                          ),
                          child: _generateAgendaListItems(theme)),
                    ],
                  )
                ]),
              )),
        ),
      ],
    );
  }

  Widget _generateAgendaListItems(theme) {
    Widget agendaItemContent = const Column();

    if (viewmodel.getRecentEventPlans().isEmpty) {
      agendaItemContent = Column(children: [
        const SizedBox(height: 10),
        const Text("Looks like you haven't created any agendas yet!"),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primaryFixed,
            ),
            onPressed: () => router.go(Routes.buildAgenda),
            child: Text('Create Agenda',
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.colorScheme.onPrimaryFixed)))
      ]);
    } else {
      List<Widget> previousAgendaItems = [];
      for (EventPlan event in viewmodel.getRecentEventPlans()) {
        previousAgendaItems.add(EventPlanListItem(
          eventPlan: event,
        ));
      }
      agendaItemContent = Column(
        children: [...previousAgendaItems],
      );
    }

    return agendaItemContent;
  }
}
