import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/models/user/user.dart';
import 'package:agenda_wizard/providers/agendaProvider.dart';
import 'package:agenda_wizard/providers/userProvider.dart';
import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../../../../styles/styles.dart';
import '../../../../../styles/theme_util.dart';
import 'package:agenda_wizard/ui/features/list_agendas/view_model/list_agendas_viewmodel.dart';
import 'package:agenda_wizard/ui/features/list_agendas/widgets/eventplan_list_item.dart';
import 'package:flutter/material.dart';

class ListAgendasScreen extends StatefulWidget {
  final ListAgendasViewModel viewmodel;

  ListAgendasScreen({super.key, required this.viewmodel});

  @override
  State<ListAgendasScreen> createState() => _ListAgendasScreenState();
}

class _ListAgendasScreenState extends State<ListAgendasScreen> {
  List<EventPlan> eventPlanList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserProvider>();
      // if user already loaded, load now
      if (userProvider.currentUser != null) {
        context
            .read<AgendaProvider>()
            .loadEventPlans(userProvider.currentUser!);
      } else {
        // wait for user to load
        userProvider.addListener(() {
          if (userProvider.currentUser != null) {
            context
                .read<AgendaProvider>()
                .loadEventPlans(userProvider.currentUser!);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    User? user = FirebaseAuth.instance.currentUser;

    final provider = context.watch<AgendaProvider>();

    if (user != null) {
       eventPlanList = provider.userEventPlans ?? [];
    } else {
      eventPlanList = widget.viewmodel.getRecentEventPlans();
    }

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
                        "Event Agendas",
                        style: context.theme.textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (provider.isLoading)
                        Column(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 10),
                            Text("Loading agendas...",
                                style: theme.textTheme.bodyMedium)
                          ],
                        )
                      else
                        ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 800.0,
                            ),
                            child: _generateAgendaListItems(theme, context))
                    ],
                  )
                ]),
              )),
        ),
      ],
    );
  }

  Widget _generateAgendaListItems(theme, context) {
    Widget agendaItemContent = const Column();

    if (eventPlanList.isEmpty) {
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
      for (EventPlan event in eventPlanList) {
        previousAgendaItems.add(EventPlanListItem(
          eventPlan: event,
          onDelete: () {
            showDeleteDialogue(context, event);
          },
        ));
      }
      agendaItemContent = Column(
        children: [...previousAgendaItems],
      );
    }

    return agendaItemContent;
  }

  void showDeleteDialogue(BuildContext context, EventPlan event) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete agenda?'),
          content: const Text('This will permanently delete your agenda.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismisses the dialog
              },
            ),
            TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  // Perform your discard logic here
                  widget.viewmodel.deleteEventPlan(event).then((result) {
                    switch (result) {
                      case Ok<void>():
                        //router.go(Routes.agendas);
                        Navigator.of(context).pop();
                      case Error():
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Error deleting agenda. Please try again.')),
                        );
                        Navigator.of(context).pop();
                    }
                  });
                }),
          ],
        );
      },
    );
  }
}
