import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/providers/login_provider.dart';
import 'package:soal_natura/src/services/login_service.dart';
import 'package:soal_natura/src/utils/preferences_utils.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (PreferencesUtils.getBool('isLogged')) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final login = ref.watch(loginProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.primary,
              ],
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SafeArea(
                          child: Column(
                            children: [
                              Text(
                                'BIENVENIDO A SOAL NATURA',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Inicia sesion',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          // height: size.height * 0.5,
                          width: size.width,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 3.0,
                                offset: Offset(
                                  0.0,
                                  5.0,
                                ),
                                spreadRadius: 3.0,
                              )
                            ],
                          ),
                          child: _createFormLogin(
                            context,
                            size,
                            login,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Form _createFormLogin(
    BuildContext context,
    Size size,
    LoginService login,
  ) {
    return Form(
      key: login.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            onChanged: (value) {
              login.setIdentifier(value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingresa tu correo';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Usuario',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            obscureText: true,
            onChanged: (value) {
              login.setPassword(value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingresa tu contraseña';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Contraseña',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0),
              ),
            ),
            onPressed: () {
              login.handleLogin(context);
            },
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
