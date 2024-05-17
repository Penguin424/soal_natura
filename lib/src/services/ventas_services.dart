import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/models/ventas/venta_registro_form_model.dart';

class VentasService extends ChangeNotifier {
  final _ventaRegistroForm = VentaRegistroFormModel(
    productos: [],
    subTotal: 0,
    total: 0,
  );

  TextEditingController cantidadController = TextEditingController();

  VentasService() {
    cantidadController = TextEditingController();
  }

  VentaRegistroFormModel get ventaRegistroForm => _ventaRegistroForm;

  set ventaRegistroForm(VentaRegistroFormModel ventaRegistroForm) {
    _ventaRegistroForm.productos = ventaRegistroForm.productos;
    _ventaRegistroForm.fechaEntrega = ventaRegistroForm.fechaEntrega;
    _ventaRegistroForm.idPedido = ventaRegistroForm.idPedido;
    _ventaRegistroForm.subTotal = ventaRegistroForm.subTotal;
    _ventaRegistroForm.total = ventaRegistroForm.total;
    _ventaRegistroForm.estatus = ventaRegistroForm.estatus;
    _ventaRegistroForm.nota = ventaRegistroForm.nota;
    _ventaRegistroForm.de = ventaRegistroForm.de;
    _ventaRegistroForm.a = ventaRegistroForm.a;
    _ventaRegistroForm.formaDePago = ventaRegistroForm.formaDePago;
    _ventaRegistroForm.cliente = ventaRegistroForm.cliente;
    _ventaRegistroForm.direccion = ventaRegistroForm.direccion;
    _ventaRegistroForm.vendedor = ventaRegistroForm.vendedor;
    notifyListeners();
  }

  // Método para agregar producto
  void agregarProductoSeleccionado(
    VentaRegistroFormModelProductos producto,
    int existenciaDisponible,
    BuildContext context,
  ) {
    if (producto.cantidad! > 0) {
      int cantidadTotal = _ventaRegistroForm.productos!
          .where(
            (p) => p!.producto == producto.producto,
          )
          .fold(
            0,
            (sum, p) => sum + p!.cantidad!,
          );

      int cantidadAgregada = cantidadTotal + producto.cantidad!;

      if (cantidadAgregada > existenciaDisponible) {
        // Mostrar alerta de cantidad insuficiente
        showDialog(
          context: context,
          builder: (
            context,
          ) =>
              AlertDialog(
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      size: 40,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '¡Alerta!',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            content: const Text(
              'La cantidad total seleccionada excede la existencia de los productos.',
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Colors.yellow,
                  ),
                ),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pop();
                },
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    shadows: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        _ventaRegistroForm.productos?.add(
          producto,
        );
        calcularSubtotalYTotal();
        notifyListeners();
      }
    }
  }

// Método para agregar producto desde la interfaz
  void agregarProductoDesdeInterfaz(
    String nombreProducto,
    double precioProducto,
    int cantidadProducto,
    int existenciaDisponible,
    BuildContext context,
  ) {
    VentaRegistroFormModelProductos nuevoProducto =
        VentaRegistroFormModelProductos.fromJson(
      {
        'producto': nombreProducto,
        'precio': precioProducto,
        'cantidad': cantidadProducto,
      },
    );

    agregarProductoSeleccionado(
      nuevoProducto,
      existenciaDisponible,
      context,
    );
  }

  // Método para calcular el subtotal y el total
  void calcularSubtotalYTotal() {
    double subtotal = 0;
    for (var producto in _ventaRegistroForm.productos!) {
      subtotal += producto!.precio! * producto.cantidad!;
    }
    double total = subtotal + 20;
    _ventaRegistroForm.subTotal = subtotal;
    _ventaRegistroForm.total = total;

    notifyListeners();
  }

  // Método para actualizar la cantidad de un producto existente
  void actualizarCantidadProducto(
    String productName,
    int newQuantity,
  ) {
    final existingProductIndex = _ventaRegistroForm.productos?.indexWhere(
      (
        existingProduct,
      ) =>
          existingProduct?.producto == productName,
    );

    if (existingProductIndex != null && existingProductIndex >= 0) {
      _ventaRegistroForm.productos![existingProductIndex]!.cantidad =
          newQuantity;
      calcularSubtotalYTotal();

      notifyListeners();
    }
  }

  void actualizarProductos(
    List<VentaRegistroFormModelProductos?>? nuevosProductos,
  ) {
    _ventaRegistroForm.productos = nuevosProductos;
    notifyListeners();
  }

  // Método para manejar el cambio en la cantidad de productos
  void handleCantidadChanged(
    String productName,
    int newQuantity,
  ) {
    if (newQuantity > 0) {
      actualizarCantidadProducto(
        productName,
        newQuantity,
      );
    }
  }
}

final ventasServiceProvider = ChangeNotifierProvider<VentasService>(
  (
    ref,
  ) {
    return VentasService();
  },
);
