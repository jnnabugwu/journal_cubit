import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal_cubit/core/services/injection_container.dart';
import 'package:journal_cubit/presentation/auth_bloc/auth_bloc.dart';
import 'package:journal_cubit/presentation/bloc/entrylist_bloc.dart';
import 'package:journal_cubit/presentation/views/dashboard.dart';
import 'package:journal_cubit/presentation/views/sign_in_page.dart';
import 'package:journal_cubit/presentation/views/sign_up_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  
  switch (settings.name) {
    case SignInPage.routeName:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (_) => sl<AuthBloc>(), child: const SignInPage()));

    case SignUpScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (_) => sl<AuthBloc>(), child: const SignUpScreen()));

    case DashboardPage.routeName:
      return MaterialPageRoute(builder: 
      (_) => BlocProvider(create: (_) => sl<EntryListBloc>(),child: const DashboardPage()));

    default:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (_) => sl<AuthBloc>(), child: const SignInPage()));
  }
}
