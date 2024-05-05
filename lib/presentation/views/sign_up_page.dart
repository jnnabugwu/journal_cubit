import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:journal_cubit/core/common/i_field.dart';
import 'package:journal_cubit/core/utils/core_utils.dart';
import 'package:journal_cubit/presentation/bloc/auth_bloc.dart';
import 'package:journal_cubit/presentation/views/sign_in_page.dart';
import 'package:journal_cubit/presentation/widgets/sign_in_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
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
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (_, state) {
            if (state is AuthError) {
              CoreUtils.showSnackBar(context, 'Theres something wrong');
            }
          },
          builder: (BuildContext context, AuthState state) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .30,
                ),
                IField(
                  controller: nameController,
                  hintText: 'Full Name',
                ),
                const SizedBox(
                  height: 25,
                ),
                SignInForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SignUpEvent(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text));
                      }
                    },
                    child: const Text('Sign up')),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignInPage.routeName),
                    child: const Text('Login'))
              ],
            );
          },
        ));
  }
}
