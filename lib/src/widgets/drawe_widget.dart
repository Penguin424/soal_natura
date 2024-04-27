import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/utils/preferences_utils.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    PreferencesUtils.getString("username")
                        .substring(1, 3)
                        .toUpperCase(),
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ExpansionTile(
              leading: const Icon(
                Icons.point_of_sale_sharp,
                color: Colors.black,
              ),
              title: const Text(
                'Ventas',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.app_registration_rounded,
                    color: Colors.black,
                  ),
                  title: const Text('Registro de Ventas'),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/ventas/registro",
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ExpansionTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: const Text(
                'Clientes',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.person_search_rounded,
                    color: Colors.black,
                  ),
                  title: const Text('Clientes registrados'),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      "/ventas/registro",
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
