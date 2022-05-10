class PayOrder {
  String orderNo;
  String totalPaid;
  String orderDate;
  String? orderStatus;
  List<PayOrderItem> items;

  PayOrder(this.orderNo, this.totalPaid, this.orderDate, this.items,
      [this.orderStatus]);
}

class PayOrderItem {
  String productName;
  String productImage;
  String price;
  String quantity;
  String seller;

  PayOrderItem(this.productName, this.productImage, this.price, this.quantity,
      this.seller);
}
