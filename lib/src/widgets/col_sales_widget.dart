import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/models/cliente_search_model.dart';
import 'package:soal_natura/src/providers/clientes_provider.dart';
import 'package:soal_natura/src/providers/direcciones_provider.dart';
import 'package:soal_natura/src/providers/ventas_provider.dart';
import 'package:soal_natura/src/utils/http_utils.dart';
import 'package:soal_natura/src/widgets/tabla_formulario_ventas_widget.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ColSalesWiget extends ConsumerStatefulWidget {
  const ColSalesWiget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ColSalesWigetState();
}

class _ColSalesWigetState extends ConsumerState<ColSalesWiget> {
  @override
  Widget build(BuildContext context) {
    final ventas = ref.watch(ventasPoriver);
    final direcciones = ref.watch(direccionesProvider);
    final clientes = ref.watch(clientesProvider);
    final size = MediaQuery.of(context).size;

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
                      onChanged: (value) {
                        clientes.clienteRegistroForm.nombre = value;

                        clientes.clienteRegistroForm =
                            clientes.clienteRegistroForm;
                      },
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.red,
                              ),
                              Text('Telefono'),
                            ],
                          ),
                          Autocomplete<ClienteSearchModel>(
                            fieldViewBuilder: (
                              context,
                              textEditingController,
                              focusNode,
                              onFieldSubmitted,
                            ) {
                              return TextFormField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  hintText: 'Telefono',
                                ),
                                onChanged: (value) {
                                  clientes.clienteRegistroForm.telefono = value;
                                  clientes.clienteRegistroForm =
                                      clientes.clienteRegistroForm;

                                  clientes.handleSearchCliente(value);
                                },
                              );
                            },
                            optionsBuilder: (textEditingValue) {
                              return clientes.clientesSearch
                                  .map(
                                    (cliente) => cliente,
                                  )
                                  .toList();
                            },
                            optionsViewBuilder: (context, onSelected, options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: size.width * 0.45,
                                  child: Material(
                                    elevation: 4,
                                    color: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 5,
                                            offset: Offset(1, 2),
                                          ),
                                        ],
                                      ),
                                      constraints: BoxConstraints(
                                        maxHeight: size.height * 0.3,
                                        maxWidth: size.width * 0.1,
                                      ),
                                      child: ListView.builder(
                                        itemCount: options.length,
                                        itemBuilder: (context, index) {
                                          final cliente = clientes
                                              .clientesSearch
                                              .firstWhere((cliente) {
                                            final opts = options.toList();

                                            return cliente.id == opts[index].id;
                                          });

                                          return ListTile(
                                            leading: const Icon(Icons.person),
                                            title: Text(cliente.nombre!),
                                            subtitle: Text(cliente.telefono!),
                                            trailing: Text(cliente
                                                .ventas!.length
                                                .toString()),
                                            onTap: () {
                                              onSelected(cliente);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _FormRegister(
                      text: 'Calle',
                      hintText: 'Calle',
                      onChanged: (value) {
                        direcciones.direccionRegistroForm.domicilio = value;
                        direcciones.direccionRegistroForm =
                            direcciones.direccionRegistroForm;
                      },
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Colonia',
                      hintText: 'Colonia',
                      onChanged: (value) {
                        direcciones.direccionRegistroForm.colonia = value;
                        direcciones.direccionRegistroForm =
                            direcciones.direccionRegistroForm;
                      },
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Municipio',
                      hintText: 'Municipio',
                      onChanged: (value) {
                        direcciones.direccionRegistroForm.ciudad = value;
                        direcciones.direccionRegistroForm =
                            direcciones.direccionRegistroForm;
                      },
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Estado',
                      hintText: 'Estado',
                      onChanged: (value) {
                        direcciones.direccionRegistroForm.estado = value;
                        direcciones.direccionRegistroForm =
                            direcciones.direccionRegistroForm;
                      },
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
                      text: "Codigo Postal",
                      onChanged: (value) {
                        direcciones.direccionRegistroForm.cp = value;
                        direcciones.direccionRegistroForm =
                            direcciones.direccionRegistroForm;
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Cruces',
                      hintText: 'Cruces',
                      onChanged: (value) {
                        direcciones.direccionRegistroForm.cruces = value;
                        direcciones.direccionRegistroForm =
                            direcciones.direccionRegistroForm;
                      },
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
                      onChanged: (value) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SfDataGridTheme(
                  data: SfDataGridThemeData(
                    headerColor: Theme.of(context).colorScheme.primary,
                    filterIconColor: Colors.white,
                    sortIconColor: Colors.white,
                    rowHoverColor: Colors.orange[100],
                    selectionColor: Colors.orange[200],
                  ),
                  child: TablaFormularioVentasWidget(
                    productos: ventas.ventaRegistroForm.productos,
                    dataGridController: DataGridController(),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    _FormRegister(
                      text: 'Tipo de Venta',
                      hintText: 'Tipo de Venta',
                      onChanged: (value) {},
                      validator: (context) {
                        return null;
                      },
                    ),
                    const SizedBox(width: 20),
                    _FormRegister(
                      text: 'Método de Pago',
                      hintText: 'Método de Pago',
                      onChanged: (value) {},
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
                      onChanged: (value) {},
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
                      onChanged: (value) {},
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    print(
                      ventas.ventaRegistroForm.toJson(),
                    );
                    print(
                      clientes.clienteRegistroForm.toJson(),
                    );
                  },
                  child: const Text('Subir Venta'),
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
  final void Function(String value) onChanged;
  final String? Function(String?) validator;

  const _FormRegister({
    required this.text,
    this.hintText,
    required this.onChanged,
    required this.validator,
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
            onChanged: onChanged,
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
