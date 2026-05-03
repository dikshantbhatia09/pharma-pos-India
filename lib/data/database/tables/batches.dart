import 'package:drift/drift.dart';
import 'products.dart';
import 'suppliers.dart';

@DataClassName('BatchRow')
class Batches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id, onDelete: KeyAction.restrict)();
  TextColumn get batchNo => text()();
  DateTimeColumn get expiryDate => dateTime()();
  IntColumn get mrpPaise => integer()();
  IntColumn get ptrPaise => integer()();
  IntColumn get qtyOnHand => integer().withDefault(const Constant(0))();
  IntColumn get supplierId => integer().references(Suppliers, #id, onDelete: KeyAction.setNull).nullable()();
  IntColumn get purchaseInvoiceLineId => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [{productId, batchNo}];
}
