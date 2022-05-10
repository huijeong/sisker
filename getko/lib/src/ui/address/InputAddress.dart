
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getko/src/ui/app_properties.dart';

class InputAddress extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'add new shipping address',
          style: TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFDC054),
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
      ),
      body: Container(
        color: Color(0xffFDC054),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                  child: Container(
                  width: 350, height: 500,
                  //decoration: BoxDecoration(color: Colors.white70),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: TextFormField(
                          maxLength: 5,
                          decoration:
                          InputDecoration(
                              counterText: "",
                              labelStyle: TextStyle(fontFamily: "Cafe24", color: Colors.black, fontWeight: FontWeight.bold),
                            filled: true, fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10), labelText: '주문자 이름',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: TextFormField(
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              counterText: "",
                              labelStyle: TextStyle(fontFamily: "Cafe24", color: Colors.black, fontWeight: FontWeight.bold),
                              filled: true, fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10), labelText: '전화번호 ( - 빼고 입력)'
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: TextFormField(
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              counterText: "",
                              labelStyle: TextStyle(fontFamily: "Cafe24", color: Colors.black, fontWeight: FontWeight.bold),
                              filled: true, fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10), labelText: '우편번호'
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontFamily: "Cafe24", color: Colors.black, fontWeight: FontWeight.bold),
                              filled: true, fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10), labelText: '도로명 주소'
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontFamily: "Cafe24", color: Colors.black, fontWeight: FontWeight.bold),
                              filled: true, fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10), labelText: '상세주소'
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                //),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(child:
                  Icon(Icons.save, size: 23),
                  onTap: () {saveButton();},
                  ),
                  InkWell(child:
                  Text(" Save",
                      style: TextStyle(
                          fontSize: 18, fontFamily: "Montserrat",
                      )),
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text("저장되었습니다"),
                          actions: [
                            CupertinoDialogAction(
                            child: Text("확인"),
                            onPressed: () {Navigator.pop(context);}
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}

saveButton () {
  print("버튼 클릭됨");
}
