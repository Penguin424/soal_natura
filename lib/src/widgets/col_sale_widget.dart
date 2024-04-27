import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColSalesWiget extends ConsumerStatefulWidget {
  const ColSalesWiget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ColSalesWigetState();
}

class _ColSalesWigetState extends ConsumerState<ColSalesWiget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  _FormRegister(
                    text: 'Nombre',
                    hinText: 'Nombre',
                  ),
                  SizedBox(width: 20),
                  _FormRegister(
                    text: 'Teléfono',
                    hinText: 'Teléfono',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  _FormRegister(
                    text: 'Calle',
                    hinText: 'Calle',
                  ),
                  SizedBox(width: 20),
                  _FormRegister(
                    text: 'Colonia',
                    hinText: 'Colonia',
                  ),
                  SizedBox(width: 20),
                  _FormRegister(
                    text: 'Municipio',
                    hinText: 'Municipio',
                  ),
                  SizedBox(width: 20),
                  _FormRegister(
                    text: 'Estado',
                    hinText: 'Estado',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.red,
                              ),
                              Text('Código Postal'),
                            ],
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Código Postal',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const _FormRegister(
                    text: 'Cruces',
                    hinText: 'Cruces',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.red,
                              ),
                              Text('Cantidad'),
                            ],
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Cantidad',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const _FormRegister(
                    text: 'Producto',
                    hinText: 'Producto',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.amber,
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  _FormRegister(
                    text: 'Tipo de Venta',
                    hinText: 'Tipo de Venta',
                  ),
                  SizedBox(width: 20),
                  _FormRegister(
                    text: 'Método de Pago',
                    hinText: 'Método de Pago',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  _FormRegister(
                    text: 'Fecha de Entrega',
                  ),
                  SizedBox(width: 20),
                  _FormRegister(
                    text: 'Nota',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormRegister extends StatelessWidget {
  final String text;
  final String? hinText;

  const _FormRegister({required this.text, this.hinText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.red,
              ),
              Text(text),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: hinText,
            ),
          ),
        ],
      ),
    );
  }
}
