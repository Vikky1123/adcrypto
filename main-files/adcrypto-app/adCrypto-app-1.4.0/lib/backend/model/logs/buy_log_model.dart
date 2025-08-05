class BuyLogModel {
  final BuyLogModelData data;

  BuyLogModel({
    required this.data,
  });

  factory BuyLogModel.fromJson(Map<String, dynamic> json) => BuyLogModel(
    data: BuyLogModelData.fromJson(json["data"]),
  );
}

class BuyLogModelData {
  final Map<String, String> statusCode;
  final List<BuyLog> buyLog;

  BuyLogModelData({
    required this.statusCode,
    required this.buyLog,
  });

  factory BuyLogModelData.fromJson(Map<String, dynamic> json) => BuyLogModelData(
    statusCode: Map.from(json["status_code"]).map((k, v) => MapEntry<String, String>(k, v)),
    buyLog: List<BuyLog>.from(json["buy_log"].map((x) => BuyLog.fromJson(x))),
  );
}

class BuyLog {
  final int id;
  final String type;
  final int userId;
  final int userWalletId;
  final String paymentGatewayId;
  final String trxId;
  final String amount;
  final String percentCharge;
  final String fixedCharge;
  final String totalCharge;
  final String totalPayable;
  final String availableBalance;
  final String remark;
  final Details details;
  final String submitUrl;
  final List<Requirement> requirements;
  final dynamic rejectReason;
  final int status;
  final DateTime createdAt;

  BuyLog({
    required this.id,
    required this.type,
    required this.userId,
    required this.userWalletId,
    required this.paymentGatewayId,
    required this.trxId,
    required this.amount,
    required this.percentCharge,
    required this.fixedCharge,
    required this.totalCharge,
    required this.totalPayable,
    required this.availableBalance,
    required this.remark,
    required this.details,
    required this.submitUrl,
    required this.requirements,
    required this.rejectReason,
    required this.status,
    required this.createdAt,
  });

