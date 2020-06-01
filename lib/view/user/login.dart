import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget{
  final _text = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    GlobalKey _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: new IconButton(
          icon: Icon(CupertinoIcons.clear_thick_circled, size: 30, color: Colors.grey),
          padding: new EdgeInsets.all(0.0),
          splashColor: Colors.transparent, // remove ripple effect
          onPressed: (){Navigator.pop(context,true);}
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  right: 120.0,
                  top: 12.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    width: 70.0,
                    height: 20.0,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "登录厨易",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    child: TextFormField(
                      //cursorColor: Colors.yellow,
                      decoration: InputDecoration(
                        labelText: "手机号码", 
                        // floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        //prefixIcon: Icon(Icons.phone_iphone, color: Colors.grey,)
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFc8a588))
                        ),
                        prefixText: "+86 ",
                      ),
                      keyboardType: TextInputType.phone,
                      //textInputAction: TextInputAction.next,
                      inputFormatters: [
                        BlacklistingTextInputFormatter(RegExp('^[0-9]{15}')),
                        LengthLimitingTextInputFormatter(11)
                      ],
                      controller: _text,
                      validator: (value) {
                        return value.trim().length > 0 ? null : '手机号不能为空';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "验证码", 
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFc8a588))
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            color: Theme.of(context).backgroundColor,
                            textColor: Colors.white,
                            elevation: 0,
                            onPressed: (){

                            },
                            child: Text('获取验证码'),
                          )
                        )
                      ],
                    )
                  )
                ],
              )
            ),
            RaisedButton(
              onPressed: () {
              },
              child: Text('Submit'),
            )
          ],
        ),
      )
    );
  } 
}