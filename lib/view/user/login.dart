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
  bool _validate = false;

  @override
  void dispose() {
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _phoneNumber.text = '';
    _phoneNumber.addListener(() {
      setState(() {
        _validate = (_phoneNumber.text.isEmpty || double.tryParse(_phoneNumber.text) == null)
        ? false : true;
      });
    });
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
                        errorText: _validate ? '手机号不能为空' : null,
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
                      keyboardType: TextInputType.phone,
                      //textInputAction: TextInputAction.next, // 键盘
                      inputFormatters: [
                        BlacklistingTextInputFormatter(RegExp('^[0-9]{15}')),
                        LengthLimitingTextInputFormatter(11)
                      ],
                      controller: _phoneNumber,
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
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6)
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: PartialConsumeComponent<CountDownTimeModel>(
                            model: CountDownTimeModel(60, 1),
                            builder: (context, model,_) => FlatButton(
                              disabledColor: Colors.grey.withOpacity(.4),
                              color: Theme.of(context).backgroundColor,
                              onPressed: !_validate || !model.isFinish ? null : () async {
                                model.startCountDown();
                                print(_phoneNumber.text);
                              },
                              child: Text(
                                model.isFinish ? '获取验证码' : '${model.currentTime.toString()}',
                                style: TextStyle(color: model.isFinish ? Colors.white : Colors.grey[100]),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
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