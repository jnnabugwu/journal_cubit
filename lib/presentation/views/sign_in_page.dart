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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {

            if (state is AuthError) {
              CoreUtils.showSnackBar(context, state.message);
            }
          
      },
      
      builder: (context, state) {
        context.read<AuthBloc>().add(AppStarted());
        return Scaffold(
          backgroundColor: Colors.white,
          body: 
             Column(
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
                    child: const Text('Login')),
                state is SignedIn
                    ? ElevatedButton(
                        onPressed: () =>
                            context.read<AuthBloc>().add(LoggedOut()),
                        child: const Text('Log Out'))
                    : ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                            context, SignUpScreen.routeName),
                        child: const Text('Register')),
                state is SignedIn
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            DashboardPage.routeName,
                          );
                          passwordController.clear();
                          emailController.clear();
                        },
                        child: const Text('Dashboard page'),
                      )
                    : const SizedBox(),
              ],
            ),
  
        );
      },
    );
  }
}
