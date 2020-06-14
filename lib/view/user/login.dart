import 'package:chuyi/model/count_down_time.dart';
import 'package:chuyi/widget/partial_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _phoneNumber = TextEditingController();
  final _verifyCode = TextEditingController();
  
  @override
  void dispose() {
    _phoneNumber.dispose();
    _verifyCode.dispose();
    super.dispose();
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
                    "登录厨易",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
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
                          flex: 4,
                          child: TextFormField(
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
                            ],
                            controller: _verifyCode,
                            validator: (val) => (val.isEmpty || val.length != 4) ? '请输入11位手机号码' : null,
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          flex: 3,
                          child: PartialConsumeComponent<CountDownTimeModel>(
                            model: CountDownTimeModel(30, 1),
                            builder: (context, model, _) => FlatButton(
                              disabledColor: Colors.grey.withOpacity(.4),
                              color: Theme.of(context).backgroundColor,
                              onPressed: !model.isFinish ? null : () async{
                                if ((_formKey.currentState as FormState).validate()) {
                                  model.startCountDown();
                                }
                              },
                              child: Text(
                                model.isFinish ? '获取验证码' : '${model.currentTime.toString()}',
                                style: TextStyle(color: model.isFinish ? Colors.white : Colors.grey[100]),
                              ),
                            ),
                          )
                        ), 
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){

                    },
                    child: new Text(
                      "登  录",
                      style: new TextStyle(fontSize: 16.0),
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