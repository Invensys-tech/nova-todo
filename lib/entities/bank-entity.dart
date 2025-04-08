class BankEntity {
  int id;
  String accountHolder;
  int accountNumber;
  String accountBank;
  String branch;
  String accountType;
  num balance;

  BankEntity({
    required this.accountHolder,
    required this.accountNumber,
    required this.accountBank,
    required this.branch,
    required this.accountType,
    required this.balance,
    required this.id,
  });

  factory BankEntity.fromJson(Map<String, dynamic> json) {
    return BankEntity(
      id: json['id'] as int,
      accountHolder: json['accountHolder'] as String,
      accountNumber: json['accountNumber'] as int,
      accountBank: json['accountBank'] as String,
      branch: json['branch'] as String,
      accountType: json['accountType'] as String,
      balance: json['balance'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accountHolder'] = accountHolder;
    data['accountNumber'] = accountNumber;
    data['accountBank'] = accountBank;
    data['branch'] = branch;
    data['accountType'] = accountType;
    data['balance'] = balance;
    return data;
  }
}
