class OrderRequestModel {
  final String orderName;
  final String buyerAddress;

  OrderRequestModel({required this.orderName, required this.buyerAddress});
  Map<String, dynamic> getJson() {
    return {"orderName": orderName, "buyerAddress": buyerAddress};
  }

  factory OrderRequestModel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return OrderRequestModel(
      orderName: json["orderName"],
      buyerAddress: json["buyerAddress"]
    );
  }
}
