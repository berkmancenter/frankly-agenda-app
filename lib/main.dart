import 'package:agenda_wizard/config/dependencies.dart';
import 'package:agenda_wizard/firebase_options.dart';
import '../styles/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:agenda_wizard/routing/router.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    // Only use the emulator when debugging locally
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  }

  runApp(
    MultiProvider(providers: [...providersLocal], child: const App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Agenda Wizard App',
      routerConfig: router,
      theme: appTheme,
    );
  }
}