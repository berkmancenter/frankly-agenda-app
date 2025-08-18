import 'package:agenda_wizard/models/agenda/event_plan.dart';
import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import '../../../../../styles/app_styles.dart';
import '../../../../../styles/theme_util.dart';
import 'package:agenda_wizard/ui/core/widgets/divider_line.dart';
import 'package:flutter/material.dart';

class EventPlanListItem extends StatelessWidget {
  final EventPlan eventPlan;
  const EventPlanListItem({super.key, required this.eventPlan});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: context.theme.colorScheme.surfaceContainerLow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                eventPlan.eventName,
                style: AppTextStyle.bodyMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                eventPlan.eventDescription,
                style: AppTextStyle.body,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (eventPlan.isSeries)
                    if (eventPlan.agendas.length > 1)
                      Text(
                        "${eventPlan.agendas.length} agendas",
                        style: AppTextStyle.bodySmall,
                      )
                    else
                      Text(
                        "${eventPlan.agendas.length} agenda",
                        style: AppTextStyle.bodySmall,
                      ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const DividerLine(
                padding: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                      label: const Text('Edit Event Agendas'),
                      onPressed: () =>
                          router.go(Routes.editAgenda, extra: eventPlan),
                      icon: const Icon(Icons.edit)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
