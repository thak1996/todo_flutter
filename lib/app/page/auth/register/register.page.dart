import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter/app/core/service/auth.service.dart';
import 'package:todo_flutter/app/core/theme/app.colors.dart';
import 'package:todo_flutter/app/core/utils/validators.dart';
import 'package:todo_flutter/app/l10n/app_localizations.dart';
import 'package:todo_flutter/app/core/models/export.models.dart';
import 'package:todo_flutter/app/shared/widgets/export.widgets.dart';
import 'register.controller.dart';
import 'register.state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => RegisterController(AuthService()),
      child: BlocBuilder<RegisterController, RegisterState>(
        builder: (context, state) {
          final controller = context.read<RegisterController>();
          return BlocListener<RegisterController, RegisterState>(
            listener: (context, state) {
              if (state is RegisterError) {
                AlertDialogWidget.show(
                  context,
                  title: 'Erro',
                  message: state.message,
                );
              }
              if (state is RegisterSuccess) context.go('/home');
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
                              Icons.person_add,
                              size: 64,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              l10n.createAccount,
                              style: theme.textTheme.headlineMedium,
                            ),
                            SizedBox(height: height * 0.08),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextFieldWidget(
                                    controller: _nameController,
                                    label: l10n.name,
                                    validator: (value) {
                                      return Validators.validateName(
                                        value,
                                        l10n,
                                      );
                                    },
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {
                                      controller.validateFields(
                                        UserModel(
                                          name: value,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: height * 0.02),
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
                                          name: _nameController.text,
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
                                    textInputAction: TextInputAction.next,
                                    isPassword: true,
                                    onChanged: (value) {
                                      controller.validateFields(
                                        UserModel(
                                          name: _nameController.text,
                                          email: _emailController.text,
                                          password: value,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: height * 0.02),
                                  TextFieldWidget(
                                    controller: _confirmPasswordController,
                                    label: l10n.confirmPassword,
                                    validator: (value) {
                                      return Validators.validateConfirmPassword(
                                        value,
                                        _passwordController.text,
                                        l10n,
                                      );
                                    },
                                    textInputAction: TextInputAction.done,
                                    isPassword: true,
                                    onChanged: (value) {
                                      controller.validateFields(
                                        UserModel(
                                          name: _nameController.text,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            FilledButton(
                              onPressed:
                                  state is RegisterLoading || !state.isValid
                                  ? null
                                  : () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        controller.register(
                                          UserModel(
                                            name: _nameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                              child: state is RegisterLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(l10n.signUp),
                            ),
                            SizedBox(height: height * 0.02),
                            TextButtonWidget(
                              primaryText: l10n.alreadyHaveAccount,
                              secondaryText: l10n.register,
                              primaryTextColor: AppColors.textPrimary,
                              secondaryTextColor: AppColors.link,
                              onPressed: () => context.push('/login'),
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
