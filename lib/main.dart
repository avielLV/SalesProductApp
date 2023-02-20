import 'package:flutter/material.dart';
import 'package:proudcto_app/screens/screens.dart';
import 'package:proudcto_app/services/services.dart';
import 'package:proudcto_app/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Productos App',
        initialRoute: 'checking',
        scaffoldMessengerKey: NotificationsService.messengerKey,
        routes: {
          'login': (context) => const LoginScreen(),
          'register': (context) => const RegisterScreen(),
          'home': (context) => const HomeScreen(),
          'product': (context) => const ProductScreen(),
          'checking': (context) => const CheckAuthScreen(),
        },
        theme: ThemeApp.themeApp);
  }
}
