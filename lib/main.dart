import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal_cubit/core/services/injection_container.dart';
import 'package:journal_cubit/core/services/router.dart';
import 'package:journal_cubit/firebase_options.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';
import 'package:journal_cubit/presentation/entrylist_bloc/entrylist_bloc.dart';
import 'package:journal_cubit/theme/material_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();

  // Create an instance of MaterialTheme
  final materialTheme = const MaterialTheme(TextTheme()).light();

  runApp(MyApp(themeData: materialTheme));
}

class MyApp extends StatelessWidget {
  final ThemeData themeData;
  MyApp({super.key, required this.themeData});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            final authBloc = sl<AuthBloc>();
            authBloc.add(AppStarted());
            return authBloc;
          },
        ),
        BlocProvider<EntryListBloc>(
          create: (context) => sl.get<EntryListBloc>(
            param1: context.read<AuthBloc>(),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Journal App',
        theme: themeData,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
