import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _formKey = GlobalKey<FormState>();
  Model model = Model();

  @override
  Widget build(BuildContext context){
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
                      color: Colors.yellow[200],
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    width: 70.0,
                    height: 20.0,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    MyTextFormField(
                      hintText: '手机号码',
                      validator: (String val) => (val.isEmpty || val.length != 11) ? '请输入11位手机号码' : null,
                      onSaved: (String value) {
                        model.phoneNumber = value;
                      },
                      prefixText: '+86 ',
                      maxLength: 11,
                    ),
                    MyTextFormField(
                      hintText: '验证码',
                      validator: (String value) {
                        if (value.isEmpty || value.length < 6) {
                          return '请输入验证码';
                        }
                        _formKey.currentState.save();
                        return null;
                      },
                      onSaved: (String value) {
                        model.verifyCode = value;
                      },
                      maxLength: 6,
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Result(model: this.model)
                          //   )
                          // );
                        }
                      },
                      child: Text(
                        '登 录',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ),
            )
            
          ],
        ),
      )
    );
  }
}

class Model {
  String phoneNumber;
  String verifyCode;

  Model({this.phoneNumber, this.verifyCode});
}

class MyTextFormField extends StatelessWidget{
  final String hintText;
  final String prefixText;
  final Function validator;
  final Function onSaved;
  final bool isVerifyCode;
  final bool isPhoneNumber;
  final int maxLength;

  MyTextFormField({
    this.hintText,
    this.prefixText,
    this.validator,
    this.onSaved,
    this.maxLength,
    this.isVerifyCode = false,
    this.isPhoneNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: hintText,
          prefixText: prefixText,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFc8a588))
          ),
        ),
        obscureText: isVerifyCode ? true : false,
        validator: validator,
        onSaved: onSaved,
        maxLines: 1,
        maxLength: maxLength,
        keyboardType:isPhoneNumber ? TextInputType.phone : TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}