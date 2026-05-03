import 'package:drift/drift.dart';
import 'products.dart';
import 'suppliers.dart';

@DataClassName('PurchaseInvoiceRow')
class PurchaseInvoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get supplierId => integer().references(Suppliers, #id, onDelete: KeyAction.restrict)();
  TextColumn get invoiceNo => text()();
  DateTimeColumn get invoiceDate => dateTime()();
  IntColumn get subtotalPaise => integer().withDefault(const Constant(0))();
  IntColumn get gstPaise => integer().withDefault(const Constant(0))();
  IntColumn get totalPaise => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('PurchaseInvoiceLineRow')
class PurchaseInvoiceLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get purchaseInvoiceId => integer().references(PurchaseInvoices, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer().references(Products, #id, onDelete: KeyAction.restrict)();
  TextColumn get batchNo => text()();
  DateTimeColumn get expiryDate => dateTime()();
  IntColumn get qty => integer()();
  IntColumn get freeQty => integer().withDefault(const Constant(0))();
  IntColumn get ptrPaise => integer()();
  IntColumn get mrpPaise => integer()();
  IntColumn get gstBp => integer()();
  IntColumn get lineTotalPaise => integer()();
}
