import 'package:azo_auth/core/config/environment/environment.dart';
import 'package:azo_auth/core/di/app_dependency_injection.dart';
import 'package:example/auth_page.dart';
import 'package:example/constants.dart';
import 'package:flutter/material.dart';
import 'package:azo_auth/core/api_service/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "staging.env");
  Constants.initConfig();
  AuthDependencyInjector.setAuthDependencies(authConfig: Constants.config);
  Log.init(Constants.config);

  runApp(const MyApp());

  AuthEnvironment.initialize(
    serverURL: '',
    flavour: Flavour.development,
    patientId: '',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthPage(
        serverBaseUrl: '',
        chatConfigPath: '',
      ), //just testing the page from here
    );
  }
}
