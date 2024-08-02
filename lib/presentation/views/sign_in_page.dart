import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal_cubit/core/utils/core_utils.dart';
import 'package:journal_cubit/presentation/views/dashboard.dart';
import 'package:journal_cubit/presentation/views/sign_up_page.dart';
import 'package:journal_cubit/presentation/widgets/sign_in_form.dart';

import '../auth_bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const routeName = '/sign-in';
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(listener: (_, state) {
        if (state is AuthError) {
          CoreUtils.showSnackBar(
              context, 'Something went wrong with signing in');
        }
      }, builder: (BuildContext context, AuthState state) {
        ///return a column with two ifields, a sizedbox, and a button to put in sign in
        ///does ifield have validation?
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .20,
            ),
            state is SignedIn
                ? Text(state.user!.name)
                : const Text('Not logged in yet'),
            SignInForm(
              emailController: emailController,
              passwordController: passwordController,
              formKey: formKey,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(SignInEvent(
                        email: emailController.text,
                        password: passwordController.text));
                  }
                  passwordController.clear();
                  emailController.clear();
                },
                child: const Text('Sign In')),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, SignUpScreen.routeName),
                child: const Text('Register')),
                state is SignedIn ?
                ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context,
                  DashboardPage.routeName,
                  );
                  passwordController.clear();
                  emailController.clear();
                }, child: 
                 const Text('Dashboard page'),
                  ) :
                const SizedBox(),
          ],
        );
      }),
    );
  }
}
