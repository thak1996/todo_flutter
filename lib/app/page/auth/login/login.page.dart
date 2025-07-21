import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';
import '../../../core/models/auth/user.model.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/alert_dialog.widget.dart';
import '../../../core/widgets/text_button.widget.dart';
import '../../../core/widgets/text_field.widget.dart';
import 'login.controller.dart';
import 'login.state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LoginController(),
      child: BlocBuilder<LoginController, LoginState>(
        builder: (context, state) {
          final controller = context.read<LoginController>();
          return BlocListener<LoginController, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                AlertDialogWidget.show(
                  context,
                  title: 'Erro',
                  message: state.message,
                );
              }
              if (state is LoginSuccess) context.go('/home');
            },
            child: Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 24,
                          left: 24,
                          bottom: 24,
                        ),
                        child: Column(
                          children: [
                            const Spacer(flex: 1),
                            Icon(
                              Icons.security,
                              size: 64,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              l10n.welcomeBack,
                              style: theme.textTheme.headlineMedium,
                            ),
                            SizedBox(height: height * 0.08),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextFieldWidget(
                                    controller: _emailController,
                                    label: l10n.email,
                                    validator: (value) {
                                      return Validators.validateEmail(
                                        value,
                                        l10n,
                                      );
                                    },
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {
                                      controller.validateFields(
                                        UserModel(
                                          email: value,
                                          password: _passwordController.text,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: height * 0.02),
                                  TextFieldWidget(
                                    controller: _passwordController,
                                    label: l10n.password,
                                    validator: (value) {
                                      return Validators.validatePassword(
                                        value,
                                        l10n,
                                      );
                                    },
                                    isPassword: true,
                                    onChanged: (value) {
                                      controller.validateFields(
                                        UserModel(
                                          email: _emailController.text,
                                          password: value,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: height * 0.02),
                                  TextButtonWidget(
                                    alignment: Alignment.topRight,
                                    primaryText: l10n.forgotPassword,
                                    primaryTextColor: AppColors.link,
                                    onPressed: () {},
                                  ),
                                  SizedBox(height: height * 0.02),
                                ],
                              ),
                            ),
                            const Spacer(),
                            FilledButton(
                              onPressed: state is LoginLoading || !state.isValid
                                  ? null
                                  : () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        controller.login(
                                          UserModel(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                              child: state is LoginLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(l10n.login),
                            ),
                            SizedBox(height: height * 0.02),
                            TextButtonWidget(
                              primaryText: l10n.dontHaveAccount,
                              secondaryText: l10n.signUp,
                              primaryTextColor: AppColors.textPrimary,
                              secondaryTextColor: AppColors.link,
                              onPressed: () => context.push('/register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
