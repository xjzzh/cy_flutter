import 'dart:async';

import 'package:chuyi/view/user/code_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _phoneNumber = '';
  String _verifyCode = '';
  int coldDownSeconds = 0;
  Timer timer;
  bool _autoValidate = false;

  final _PhoneTextInputFormatter _phoneNumberFormatter = _PhoneTextInputFormatter();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  fetchSmsCode() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_phoneNumber.isEmpty || _phoneNumber.length != 13) {
      //_autoValidate = true;
      return showInSnackBar('请输入11位手机号码');
    }
    try {
      print('await 请求数据接口');
      setState(() {
        coldDownSeconds = 60;
      });
      coldDown();
    } catch(e) {
      showInSnackBar(e.toString());
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
          children: [
            Stack(
              children: <Widget>[
                Positioned(
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
                ),
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
                    maxLines: 1,
                    maxLength: 13,
                    //maxLengthEnforced: false, // 是否允许超过输入最大长度
                    validator: (String val) => (val.isEmpty || val.length != 11) ? '请输入11位手机号码' : null,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                      _phoneNumberFormatter,
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
                          maxLines: 1,
                          maxLength: 6,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
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
                  )
                ],
              )
            ),
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