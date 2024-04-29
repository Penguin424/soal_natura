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
    return Form(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    _FormRegister(
                      text: 'Nombre',
                      hintText: 'Nombre',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Teléfono',
                      hintText: 'Teléfono',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _FormRegister(
                      text: 'Calle',
                      hintText: 'Calle',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Colonia',
                      hintText: 'Colonia',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Municipio',
                      hintText: 'Municipio',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Estado',
                      hintText: 'Estado',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
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
                    _FormRegister(
                      text: 'Cruces',
                      hintText: 'Cruces',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
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
                    _FormRegister(
                      text: 'Producto',
                      hintText: 'Producto',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
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
                Row(
                  children: [
                    _FormRegister(
                      text: 'Tipo de Venta',
                      hintText: 'Tipo de Venta',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Método de Pago',
                      hintText: 'Método de Pago',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _FormRegister(
                      text: 'Fecha de Entrega',
                      onChanged: (context) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Nota',
                      validator: (context) {
                        return;
                      },
                      onChanged: (context) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormRegister extends StatelessWidget {
  final String text;
  final String? hintText;
  final void Function(String) onChanged;
  final String? Function(String?) validator;
  final void Function(String)? additionalOnChange;

  const _FormRegister({
    required this.text,
    this.hintText,
    required this.onChanged,
    required this.validator,
    this.additionalOnChange,
  });

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
              hintText: hintText,
            ),
            onChanged: (value) {
              onChanged(value);
              if (additionalOnChange != null) {
                additionalOnChange!(value);
              }
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Ingrese la información correspondiente';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
