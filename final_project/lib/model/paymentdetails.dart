class PaymentDetails {
  dynamic paymentId;
  dynamic name;
  dynamic ammount;
  dynamic item;
  dynamic payemntDate;
  dynamic medium;
  dynamic refId;
  PaymentDetails({
    this.ammount,
    this.item,
    this.paymentId,
    this.name,
    this.payemntDate,
    this.medium,
    this.refId,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      paymentId: json['id'],
      name: json['name'],
      ammount: json['amount'],
      item: json['item'],
      payemntDate: json['created_at'],
      medium: json['medium'],
      refId: json['ref_id'],
    );
  }
}
