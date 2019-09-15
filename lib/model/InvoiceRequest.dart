
class InvoiceRequest {
  final int amount;
  final int currencyCode;
  final String description;
  final String number;
  final String recipient;

  InvoiceRequest(this.amount, this.currencyCode, this.description, this.number,
      this.recipient);

  /*
  SessionRequest.fromJson(Map<String, dynamic> json):
        name = json['name'],
        email = json['email'];
*/

  Map<String, dynamic> toJson() =>
      {
        'amount': amount,
        'currencyCode': currencyCode,
        'description': description,
        'number': number,
        'recipient': recipient
      };
}
