class PayCard {
  String id = "";
  String number = "";
  String name = "";
  String year = "";
  String month = "";

  PayCard(this.id, this.number, this.name, this.year, this.month);

  @override
  String toString() {
    return '$id / $number / $name';
  }
}
