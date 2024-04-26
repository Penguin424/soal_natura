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
              _IconHeard(), // Agrega el widget _IconHeard aquí
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
                labelStyle: TextStyle(
                  color: Colors.black,
                )
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(14.0),
                // ),
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
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                      color: Colors.black,
                    )),
              ),
              onPressed: () {
                if (login.formKey.currentState!.validate()) {
                  // Si el formulario es válido, realiza la acción de inicio de sesión
                  login.handleLogin(context);
                } else {
                  // Si el formulario no es válido, muestra un diálogo indicando el error
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.info,
                                        size: 40, color: Colors.red),
                                    SizedBox(width: 20),
                                    Text(
                                      '¡Alerta!',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            content: const Text(
                                'El correo o la contraseña están incorrectos',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            actions: <Widget>[
                              TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.yellow),
                                ),
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Aceptar',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10)
                                        ])),
                              ),
                            ],
                          ));
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconHeard extends StatelessWidget {
  const _IconHeard();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          size: 130,
          color: Colors.white,
          shadows: [BoxShadow(color: Colors.white, blurRadius: 50)],
        ),
      ),
    );
  }
}
