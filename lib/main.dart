import 'package:agenda_wizard/config/dependencies.dart';
import 'package:agenda_wizard/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../styles/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:agenda_wizard/routing/router.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    // Only use the emulator when debugging locally
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
    FirebaseFirestore.instance.settings = const Settings(
      host: '127.0.0.1:8080',
      sslEnabled: false,
      persistenceEnabled: false,
      webExperimentalForceLongPolling: true,
    );
    print("DEBUG: Connected to Firestore Emulator at 'localhost:8080");
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
