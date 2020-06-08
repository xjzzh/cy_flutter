import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _phoneNumber = TextEditingController();
  int _seconds = 0;
  String _verifyStr = '获取验证码';
  Timer _timer;

  @override
  void dispose() {
    _phoneNumber.dispose();
    _cancelTimer();
    super.dispose();
  }

  _startTimer() {
    _seconds = 30;

    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds--;
      _verifyStr = '$_seconds(s)';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

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
                  left: 120.0,
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
                        // errorText: _validate ? '手机号不能为空' : null,
                        // floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        //prefixIcon: Icon(Icons.phone_iphone, color: Colors.grey,)
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFc8a588))
                        ),
                        prefixText: "+86 ",
                        suffixIcon: _phoneNumber.text.isNotEmpty ? IconButton(
                          icon: Icon(Icons.clear,color: Colors.grey),
                          padding: new EdgeInsets.all(0.0),
                          splashColor: Colors.transparent,
                          onPressed: (){
                            setState(() {
                              _phoneNumber.clear();
                            });
                          },
                        )
                        : null,
                      ),
                      maxLines: 1,
                      maxLength: 11,
                      keyboardType: TextInputType.phone,  // 键盘只能是数字
                      //textInputAction: TextInputAction.next, // 键盘
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      controller: _phoneNumber,
                      validator: (val) => (val.isEmpty || val.length != 11) ? '请输入11位手机号码' : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: TextField(
                            //obscureText: true, // 密码
                            decoration: InputDecoration(
                              labelText: "验证码", 
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFc8a588))
                              ),
                            ),
                            maxLines: 1,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            // 只能输入数字
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                            ]
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            disabledColor: Colors.grey.withOpacity(.4),
                            color: Theme.of(context).backgroundColor,
                            onPressed: _seconds != 0 ? null : () {
                              if ((_formKey.currentState as FormState).validate()) {
                                setState(() {
                                  _startTimer();
                                });
                                print(_phoneNumber.text);
                              }
                            },
                            child: Text(
                              '$_verifyStr',
                              style: TextStyle(color:  Colors.white ),
                            ),
                          ),
                          
                        )
                      ],
                    )
                  ),

                ],
              )
            ),
          ],
        ),
      )
    );
  } 
}