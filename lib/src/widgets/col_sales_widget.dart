import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/providers/almacen_provider.dart';
import 'package:soal_natura/src/providers/clientes_provider.dart';
import 'package:soal_natura/src/providers/direcciones_provider.dart';
import 'package:soal_natura/src/providers/ventas_provider.dart';
import 'package:soal_natura/src/services/ventas_services.dart';
import 'package:soal_natura/src/widgets/tabla_formulario_ventas_widget.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/ventas/venta_registro_form_model.dart';

class ColSalesWiget extends ConsumerStatefulWidget {
  const ColSalesWiget({Key? key}) : super(key: key);

  @override
  ConsumerState<ColSalesWiget> createState() => _ColSalesWidgetState();
}

class _ColSalesWidgetState extends ConsumerState<ColSalesWiget> {
  @override
  void initState() {
    super.initState();

    final almacen = ref.read(almacenProvider);

    Future.delayed(Duration.zero, () async {
      await almacen.handleGetProductos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ventas = ref.watch(ventasPoriver);
    final direcciones = ref.watch(direccionesProvider);
    final clientes = ref.watch(clientesProvider);
    final almacen = ref.watch(almacenProvider);
    final size = MediaQuery.of(context).size;
    final ventasService = ref.watch(ventasServiceProvider);

    final List<VentaRegistroFormModelProductos?> productos =
        ventasService.ventaRegistroForm.productos ?? [];

    final double? subtotal = ventasService.ventaRegistroForm.subTotal;
    final double? total = ventasService.ventaRegistroForm.total;

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
                    const AutocompleteSearchCliente(),
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
                              controller: ventasService.cantidadController,
                              decoration: const InputDecoration(
                                hintText: 'Cantidad',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Productos'),
                          Autocomplete<String>(
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
                                  hintText: 'Producto',
                                ),
                                onChanged: (value) {},
                              );
                            },
                            optionsBuilder: (textEditingValue) {
                              final filteredProducts = almacen.productos.where(
                                  (producto) => producto.nombre!
                                      .toLowerCase()
                                      .contains(
                                          textEditingValue.text.toLowerCase()));
                              return filteredProducts
                                  .map((producto) => producto.nombre!)
                                  .toList();
                            },
                            optionsViewBuilder: (context, onSelected, options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: size.width * 0.7,
                                  child: Material(
                                    elevation: 4,
                                    color: Colors.transparent,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 5),
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
                                        minWidth: size.width * 0.7,
                                      ),
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        itemCount: options.length,
                                        itemBuilder: (context, index) {
                                          final producto = almacen.productos
                                              .firstWhere((producto) =>
                                                  producto.nombre ==
                                                  options.elementAt(index));

                                          return ListTile(
                                            leading: const Icon(
                                              Icons.shopping_bag,
                                            ),
                                            title: Text(producto.nombre!),
                                            subtitle: Text(
                                              "\$ ${producto.precio}",
                                            ),
                                            trailing: Text(
                                              "Existencia: ${producto.existencia.toString()}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {
                                              String? nombreProducto =
                                                  producto.nombre;
                                              double precioProducto =
                                                  producto.precio!.toDouble();
                                              int cantidadProducto = int.parse(
                                                ventasService
                                                    .cantidadController.text,
                                              );
                                              int existenciaDisponible =
                                                  producto.existencia!;

                                              ventasService
                                                  .agregarProductoDesdeInterfaz(
                                                nombreProducto!,
                                                precioProducto,
                                                cantidadProducto,
                                                existenciaDisponible,
                                                context,
                                              );
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
                    )
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
                    productos: productos,
                    dataGridController: DataGridController(),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Sub total",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$ $subtotal",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        Text(
                          "Envio",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$ 20",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$ $total",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
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
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
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
      ),
    );
  }
}

class AutocompleteSearchCliente extends ConsumerStatefulWidget {
  const AutocompleteSearchCliente({Key? key}) : super(key: key);

  @override
  ConsumerState<AutocompleteSearchCliente> createState() =>
      _AutocompleteSearchClienteState();
}

class _AutocompleteSearchClienteState
    extends ConsumerState<AutocompleteSearchCliente> {
  @override
  Widget build(BuildContext context) {
    final clientes = ref.watch(clientesProvider);
    final size = MediaQuery.of(context).size;

    return Expanded(
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
          Autocomplete<String>(
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
                  clientes.clienteRegistroForm = clientes.clienteRegistroForm;

                  clientes.handleSearchCliente(value);
                },
              );
            },
            optionsBuilder: (textEditingValue) {
              return clientes.clientesSearch
                  .map(
                    (cliente) => cliente.telefono!,
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
                          final cliente =
                              clientes.clientesSearch.firstWhere((cliente) {
                            final opts = options.toList();

                            return cliente.telefono == opts[index];
                          });

                          return ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(cliente.nombre!),
                            subtitle: Text(cliente.telefono!),
                            trailing: Text(cliente.ventas!.length.toString()),
                            onTap: () {
                              onSelected(cliente.telefono!);
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
    );
  }
}
