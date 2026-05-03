import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../shared/widgets/widgets.dart';

class BillScreen extends StatelessWidget {
  const BillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New bill')),
      body: const AppEmptyState(
        icon: LucideIcons.receipt,
        title: 'Billing — coming in module 6',
        subtitle: 'Build order: settings → masters → purchase → inventory → billing → reports.',
      ),
    );
  }
}