  factory BuyLog.fromJson(Map<String, dynamic> json) => BuyLog(
    id: json["id"],
    type: json["type"],
    userId: json["user_id"],
    userWalletId: json["user_wallet_id"],
    paymentGatewayId: json["payment_gateway_id"],
    trxId: json["trx_id"],
    amount: json["amount"],
    percentCharge: json["percent_charge"],
    fixedCharge: json["fixed_charge"],
    totalCharge: json["total_charge"],
    totalPayable: json["total_payable"],
    availableBalance: json["available_balance"],
    remark: json["remark"],
    details: Details.fromJson(json["details"]),
    submitUrl: json["submit_url"],
    requirements: List<Requirement>.from((json["requirements"] ?? []).map((x) => Requirement.fromJson(x))),
    rejectReason: json["reject_reason"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class Details {
  // final List<InputValue> inputValues;
  final DetailsData data;
  // final GatewayResponse gatewayResponse;
  final String userRecord;

  Details({
    // required this.inputValues,
    required this.data,
    // required this.gatewayResponse,
    required this.userRecord,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    // inputValues: List<InputValue>.from(json["input_values"].map((x) => InputValue.fromJson(x))),
    data: DetailsData.fromJson(json["data"]),
    // gatewayResponse: GatewayResponse.fromJson(json["gateway_response"]),
    userRecord: json["user_record"] ?? "",
  );
}

class DetailsData {
  final Wallet wallet;
  final Network network;
  final PaymentMethod paymentMethod;
  final double amount;
  final double exchangeRate;
  final double minMaxRate;
  final double fixedCharge;
  final double percentCharge;
  final double totalCharge;
  final double payableAmount;
  final double willGet;

  DetailsData({
    required this.wallet,
    required this.network,
    required this.paymentMethod,
    required this.amount,
    required this.exchangeRate,
    required this.minMaxRate,
    required this.fixedCharge,
    required this.percentCharge,
    required this.totalCharge,
    required this.payableAmount,
    required this.willGet,
  });

  factory DetailsData.fromJson(Map<String, dynamic> json) => DetailsData(
    wallet: Wallet.fromJson(json["wallet"]),
    network: Network.fromJson(json["network"]),
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
    amount: json["amount"].toDouble(),
    exchangeRate: json["exchange_rate"].toDouble(),
    minMaxRate: json["min_max_rate"].toDouble(),
    fixedCharge: double.parse(json["fixed_charge"].toString()),
    percentCharge: json["percent_charge"].toDouble(),
    totalCharge: json["total_charge"].toDouble(),
    payableAmount: json["payable_amount"].toDouble(),
    willGet: json["will_get"].toDouble(),
  );
}

class Network {
  final String name;
  final int arrivalTime;
  final String fees;

  Network({
    required this.name,
    required this.arrivalTime,
    required this.fees,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    name: json["name"],
    arrivalTime: json["arrival_time"],
    fees: json["fees"],
  );
}

class PaymentMethod {
  final int id;
  final String name;
  final String code;
  final String alias;
  final String rate;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.code,
    required this.alias,
    required this.rate,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    alias: json["alias"],
    rate: json["rate"],
  );
}

class Wallet {
  final String type;
  final int walletId;
  final int currencyId;
  final String name;
  final String code;
  final String rate;
  final String balance;

  Wallet({
    required this.type,
    required this.walletId,
    required this.currencyId,
    required this.name,
    required this.code,
    required this.rate,
    required this.balance,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    type: json["type"],
    walletId: json["wallet_id"],
    currencyId: json["currency_id"],
    name: json["name"],
    code: json["code"],
    rate: json["rate"],
    balance: json["balance"],
  );
}


class Requirement {
  final String type;
  final String label;
  final String placeholder;
  final String name;
  final bool required;
  final Validation validation;

  Requirement({
    required this.type,
    required this.label,
    required this.placeholder,
    required this.name,
    required this.required,
    required this.validation,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
    type: json["type"] ?? "",
    label: json["label"] ?? "",
    placeholder: json["placeholder"] ?? "",
    name: json["name"] ?? "",
    required: json["required"] ?? false,
    validation: Validation.fromJson(json["validation"]),
  );
}

class Validation {
  final dynamic min;
  final dynamic max;
  final bool required;

  Validation({
    required this.min,
    required this.max,
    required this.required,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    min: json["min"] ?? "",
    max: json["max"] ?? "",
    required: json["required"] ?? false,
  );
}


















//
// class GatewayResponse {
//   final String id;
//   final String object;
//   final dynamic afterExpiration;
//   final dynamic allowPromotionCodes;
//   final int amountSubtotal;
//   final int amountTotal;
//   final AutomaticTax automaticTax;
//   final dynamic billingAddressCollection;
//   final String cancelUrl;
//   final dynamic clientReferenceId;
//   final dynamic clientSecret;
//   final dynamic consent;
//   final dynamic consentCollection;
//   final int created;
//   final String currency;
//   final dynamic currencyConversion;
//   final List<dynamic> customFields;
//   final CustomText customText;
//   final dynamic customer;
//   final String customerCreation;
//   final CustomerDetails customerDetails;
//   final String customerEmail;
//   final int expiresAt;
//   final dynamic invoice;
//   final InvoiceCreation invoiceCreation;
//   final bool livemode;
//   final dynamic locale;
//   final List<dynamic> metadata;
//   final String mode;
//   final dynamic paymentIntent;
//   final dynamic paymentLink;
//   final String paymentMethodCollection;
//   final PaymentMethodConfigurationDetails paymentMethodConfigurationDetails;
//   final List<dynamic> paymentMethodOptions;
//   final List<String> paymentMethodTypes;
//   final String paymentStatus;
//   final PhoneNumberCollection phoneNumberCollection;
//   final dynamic recoveredFrom;
//   final dynamic setupIntent;
//   final dynamic shippingAddressCollection;
//   final dynamic shippingCost;
//   final dynamic shippingDetails;
//   final List<dynamic> shippingOptions;
//   final String status;
//   final dynamic submitType;
//   final dynamic subscription;
//   final String successUrl;
//   final TotalDetails totalDetails;
//   final String uiMode;
//   final String url;
//
//   GatewayResponse({
//     required this.id,
//     required this.object,
//     required this.afterExpiration,
//     required this.allowPromotionCodes,
//     required this.amountSubtotal,
//     required this.amountTotal,
//     required this.automaticTax,
//     required this.billingAddressCollection,
//     required this.cancelUrl,
//     required this.clientReferenceId,
//     required this.clientSecret,
//     required this.consent,
//     required this.consentCollection,
//     required this.created,
//     required this.currency,
//     required this.currencyConversion,
//     required this.customFields,
//     required this.customText,
//     required this.customer,
//     required this.customerCreation,
//     required this.customerDetails,
//     required this.customerEmail,
//     required this.expiresAt,
//     required this.invoice,
//     required this.invoiceCreation,
//     required this.livemode,
//     required this.locale,
//     required this.metadata,
//     required this.mode,
//     required this.paymentIntent,
//     required this.paymentLink,
//     required this.paymentMethodCollection,
//     required this.paymentMethodConfigurationDetails,
//     required this.paymentMethodOptions,
//     required this.paymentMethodTypes,
//     required this.paymentStatus,
//     required this.phoneNumberCollection,
//     required this.recoveredFrom,
//     required this.setupIntent,
//     required this.shippingAddressCollection,
//     required this.shippingCost,
//     required this.shippingDetails,
//     required this.shippingOptions,
//     required this.status,
//     required this.submitType,
//     required this.subscription,
//     required this.successUrl,
//     required this.totalDetails,
//     required this.uiMode,
//     required this.url,
//   });
//
//   factory GatewayResponse.fromJson(Map<String, dynamic> json) => GatewayResponse(
//     id: json["id"],
//     object: json["object"],
//     afterExpiration: json["after_expiration"],
//     allowPromotionCodes: json["allow_promotion_codes"],
//     amountSubtotal: json["amount_subtotal"],
//     amountTotal: json["amount_total"],
//     automaticTax: AutomaticTax.fromJson(json["automatic_tax"]),
//     billingAddressCollection: json["billing_address_collection"],
//     cancelUrl: json["cancel_url"],
//     clientReferenceId: json["client_reference_id"],
//     clientSecret: json["client_secret"],
//     consent: json["consent"],
//     consentCollection: json["consent_collection"],
//     created: json["created"],
//     currency: json["currency"],
//     currencyConversion: json["currency_conversion"],
//     customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
//     customText: CustomText.fromJson(json["custom_text"]),
//     customer: json["customer"],
//     customerCreation: json["customer_creation"],
//     customerDetails: CustomerDetails.fromJson(json["customer_details"]),
//     customerEmail: json["customer_email"],
//     expiresAt: json["expires_at"],
//     invoice: json["invoice"],
//     invoiceCreation: InvoiceCreation.fromJson(json["invoice_creation"]),
//     livemode: json["livemode"],
//     locale: json["locale"],
//     metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
//     mode: json["mode"],
//     paymentIntent: json["payment_intent"],
//     paymentLink: json["payment_link"],
//     paymentMethodCollection: json["payment_method_collection"],
//     paymentMethodConfigurationDetails: PaymentMethodConfigurationDetails.fromJson(json["payment_method_configuration_details"]),
//     paymentMethodOptions: List<dynamic>.from(json["payment_method_options"].map((x) => x)),
//     paymentMethodTypes: List<String>.from(json["payment_method_types"].map((x) => x)),
//     paymentStatus: json["payment_status"],
//     phoneNumberCollection: PhoneNumberCollection.fromJson(json["phone_number_collection"]),
//     recoveredFrom: json["recovered_from"],
//     setupIntent: json["setup_intent"],
//     shippingAddressCollection: json["shipping_address_collection"],
//     shippingCost: json["shipping_cost"],
//     shippingDetails: json["shipping_details"],
//     shippingOptions: List<dynamic>.from(json["shipping_options"].map((x) => x)),
//     status: json["status"],
//     submitType: json["submit_type"],
//     subscription: json["subscription"],
//     successUrl: json["success_url"],
//     totalDetails: TotalDetails.fromJson(json["total_details"]),
//     uiMode: json["ui_mode"],
//     url: json["url"],
//   );
// }
//
// class AutomaticTax {
//   final bool enabled;
//   final dynamic liability;
//   final dynamic status;
//
//   AutomaticTax({
//     required this.enabled,
//     required this.liability,
//     required this.status,
//   });
//
//   factory AutomaticTax.fromJson(Map<String, dynamic> json) => AutomaticTax(
//     enabled: json["enabled"],
//     liability: json["liability"],
//     status: json["status"],
//   );
// }
//
// class CustomText {
//   final dynamic afterSubmit;
//   final dynamic shippingAddress;
//   final dynamic submit;
//   final dynamic termsOfServiceAcceptance;
//
//   CustomText({
//     required this.afterSubmit,
//     required this.shippingAddress,
//     required this.submit,
//     required this.termsOfServiceAcceptance,
//   });
//
//   factory CustomText.fromJson(Map<String, dynamic> json) => CustomText(
//     afterSubmit: json["after_submit"],
//     shippingAddress: json["shipping_address"],
//     submit: json["submit"],
//     termsOfServiceAcceptance: json["terms_of_service_acceptance"],
//   );
// }
//
// class CustomerDetails {
//   final dynamic address;
//   final String email;
//   final dynamic name;
//   final dynamic phone;
//   final String taxExempt;
//   final dynamic taxIds;
//
//   CustomerDetails({
//     required this.address,
//     required this.email,
//     required this.name,
//     required this.phone,
//     required this.taxExempt,
//     required this.taxIds,
//   });
//
//   factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
//     address: json["address"],
//     email: json["email"],
//     name: json["name"],
//     phone: json["phone"],
//     taxExempt: json["tax_exempt"],
//     taxIds: json["tax_ids"],
//   );
// }
//
// class InvoiceCreation {
//   final bool enabled;
//   final InvoiceData invoiceData;
//
//   InvoiceCreation({
//     required this.enabled,
//     required this.invoiceData,
//   });
//
//   factory InvoiceCreation.fromJson(Map<String, dynamic> json) => InvoiceCreation(
//     enabled: json["enabled"],
//     invoiceData: InvoiceData.fromJson(json["invoice_data"]),
//   );
// }
//
// class InvoiceData {
//   final dynamic accountTaxIds;
//   final dynamic customFields;
//   final dynamic description;
//   final dynamic footer;
//   final dynamic issuer;
//   final List<dynamic> metadata;
//   final dynamic renderingOptions;
//
//   InvoiceData({
//     required this.accountTaxIds,
//     required this.customFields,
//     required this.description,
//     required this.footer,
//     required this.issuer,
//     required this.metadata,
//     required this.renderingOptions,
//   });
//
//   factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
//     accountTaxIds: json["account_tax_ids"],
//     customFields: json["custom_fields"],
//     description: json["description"],
//     footer: json["footer"],
//     issuer: json["issuer"],
//     metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
//     renderingOptions: json["rendering_options"],
//   );
// }
//
// class PaymentMethodConfigurationDetails {
//   final String id;
//   final dynamic parent;
//
//   PaymentMethodConfigurationDetails({
//     required this.id,
//     required this.parent,
//   });
//
//   factory PaymentMethodConfigurationDetails.fromJson(Map<String, dynamic> json) => PaymentMethodConfigurationDetails(
//     id: json["id"],
//     parent: json["parent"],
//   );
// }
//
// class PhoneNumberCollection {
//   final bool enabled;
//
//   PhoneNumberCollection({
//     required this.enabled,
//   });
//
//   factory PhoneNumberCollection.fromJson(Map<String, dynamic> json) => PhoneNumberCollection(
//     enabled: json["enabled"],
//   );
// }
//
// class TotalDetails {
//   final int amountDiscount;
//   final int amountShipping;
//   final int amountTax;
//
//   TotalDetails({
//     required this.amountDiscount,
//     required this.amountShipping,
//     required this.amountTax,
//   });
//
//   factory TotalDetails.fromJson(Map<String, dynamic> json) => TotalDetails(
//     amountDiscount: json["amount_discount"],
//     amountShipping: json["amount_shipping"],
//     amountTax: json["amount_tax"],
//   );
// }
//
// class InputValue {
//   final String type;
//   final String label;
//   final String name;
//   final bool required;
//   final Validation validation;
//   final String value;
//
//   InputValue({
//     required this.type,
//     required this.label,
//     required this.name,
//     required this.required,
//     required this.validation,
//     required this.value,
//   });
//
//   factory InputValue.fromJson(Map<String, dynamic> json) => InputValue(
//     type: json["type"],
//     label: json["label"],
//     name: json["name"],
//     required: json["required"],
//     validation: Validation.fromJson(json["validation"]),
//     value: json["value"],
//   );
// }
//
// class Validation {
//   final String max;
//   final List<String> mimes;
//   final String min;
//   final List<dynamic> options;
//   final bool required;
//
//   Validation({
//     required this.max,
//     required this.mimes,
//     required this.min,
//     required this.options,
//     required this.required,
//   });
//
//   factory Validation.fromJson(Map<String, dynamic> json) => Validation(
//     max: json["max"],
//     mimes: List<String>.from(json["mimes"].map((x) => x)),
//     min: json["min"],
//     options: List<dynamic>.from(json["options"].map((x) => x)),
//     required: json["required"],
//   );
// }