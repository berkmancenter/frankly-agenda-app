import 'package:agenda_wizard/data/repositories/auth/auth_repository.dart';
import 'package:agenda_wizard/providers/userProvider.dart';
import 'package:agenda_wizard/routing/routes.dart';
import 'package:agenda_wizard/utils/feature_flags.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../styles/app_asset.dart';
import '../../../../styles/app_styles.dart';
import '../../../../styles/theme_util.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/logout_viewmodel.dart';
import 'package:agenda_wizard/ui/features/authentication/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WebAppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? userName;
  final Function tabCallback;
  final int currIndex;
  const WebAppHeader({
    super.key,
    required this.tabCallback,
    this.userName,
    required this.currIndex,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    String userName = context.watch<UserProvider>().name;
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          User? user;
          if (snapshot.connectionState == ConnectionState.active) {
            user = snapshot.data;
          }
          return Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surfaceContainerLowest,
              border: Border(
                bottom: BorderSide(
                  color: context.theme.colorScheme.secondaryFixedDim,
                  width: 1,
                ),
              ),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: AppSize.kPageContentMaxWidthDesktop),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: SizedBox(
                  height: AppSize.kNavBarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Semantics(
                            label: "Frankly Agenda Builder",
                            child: Image.asset(
                              AppAsset.kLogoIconPng.path,
                              width: 50,
                              height: 35,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text("Agenda Builder",
                              style: AppTextStyle.agendaLogo.copyWith(
                                  color: context.theme.colorScheme.tertiary)),
                        ],
                      ),
                      Row(
                        children: [
                          Tab(
                            currIndex: currIndex,
                            tabCallback: tabCallback,
                            index: 0,
                            tabLabel: 'Home',
                            iconImage: Icons.home,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Tab(
                            currIndex: currIndex,
                            tabCallback: tabCallback,
                            index: 1,
                            tabLabel: 'Create Agenda',
                            iconImage: Icons.create_rounded,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (user != null)
                            Tab(
                              currIndex: currIndex,
                              tabCallback: tabCallback,
                              index: 2,
                              tabLabel: 'Agenda List',
                              iconImage: Icons.view_agenda,
                            ),
                          if (FeatureFlagManager.isSignInEnabled)
                            Consumer<AuthRepository>(
                                builder: (context, authState, _) => Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 10.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: context
                                                        .theme
                                                        .colorScheme
                                                        .surfaceContainer, // Customize border color
                                                    width:
                                                        1, // Customize border width
                                                  ),
                                                ),
                                              ),
                                              child: const SizedBox(
                                                height: double.infinity,
                                                width: 5,
                                              )),
                                        ),
                                        if (authState.loggedIn) ...[
                                          Tab(
                                            currIndex: currIndex,
                                            tabCallback: tabCallback,
                                            index: 4,
                                            tabLabel: userName,
                                            iconImage: Icons.account_circle,
                                          ),
                                        ] else ...[
                                          Tab(
                                            currIndex: currIndex,
                                            tabCallback: tabCallback,
                                            index: 3,
                                            tabLabel: 'Login',
                                            iconImage: Icons.login,
                                          ),
                                        ],
                                      ],
                                    )),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class Tab extends StatelessWidget {
  const Tab(
      {super.key,
      required this.currIndex,
      required this.index,
      required this.tabCallback,
      required this.tabLabel,
      required this.iconImage});

  final int currIndex;
  final int index;
  final Function tabCallback;
  final String tabLabel;
  final IconData iconImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: currIndex == index
                ? accentColor
                : context.theme.colorScheme
                    .surfaceContainerLowest, // Customize border color
            width: 2, // Customize border width
          ),
        ),
      ),
      child: TextButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(4.0), // Adjust the radius value as needed
          ),
        ),
        icon: currIndex == index ? Icon(iconImage) : Icon(iconImage),
        label: currIndex == index
            ? Text(tabLabel,
                style: context.theme.textTheme.labelSmall!
                    .copyWith(color: context.theme.colorScheme.primary))
            : Text(
                tabLabel,
                style: context.theme.textTheme.labelSmall!
                    .copyWith(color: context.theme.colorScheme.tertiary),
              ),
        onPressed: () {
          tabCallback(index);
        },
      ),
    );
  }
}
