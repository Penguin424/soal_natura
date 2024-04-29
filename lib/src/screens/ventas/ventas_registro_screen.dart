import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/widgets/col_sales_widget.dart';
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
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black,
              width: 0.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5,
                offset: Offset(1, 2),
              ),
            ],
          ),
          constraints: BoxConstraints(
            minHeight: size.height * 0.3,
            minWidth: size.width,
          ),
          child: const ColSalesWiget(),
        ),
      ),
    );
  }
}
