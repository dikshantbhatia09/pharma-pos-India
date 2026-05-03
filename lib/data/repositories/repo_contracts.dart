class RepoException implements Exception {
  const RepoException(this.code, this.message);
  final String code;
  final String message;

  static const expired = RepoException('expired', 'Batch is expired.');
  static const priceAboveMrp = RepoException('price_above_mrp', 'Sale price exceeds MRP.');
  static const prescriptionRequired = RepoException('prescription_required',
    'Prescription reference required for Schedule H/H1/X items.');
  static const insufficientStock = RepoException('insufficient_stock',
    'Not enough stock in the selected batch.');

  @override
  String toString() => 'RepoException($code): $message';
}
