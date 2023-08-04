import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:findhouse/notifiers/property_owner/properties.dart';
import 'package:findhouse/screens/home_searcher/settings.dart';
import 'package:findhouse/screens/login_screen.dart';
import 'package:findhouse/screens/openingscreen.dart';
import 'package:findhouse/screens/property_owner/add_property.dart';
import 'package:findhouse/screens/splash_screen.dart';
import 'package:findhouse/screens/splash_screen2.dart';
import 'package:findhouse/widgets/theme_provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifiers/property_owner/category.dart';
import 'notifiers/user_notifier.dart';
import 'package:findhouse/notifiers/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppNotifier()),
        ChangeNotifierProvider.value(value: UserNotifier.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: PropertiesProvider.initialize()),
        ChangeNotifierProvider(
          create: (context) => PropertyNotifier(),
        ),
      ],
      child: ThemeBuilder(
          defaultBrightness: Brightness.light,
          builder: (context, _brightness) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Find House',
                theme: ThemeData(
                    primarySwatch: Colors.blue, brightness: _brightness),
                home: ScreensController());
          })));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserNotifier>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return SplashScreen();
      case Status.Unauthenticated:
        return SplashScreen();
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return OpeningView();
      default:
        return SplashHome();
    }
  }
}
