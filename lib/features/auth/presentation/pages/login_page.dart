import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    
    
    final paddingHorizontal = screenWidth * 0.06;
    final iconSize = screenWidth * 0.15;
    final titleFontSize = screenWidth * 0.065;
    final subtitleFontSize = screenWidth * 0.035;
    final labelFontSize = screenWidth * 0.04;
    final hintFontSize = screenWidth * 0.035;
    final buttonHeight = screenHeight * 0.065;
    final cardPadding = screenWidth * 0.08;
    
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Bem-vindo, ${state.user.name}!'),
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.of(context).pushReplacementNamed('/subscriptions');
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryDark,
                AppColors.primaryMedium,
                AppColors.primaryLight,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(iconSize * 0.5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDarkTransparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.security,
                          size: iconSize,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Text(
                        'Empiricus',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Investimentos Inteligentes',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          color: AppColors.whiteTransparent85,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  
                  // Card de login
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackTransparent15,
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(cardPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Acesse sua Conta',
                              style: TextStyle(
                                fontSize: labelFontSize * 1.1,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: labelFontSize * 0.85,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            TextField(
                              controller: _emailController,
                              focusNode: _emailFocus,
                              decoration: InputDecoration(
                                hintText: 'e-mail',
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: AppColors.accentBlue,
                                ),
                                hintStyle: TextStyle(fontSize: hintFontSize),
                                filled: true,
                                fillColor: AppColors.grey,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.greyBorder,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.greyBorder,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.accentBlue,
                                    width: 2,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(fontSize: labelFontSize),
                              onSubmitted: (_) {
                                _passwordFocus.requestFocus();
                              },
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            
                            Text(
                              'Senha',
                              style: TextStyle(
                                fontSize: labelFontSize * 0.85,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            TextField(
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              decoration: InputDecoration(
                                hintText: 'senha',
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: AppColors.accentBlue,
                                ),
                                hintStyle: TextStyle(fontSize: hintFontSize),
                                filled: true,
                                fillColor: AppColors.grey,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.greyBorder,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.greyBorder,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.accentBlue,
                                    width: 2,
                                  ),
                                ),
                              ),
                              obscureText: true,
                              style: TextStyle(fontSize: labelFontSize),
                              onSubmitted: (_) => _handleLogin(),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return SizedBox(
                                    height: buttonHeight,
                                    width: double.infinity,
                                    child: Center(
                                      child: SizedBox(
                                        width: screenWidth * 0.08,
                                        height: screenWidth * 0.08,
                                        child: const CircularProgressIndicator(
                                          color: AppColors.accentBlue,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return SizedBox(
                                  height: buttonHeight,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.accentBlue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 2,
                                    ),
                                    child: Text(
                                      'Entrar na Conta',
                                      style: TextStyle(
                                        fontSize: labelFontSize * 0.95,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        color: AppColors.primaryDark
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
          LoginEvent(
            email: email,
            password: password,
          ),
        );
  }
}
