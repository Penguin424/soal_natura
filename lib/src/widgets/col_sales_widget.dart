import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/models/almacen/producto_model.dart';
import 'package:soal_natura/src/models/ventas/venta_registro_form_model.dart';
import 'package:soal_natura/src/providers/almacen_provider.dart';
import 'package:soal_natura/src/providers/clientes_provider.dart';
import 'package:soal_natura/src/providers/direcciones_provider.dart';
import 'package:soal_natura/src/providers/ventas_provider.dart';
import 'package:soal_natura/src/widgets/tabla_formulario_ventas_widget.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ColSalesWiget extends ConsumerStatefulWidget {
  ColSalesWiget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ColSalesWigetState();
}

class _ColSalesWigetState extends ConsumerState<ColSalesWiget> {
  final DataGridController _dataGridController = DataGridController();
  int _cantidad = 1;
  TextEditingController _cantidadController = TextEditingController();

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
                              decoration: const InputDecoration(
                                hintText: 'Cantidad',
                              ),
                              controller: _cantidadController,
                              onChanged: (value) {
                                setState(() {
                                  _cantidad = int.tryParse(value) ?? 1;
                                });
                              },
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
                                              final String
                                                  productoSeleccionado =
                                                  options.elementAt(index);

                                              print(
                                                  "Contenido de almacen.productos: ${almacen.productos}");
                                              print(
                                                  "Producto seleccionado: $productoSeleccionado");

                                              final productoEncontrado =
                                                  almacen.productos.firstWhere(
                                                      (producto) =>
                                                          producto.nombre ==
                                                          productoSeleccionado,
                                                      orElse: () =>
                                                          ProductoModel());

                                              if (productoEncontrado != null) {
                                                print(
                                                    'Nombre del producto encontrado: ${productoEncontrado.nombre}');

                                                final cantidad = _cantidad ?? 1;
                                                final int cantidadTotal = ventas
                                                    .ventaRegistroForm
                                                    .productos!
                                                    .fold<int>(
                                                        0,
                                                        (previousValue,
                                                                element) =>
                                                            previousValue +
                                                            (element?.cantidad ??
                                                                0));
                                                final List<String>
                                                    productosExcedidos = [];
                                                bool excedeExistencia = false;

                                                if (cantidadTotal + cantidad >
                                                    2) {
                                                  for (final producto
                                                      in almacen.productos) {
                                                    final int
                                                        cantidadDisponible =
                                                        producto.existencia ??
                                                            0;

                                                    if (cantidadTotal +
                                                            cantidad >
                                                        cantidadDisponible) {
                                                      excedeExistencia = true;
                                                      productosExcedidos.add(
                                                          producto.nombre ??
                                                              '');
                                                    }
                                                  }
                                                }
                                                final cantidadTotalExistencias =
                                                    almacen.productos.fold<int>(
                                                        0,
                                                        (previousValue,
                                                                producto) =>
                                                            previousValue +
                                                            (producto
                                                                    .existencia ??
                                                                0));

                                                if (excedeExistencia) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        30,
                                                                    vertical:
                                                                        10),
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.info,
                                                                    size: 40,
                                                                    color: Colors
                                                                        .red),
                                                                SizedBox(
                                                                    width: 20),
                                                                Text(
                                                                  '¡Alerta!',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        30,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        content: const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 10),
                                                          child: Text(
                                                            'La cantidad total seleccionada excede la existencia de los productos',
                                                          ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            style: ButtonStyle(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .yellow),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              'Aceptar',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  final double? precioDouble =
                                                      productoEncontrado.precio
                                                          ?.toDouble();
                                                  final ventaProducto =
                                                      VentaRegistroFormModelProductos(
                                                    producto: productoEncontrado
                                                        .nombre,
                                                    existencia:
                                                        productoEncontrado
                                                                .existencia ??
                                                            0,
                                                    cantidad: cantidad,
                                                    precio: precioDouble,
                                                  );
                                                  ventas.agregarProductos(
                                                      ventaProducto);
                                                  _dataGridController
                                                      .notifyListeners();
                                                  _cantidadController.clear();
                                                }
                                              } else {
                                                print('Producto no encontrado');
                                              }
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
                    productos: ventas.ventaRegistroForm.productos,
                    dataGridController: _dataGridController,
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
                          "\$ ${ventas.ventaRegistroForm.subTotal}",
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
                          "\$ ${ventas.ventaRegistroForm.total}",
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
  ConsumerState<ConsumerStatefulWidget> createState() =>
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
