import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import '../../../../../styles/styles.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/auth_viewmodel.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  final AuthViewModel _authViewModel;
  const LoginScreen({super.key, required AuthViewModel authViewModel})
      : _authViewModel = authViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Navigator.canPop(context)
                    ? IconButton(
                        onPressed: () => GoRouter.of(context).pop(),
                        icon: const Icon(Icons.arrow_back))
                    : IconButton(
                        onPressed: () => router.go(Routes.home),
                        icon: const Icon(Icons.home_filled)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome',
                        style: AppTextStyle.headline2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'We\'re glad your back! Sign in here.',
                        style: AppTextStyle.eyebrowSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LogInForm(authViewModel: _authViewModel),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: () => context.push(Routes.signup),
                              child: const Text('Register'))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogInForm extends StatefulWidget {
  final AuthViewModel authViewModel;
  const LogInForm({super.key, required this.authViewModel});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String _errorMessage = "";

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> submitLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Assume your async operation with server call
        final router = GoRouter.of(context);
        final result = await widget.authViewModel
            .logIn(_email.text.trim(), _password.text.trim());
        switch (result) {
          case Ok<void>():
            setState(() {
              _errorMessage = ''; // Clear any existing error
            });
            router.go(Routes.home);
          case Error():
            setState(() {
              if (result.displayError != null && result.displayError != "") {
                _errorMessage = result.displayError!;
              } else {
                _errorMessage = "Unknown error.";
              }
            });
        }
      } catch (e) {
        // Handle exceptions (e.g., network issues)
        setState(() {
          _errorMessage = 'Network error, please try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                color: Colors.redAccent,
                width: double.infinity,
                child: _errorMessage.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Error: $_errorMessage',
                          textAlign: TextAlign.left,
                        ),
                      )
                    : null),
            FormInput(
              labelText: 'Email',
              fieldController: _email,
              isRequired: true,
              textInputAction: TextInputAction.next,
            ),
            FormInput(
              labelText: 'Password',
              fieldController: _password,
              isRequired: true,
              isObscured: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => submitLogin(),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.colorScheme.primary,
                    minimumSize: const Size(double.infinity, 50)),
                onPressed: submitLogin,
                child: Text('Sign In',
                    style: context.theme.textTheme.bodyMedium!
                        .copyWith(color: context.theme.colorScheme.onPrimary))),
          ],
        ));
  }
}
