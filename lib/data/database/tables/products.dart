import 'package:drift/drift.dart';

@DataClassName('ProductRow')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get genericName => text().nullable()();
  TextColumn get manufacturer => text().nullable()();
  TextColumn get hsn => text().nullable()();
  IntColumn get gstBp => integer().withDefault(const Constant(1200))();
  TextColumn get schedule => text().nullable()();
  TextColumn get barcode => text().nullable()();
  IntColumn get mrpPaise => integer()();
  TextColumn get packSize => text().nullable()();
  TextColumn get unit => text().withDefault(const Constant('pc'))();
  BoolColumn get prescriptionRequired => boolean().withDefault(const Constant(false))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
