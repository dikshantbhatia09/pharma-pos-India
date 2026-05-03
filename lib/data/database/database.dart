import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/products.dart';
import 'tables/suppliers.dart';
import 'tables/batches.dart';
import 'tables/purchases.dart';
import 'tables/sales.dart';
import 'tables/app_settings.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Products, Suppliers, Batches,
  PurchaseInvoices, PurchaseInvoiceLines,
  SalesInvoices, SalesInvoiceLines,
  AppSettings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();

      await customStatement('CREATE INDEX IF NOT EXISTS idx_products_name ON products(name)');
      await customStatement('CREATE INDEX IF NOT EXISTS idx_products_generic ON products(generic_name)');
      await customStatement('CREATE INDEX IF NOT EXISTS idx_products_barcode ON products(barcode)');
      await customStatement('CREATE INDEX IF NOT EXISTS idx_batches_product ON batches(product_id)');
      await customStatement('CREATE INDEX IF NOT EXISTS idx_batches_expiry ON batches(expiry_date)');
      await customStatement('CREATE INDEX IF NOT EXISTS idx_batches_qty ON batches(qty_on_hand)');
      await customStatement('CREATE INDEX IF NOT EXISTS idx_sales_date ON sales_invoices(invoice_date)');
      await customStatement('CREATE INDEX IF NOT EXISTS idx_sales_lines_invoice ON sales_invoice_lines(sales_invoice_id)');
      await customStatement('CREATE INDEX IF NOT EXISTS idx_sales_lines_batch ON sales_invoice_lines(batch_id)');

      await customStatement('''
        CREATE VIRTUAL TABLE IF NOT EXISTS products_fts USING fts5(
          name, generic_name, barcode,
          content='products', content_rowid='id',
          tokenize="porter unicode61", prefix='2 3 4'
        )
      ''');

      await customStatement('''
        CREATE TRIGGER IF NOT EXISTS products_ai AFTER INSERT ON products BEGIN
          INSERT INTO products_fts(rowid, name, generic_name, barcode)
          VALUES (new.id, new.name, new.generic_name, new.barcode);
        END
      ''');
      await customStatement('''
        CREATE TRIGGER IF NOT EXISTS products_ad AFTER DELETE ON products BEGIN
          INSERT INTO products_fts(products_fts, rowid, name, generic_name, barcode)
          VALUES ('delete', old.id, old.name, old.generic_name, old.barcode);
        END
      ''');
      await customStatement('''
        CREATE TRIGGER IF NOT EXISTS products_au AFTER UPDATE ON products BEGIN
          INSERT INTO products_fts(products_fts, rowid, name, generic_name, barcode)
          VALUES ('delete', old.id, old.name, old.generic_name, old.barcode);
          INSERT INTO products_fts(rowid, name, generic_name, barcode)
          VALUES (new.id, new.name, new.generic_name, new.barcode);
        END
      ''');
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'pharma_pos.sqlite'));
    return NativeDatabase.createInBackground(file, logStatements: false);
  });
}
