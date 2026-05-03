import 'package:drift/drift.dart';
import 'products.dart';
import 'batches.dart';

@DataClassName('SalesInvoiceRow')
class SalesInvoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get invoiceNo => text().unique()();
  DateTimeColumn get invoiceDate => dateTime().withDefault(currentDateAndTime)();
  TextColumn get customerName => text().nullable()();
  TextColumn get customerPhone => text().nullable()();
  TextColumn get prescriptionRef => text().nullable()();
  IntColumn get subtotalPaise => integer().withDefault(const Constant(0))();
  IntColumn get discountPaise => integer().withDefault(const Constant(0))();
  IntColumn get gstPaise => integer().withDefault(const Constant(0))();
  IntColumn get totalPaise => integer().withDefault(const Constant(0))();
  TextColumn get paymentMode => text().withDefault(const Constant('cash'))();
  TextColumn get status => text().withDefault(const Constant('completed'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('SalesInvoiceLineRow')
class SalesInvoiceLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get salesInvoiceId => integer().references(SalesInvoices, #id, onDelete: KeyAction.cascade)();
  IntColumn get productId => integer().references(Products, #id, onDelete: KeyAction.restrict)();
  IntColumn get batchId => integer().references(Batches, #id, onDelete: KeyAction.restrict)();
  IntColumn get qty => integer()();
  IntColumn get mrpPaise => integer()();
  IntColumn get gstBp => integer()();
  IntColumn get lineTotalPaise => integer()();
}
