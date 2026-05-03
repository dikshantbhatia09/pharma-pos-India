import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../theme/tokens/tokens.dart';
import '../../features/bill/bill_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/inventory/inventory_screen.dart';
import '../../features/more/more_screen.dart';
import '../../features/design_system/design_system_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) => _RootShell(child: child),
        routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          GoRoute(path: '/bill', builder: (_, __) => const BillScreen()),
          GoRoute(path: '/inventory', builder: (_, __) => const InventoryScreen()),
          GoRoute(path: '/more', builder: (_, __) => const MoreScreen()),
        ],
      ),
      if (kDebugMode)
        GoRoute(path: '/dev/design-system', builder: (_, __) => const DesignSystemScreen()),
    ],
  );
});

class _RootShell extends StatelessWidget {
  const _RootShell({required this.child});
  final Widget child;

  static const _items = [
    (icon: LucideIcons.home, label: 'Home', path: '/home'),
    (icon: LucideIcons.receipt, label: 'Bill', path: '/bill'),
    (icon: LucideIcons.package2, label: 'Inventory', path: '/inventory'),
    (icon: LucideIcons.menu, label: 'More', path: '/more'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border, width: AppBorder.w)),
        ),
        child: SafeArea(top: false, child: SizedBox(height: 64,
          child: Row(children: [
            for (final item in _items) Expanded(child: _NavItem(
              icon: item.icon, label: item.label,
              active: location == item.path, onTap: () => context.go(item.path),
            )),
          ]),
        )),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, required this.active, required this.onTap});
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.textPrimary : AppColors.textTertiary;
    return GestureDetector(
      onTap: onTap, behavior: HitTestBehavior.opaque,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: AppSpace.s4),
        Text(label, style: AppText.caption.copyWith(color: color)),
      ]),
    );
  }
}
