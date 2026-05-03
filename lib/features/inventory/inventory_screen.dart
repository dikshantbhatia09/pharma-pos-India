import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../shared/widgets/widgets.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: const AppEmptyState(
        icon: LucideIcons.package2,
        title: 'Inventory — coming in module 5',
        subtitle: 'Product master, batches, expiry views land here.',
      ),
    );
  }
}
