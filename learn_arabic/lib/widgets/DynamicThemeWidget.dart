import 'package:flutter/material.dart';
import 'package:learn_arabic/blocs/appService.dart';
import 'package:learn_arabic/blocs/util.dart';

typedef Widget ThemedWidgetBuilder(BuildContext context, ThemeData theme);

class DynamicThemeWidget extends StatefulWidget {
  final ThemedWidgetBuilder themedWidgetBuilder;
  final Color defaultTheme;

  DynamicThemeWidget({Key key, this.defaultTheme, this.themedWidgetBuilder})
      : super(key: key);

  @override
  DynamicThemeWidgetState createState() => new DynamicThemeWidgetState();

  static DynamicThemeWidgetState of(BuildContext context) {
    //return context.ancestorStateOfType(const TypeMatcher<DynamicThemeWidgetState>());
    return context.findAncestorStateOfType();
  }
}

class DynamicThemeWidgetState extends State<DynamicThemeWidget> {
  Color color;
  @override
  void initState() {
    color = widget.defaultTheme;
    AppService.getFromPref(AppService.prefkey_theme, Colors.black.value)
        .then((value) {
      setState(() {
        color = materialColors.firstWhere((element) => element.value == value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(
        context, color == Colors.black ? dark : _getLightTheme(color));
  }

  setTheme(Color color) {
    setState(() {
      this.color = color;
    });
  }

  get dark => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.grey[800],
        accentColor: Colors.white60,
        brightness: Brightness.dark,
        backgroundColor: Colors.grey[800],
        //fontFamily: 'Georgia',
      );

  _getLightTheme(MaterialColor color) => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: color,
        accentColor: color[800],
        brightness: Brightness.light,
        backgroundColor: color[200],
        cardColor: color[200],
        dividerColor: color[200],
      );
}
