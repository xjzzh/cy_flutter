# cy_app_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Flutter Colors `AARRGGBB`

```Dart
new Container(color: const Color(0xff2980b9)); /// AA:transparency RR:Red  GG:Green    BB:Blue
```

AA hex values:

```js
100% - FF
95% - F2
90% - E6
85% - D9
80% - CC
75% - BF
70% - B3
65% - A6
60% - 99
55% - 8C
50% - 80
45% - 73
40% - 66
35% - 59
30% - 4D
25% - 40
20% - 33
15% - 26
10% - 1A
5% - 0D
0% - 00
```

`primarySwatch`

- Create a custom:

```Dart
MaterialColor myColor = MaterialColor(0xFF880E4F, color);
```

- Create a map:

```Dart
Map<int, Color> color = {
    50:Color.fromRGBO(4,131,184, .1),
    100:Color.fromRGBO(4,131,184, .2),
    200:Color.fromRGBO(4,131,184, .3),
    300:Color.fromRGBO(4,131,184, .4),
    400:Color.fromRGBO(4,131,184, .5),
    500:Color.fromRGBO(4,131,184, .6),
    600:Color.fromRGBO(4,131,184, .7),
    700:Color.fromRGBO(4,131,184, .8),
    800:Color.fromRGBO(4,131,184, .9),
    900:Color.fromRGBO(4,131,184, 1),
}
```

- Use:

```Dart
primarySwatch: myColor
```

### 添加本地图片

- root/目录新建文件夹

- `pubspec.yaml`:

```xml
flutter:
    uses-material-design: true
    assets:
    - assets/images/
```

#### Card Image Radius(top-left-radius,top-right-radius)

[ShapeBorder](https://api.flutter.dev/flutter/painting/ShapeBorder-class.html)

```js
    clipBehavior: Clip.antiAliasWithSaveLayer // 4.0
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
    ),
    shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
    ),
    shape: StadiumBorder(
        side: BorderSide(
            color: Colors.black,
            width: 2.0,
        ),
    )
```

#### clear Image Cache

```dart
    PaintingBinding.instance.imageCache.clear();
    FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        placeholder: '../',
        image: ''
    )
```

#### light/dark

```dart
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
    );
```

#### Container

```dart
    Container(
        transform: Matrix4.translationValues(0.0, -45.0, 0.0),
        child: ...
    )
```

#### Pages

```dart
Scaffold // 路由页骨架
Stack // 允许子组件堆叠
Positioned // 根据Stack的四个角来确定子组件的位置
Expanded // 用于展开Row，Column或Flex的子child的Widget。必须是[Row]，[Column]或[Flex]的后代
// 使用Expanded可以使[Row]，[Column]或[Flex]的子项扩展以填充主轴中的可用空间（例如，水平用[Row]或垂直用[Column]）。
```

#### TextOverflow

```dart
    Flexible(
        child: Text(
            ...
            overflow: TextOverflow.ellipsis,
        )
    )
```

#### 环境变量

配置环境变量:

```shell
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter upgrade
flutter pub get
```

查看：

```shell
echo $PATH
```

删除：

```shell
vi ~/.bash_profile ====> 删除后：
source ~/.bash_profile  // 让所做的配置生效
[.bash_profile不存在]：
// 删除：unset 变量名
unset PUB_HOSTED_URL
unset FLUTTER_STORAGE_BASE_URL
```

SliveBar:

```dart
SliverAppBar({
    Key key,
    this.leading,//左侧的图标或文字，多为返回箭头
    this.automaticallyImplyLeading = true,//没有leading为true的时候，默认返回箭头，没有leading且为false，则显示title
    this.title,//标题
    this.actions,//标题右侧的操作
    this.flexibleSpace,//可以理解为SliverAppBar的背景内容区
    this.bottom,//SliverAppBar的底部区
    this.elevation,//阴影
    this.forceElevated = false,//是否显示阴影
    this.backgroundColor,//背景颜色
    this.brightness,//状态栏主题，默认Brightness.dark，可选参数light
    this.iconTheme,//SliverAppBar图标主题
    this.actionsIconTheme,//action图标主题
    this.textTheme,//文字主题
    this.primary = true,//是否显示在状态栏的下面,false就会占领状态栏的高度
    this.centerTitle,//标题是否居中显示
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,//标题横向间距
    this.expandedHeight,//合并的高度，默认是状态栏的高度加AppBar的高度
    this.floating = false,//滑动时是否悬浮
    this.pinned = false,//标题栏是否固定
    this.snap = false,//配合floating使用
  })
```
#### build iOS 真机
```shell
Error:
It appears that your application still contains the default signing identifier.
Try replacing 'com.example' with your signing id in Xcode:
  open ios/Runner.xcworkspace
```
`rm -rf ios/Flutter/App.framework`

#### Matrix4（矩阵变化） 参数：
```dart
scale：缩放
transform: Matrix4.diagonal3Values(x, y, z),
transform: 移动
rotationZ：绕Z轴旋转
rotationX：绕X轴旋转
rotationY：绕Y轴旋转
columns：设置一个新的矩阵
compose：复合平移、旋转、缩放，形成新的状态
copy：复制一个4*4的张量(矩阵)
```

#### dart 筛选并删除空值
```dart
_objTable.keys
  .where((k) => _objTable[k].indices.isEmpty) // filter keys
  .toList() // create a copy to avoid concurrent modifications
  .forEach(_objTable.remove); // remove selected keys
```
