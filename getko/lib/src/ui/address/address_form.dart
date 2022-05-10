import 'package:getko/src/ui/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:getko/src/ui/address/add_address_page.dart';

class AddAddressForm extends StatefulWidget {
  final PayAddress address;
  final Function addAddress;
  AddAddressForm({Key? key, required this.address, required this.addAddress})
      : super(key: key);
  @override
  _AddAddressFormState createState() =>
      _AddAddressFormState(this.address, this.addAddress);
}

class _AddAddressFormState extends State<AddAddressForm> {
  PayAddress address;
  Function addAddress;
  _AddAddressFormState(this.address, this.addAddress);
  bool? _ischecked = false;

  TextEditingController cardName = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardName.text = address.cardName;
    address1.text = address.address1;
    address2.text = address.address2;
    postalCode.text = address.postalCode;
    phone.text = address.phone;
    email.text = address.email;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Address',
                  style: TextStyle(fontSize: 12, color: darkGrey),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Container(
                  padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.orange, width: 2)),
                    color: Colors.orange[100],
                  ),
                  child: TextField(
                    controller: cardName,
                    onChanged: (_) {
                      addAddress(PayAddress(
                          address.id,
                          cardName.text,
                          address1.text,
                          address2.text,
                          postalCode.text,
                          phone.text,
                          email.text));
                    },
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                      hintStyle:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextField(
              controller: phone,
              onChanged: (_) {
                addAddress(PayAddress(address.id, cardName.text, address1.text,
                    address2.text, postalCode.text, phone.text, email.text));
              },
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Phone', labelText: 'PN'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextField(
              controller: email,
              onChanged: (_) {
                addAddress(PayAddress(address.id, cardName.text, address1.text,
                    address2.text, postalCode.text, phone.text, email.text));
              },
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Email'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextField(
              controller: address1,
              onChanged: (_) {
                addAddress(PayAddress(address.id, cardName.text, address1.text,
                    address2.text, postalCode.text, phone.text, email.text));
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: '하위 상세주소'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextField(
              controller: address2,
              onChanged: (_) {
                addAddress(PayAddress(address.id, cardName.text, address1.text,
                    address2.text, postalCode.text, phone.text, email.text));
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: '시,도'),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: Container(
              padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.red, width: 1)),
                color: Colors.white,
              ),
              child: TextField(
                controller: postalCode,
                onChanged: (_) {
                  addAddress(PayAddress(
                      address.id,
                      cardName.text,
                      address1.text,
                      address2.text,
                      postalCode.text,
                      phone.text,
                      email.text));
                },
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Postal code'),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: _ischecked,
                onChanged: (value) {setState(() {
                  _ischecked = value;
                });},
              ),
              Text('Add this to address bookmark')
            ],
          )
        ],
      ),
    );
  }
}
