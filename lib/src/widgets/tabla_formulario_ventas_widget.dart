import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/models/ventas/venta_registro_form_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class TablaFormularioVentasWidget extends ConsumerStatefulWidget {
  const TablaFormularioVentasWidget({
    super.key,
    required DataGridController dataGridController,
    required this.productos,
  }) : _dataGridController = dataGridController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TablaFormularioVentasWidgetState();

  final DataGridController _dataGridController;
  final List<VentaRegistroFormModelProductos?>? productos;
}

class _TablaFormularioVentasWidgetState
    extends ConsumerState<TablaFormularioVentasWidget> {
  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      showCheckboxColumn: true,
      selectionMode: SelectionMode.multiple,
      allowSorting: true,
      allowFiltering: true,
      controller: widget._dataGridController,
      columns: [
        GridColumn(
          sortIconPosition: ColumnHeaderIconPosition.start,
          columnName: 'ID',
          label: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'ID',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        GridColumn(
          sortIconPosition: ColumnHeaderIconPosition.start,
          columnName: 'PRODUCTO',
          label: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'PRODUCTO',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        GridColumn(
          sortIconPosition: ColumnHeaderIconPosition.start,
          columnName: 'CANTIDAD',
          label: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'CANTIDAD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        GridColumn(
          sortIconPosition: ColumnHeaderIconPosition.start,
          columnName: 'PRECIO',
          label: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'PRECIO',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      columnWidthMode: ColumnWidthMode.fill,
      source: TablaFormularioVentasSource(
        productos: widget.productos,
      ),
    );
  }
}

class TablaFormularioVentasSource extends DataGridSource {
  List<DataGridRow> _productos = [];

  @override
  List<DataGridRow> get rows => _productos;

  TablaFormularioVentasSource({
    required List<VentaRegistroFormModelProductos?>? productos,
  }) {
    _productos = productos!.map<DataGridRow>(
      (e) {
        return DataGridRow(
          cells: [
            DataGridCell<int>(
              columnName: 'ID',
              value: productos!.indexWhere(
                      (element) => element!.producto == e!.producto) +
                  1,
            ),

            DataGridCell<String>(
              columnName: 'PRODUCTO',
              value: e!.producto,
            ),
            DataGridCell<int>(
              columnName: 'CANTIDAD',
              value: e.cantidad,
            ),
            DataGridCell<double>(
              columnName: 'PRECIO',
              value: e.precio,
            ),

            // DataGridCell<Widget>(
            //   columnName: 'acciones',
            //   value: SizedBox(
            //     child: ElevatedButton(
            //       onPressed: () {},
            //       child: const Text('Editar'),
            //     ),
            //   ),
            // ),
          ],
        );
      },
    ).toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          // if (dataGridCell.columnName == 'acciones') {
          //   return Container(
          //     alignment: Alignment.centerLeft,
          //     padding: const EdgeInsets.all(16.0),
          //     child: dataGridCell.value,
          //   );
          // }

          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16.0),
            child: Text(dataGridCell.value.toString()),
          );
        },
      ).toList(),
    );
  }
}
