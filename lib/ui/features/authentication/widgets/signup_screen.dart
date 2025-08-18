import 'package:agenda_wizard/routing/router.dart';
import 'package:agenda_wizard/routing/routes.dart';
import '../../../../../styles/app_styles.dart';
import '../../../../../styles/theme_util.dart';
import 'package:agenda_wizard/ui/core/widgets/form_input.dart';
import 'package:agenda_wizard/ui/features/authentication/view_model/auth_viewmodel.dart';
import 'package:agenda_wizard/utils/custom_result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key, required AuthViewModel authViewModel})
      : _authViewModel = authViewModel;

  final AuthViewModel _authViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                    'We\'re glad to have you! You can create your account here.',
                    style: AppTextStyle.eyebrowSmall,
                  ),
                  SignUpForm(
                    authViewModel: _authViewModel,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () => context.push(Routes.login),
                          child: const Text('Login'))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  final AuthViewModel authViewModel;
  const SignUpForm({super.key, required this.authViewModel});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _reenterPassword = TextEditingController();

  String _errorMessage = "";

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _reenterPassword.dispose();
    super.dispose();
  }

  Future<void> submitSignIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Assume your async operation with server call
        final router = GoRouter.of(context);
        final result = await widget.authViewModel.createUser(
            _name.text.trim(), _email.text.trim(), _password.text.trim());

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
          const SizedBox(
            height: 10,
          ),
          FormInput(
            labelText: 'Name',
            fieldController: _name,
            isRequired: true,
          ),
          FormInput(
            labelText: 'Email',
            fieldController: _email,
            isRequired: true,
          ),
          FormInput(
            labelText: 'Password',
            fieldController: _password,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          FormInput(
            labelText: 'Re-enter Password',
            fieldController: _reenterPassword,
            isRequired: true,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: context.theme.colorScheme.primary,
                  minimumSize: const Size(double.infinity, 50)),
              onPressed: submitSignIn,
              child: Text('Sign Up',
                  style: AppTextStyle.bodyMedium
                      .copyWith(color: context.theme.colorScheme.onPrimary))),
        ],
      ),
    );
  }
}
