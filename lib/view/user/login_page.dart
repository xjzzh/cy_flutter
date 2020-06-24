import 'dart:async';
import 'package:chuyi/util/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chuyi/view/user/code_button.dart';
import 'package:chuyi/model/api_data.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

final API _api = API();

class _LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _phoneNumber = '';
  String _verifyCode = '';
  int coldDownSeconds = 0;
  Timer timer;
  bool _autoValidate = false;
  Login _loginRes;

  final _PhoneTextInputFormatter _phoneNumberFormatter = _PhoneTextInputFormatter();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  fetchSmsCode() async {
    _formKey.currentState.save();
    FocusScope.of(context).requestFocus(FocusNode());
    if (_phoneNumber.isEmpty || _phoneNumber.length != 13) {
      //_autoValidate = true;
      return showInSnackBar('请输入11位手机号码');
    }
    try {
      _api.sendSMSCode(_phoneNumber.replaceAll(new RegExp(r"\s+\b|\b\s"), ""), (value) {
        _loginRes = value;
      });
      if (_loginRes.code == 1) {
        setState(() {
          coldDownSeconds = 30;
        });
        coldDown();
        showInSnackBar(_loginRes.message);
      } else {
        showInSnackBar(_loginRes.message);
      }
    } catch(e) {
      showInSnackBar(e.toString());
    }
  }

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true;
    } else {
      form.save();
      print({_phoneNumber,_verifyCode});
    }
  }

  coldDown() {
    timer = Timer(Duration(seconds: 1), (){
      setState(() {
        --coldDownSeconds;
      });
      coldDown();
    });
  }

  @override dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
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
        dragStartBehavior: DragStartBehavior.down,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                /* Positioned(
                  left: 120.0,
                  top: 12.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow[200],
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    width: 70.0,
                    height: 25.0,
                  ),
                ), */
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "登录 厨易",
                    style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    cursorColor: Color(0xFFFB7101),
                    decoration: InputDecoration(
                      labelText: '手机号码',
                      hintText: '请输入手机号码',
                      prefixText: '+86 ',
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFc8a588)
                        )
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    onSaved: (val) {
                      _phoneNumber = val;
                    },
                    //maxLengthEnforced: false, // 是否允许超过输入最大长度
                    validator: (String val) => (val.isEmpty || val.length != 13) ? '请输入11位手机号码' : null,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                      _phoneNumberFormatter,
                      LengthLimitingTextInputFormatter(13)
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      //color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: <Widget>[
                        TextFormField(
                          cursorColor: Color(0xFFFB7101),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "验证码", 
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFc8a588)
                              )
                            ),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6)
                          ],
                          onSaved: (val) {
                            _verifyCode = val;
                          },
                          validator: (val) => (val.isEmpty || val.length != 6) ? '请输入验证码' : null,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CodeButton(
                            onPressed: fetchSmsCode, 
                            coldDownSeconds: coldDownSeconds,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 45.0,
                    margin: EdgeInsets.only(top:20),
                    /* decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff374ABE),
                          Color(0xff64B6FF)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ), */
                    child: RaisedButton(
                      onPressed: _handleSubmitted,
                      color: Color(0xFFFB7101),
                      elevation: 0,
                      textColor: Colors.white,
                      child: Text('登 录',style: TextStyle(fontSize: 16)),
                    ),
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                '未注册手机验证后自动注册',
                style: TextStyle(color: Colors.grey),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Theme.of(context).dividerColor.withAlpha(20),
                    height: 1,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text('其他登录方式', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  )
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Theme.of(context).dividerColor.withAlpha(20),
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    width: 70,
                    height: 35,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Image.asset(
                      'assets/images/login/wechat.png',
                      fit: BoxFit.contain,
                    ),                    
                  ),
                ),
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    width: 70,
                    height: 35,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Image.asset(
                      'assets/images/login/apple.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    width: 70,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/login/google.png',
                      fit: BoxFit.contain,
                    ),                    
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: new Text.rich(
                new TextSpan(
                  text: '注册或登录厨易表示您已阅读并同意 ',
                  style: new TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400
                  ),
                  children: [
                    new TextSpan(
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          
                        },
                      text: '会员条款',
                      style: new TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFFFB7101),
                        fontWeight: FontWeight.w400,
                      )
                    ),
                    new TextSpan(
                      text: ' 和 ',
                      style: new TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                      )
                    ),
                    new TextSpan(
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                        },
                      text: '隐私政策',
                      style: new TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFFFB7101),
                        fontWeight: FontWeight.w400,
                      )
                    ),
                  ]
                )
              ),
            )
          ],
        ),
      )
    );
  }
}

class _PhoneTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();
    var selectionIndex = newValue.selection.end;
    var usedSubstringIndex = 0;
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ' ');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newTextLength >= 8) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 7) + ' ');
      if (newValue.selection.end >= 7) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/// https://github.com/flutter/gallery/blob/master/lib/demos/material/text_field_demo.dart