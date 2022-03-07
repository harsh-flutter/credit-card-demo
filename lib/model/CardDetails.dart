class CardDetails {
  CardDetails({
    this.name,
    this.expiryDate,
    this.cardHolder,
    this.cardNumber,
    this.cardCategory,
  });

  String name;
  String expiryDate;
  String cardHolder;
  String cardNumber;
  String cardCategory;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (name != null) {
      json[r'name'] = name;
    }
    if (expiryDate != null) {
      json[r'expiryDate'] = expiryDate;
    }
    if (cardHolder != null) {
      json[r'cardHolder'] = cardHolder;
    }
    if (cardNumber != null) {
      json[r'cardNumber'] = cardNumber;
    }
    if (cardCategory != null) {
      json[r'cardCategory'] = cardCategory;
    }
    return json;
  }

  static CardDetails fromJson(Map<String, dynamic> json) => json == null
      ? null
      : CardDetails(
          name: json[r'name'],
          expiryDate: json[r'expiryDate'],
          cardHolder: json[r'cardHolder'],
          cardNumber: json[r'cardNumber'],
          cardCategory: json[r'cardCategory'],
        );

  static List<CardDetails> listFromJson(
    List<dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) =>
      json == null || json.isEmpty
          ? true == emptyIsNull
              ? null
              : <CardDetails>[]
          : json
              .map((dynamic value) => CardDetails.fromJson(value))
              .toList(growable: true == growable);

  static Map<String, CardDetails> mapFromJson(Map<String, dynamic> json) {
    final map = <String, CardDetails>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) => map[key] = CardDetails.fromJson(value));
    }
    return map;
  }

  static Map<String, List<CardDetails>> mapListFromJson(
    Map<String, dynamic> json, {
    bool emptyIsNull,
    bool growable,
  }) {
    final map = <String, List<CardDetails>>{};
    if (json?.isNotEmpty == true) {
      json.forEach((key, value) {
        map[key] = CardDetails.listFromJson(
          value,
          emptyIsNull: emptyIsNull,
          growable: growable,
        );
      });
    }
    return map;
  }
}
