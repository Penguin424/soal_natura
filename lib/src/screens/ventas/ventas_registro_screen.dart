import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/widgets/drawe_widget.dart';

class VentasRegistroScreen extends ConsumerStatefulWidget {
  const VentasRegistroScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VentasRegistroScreenState();
}

class _VentasRegistroScreenState extends ConsumerState<VentasRegistroScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Resgistro de ventas'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        constraints: BoxConstraints(
          minHeight: size.height * 0.3,
          minWidth: size.width,
        ),
        child: const Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "FORMULARIO DE REGISTRO DE VENTAS AQUI",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
