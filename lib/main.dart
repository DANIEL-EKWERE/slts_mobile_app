import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:slts_mobile_app/app_bindings.dart';
import 'package:slts_mobile_app/route/app_links.dart';
import 'package:slts_mobile_app/route/routes.dart';
import 'package:slts_mobile_app/services/logger.dart';
import 'package:slts_mobile_app/services/route_service.dart';
import 'package:slts_mobile_app/styles/styles.dart';
import 'package:slts_mobile_app/utils/screen_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp( const SltsApp());
}

class SltsApp extends StatefulWidget {
 const SltsApp({super.key});

  @override
  State<SltsApp> createState() => _SltsAppState();
}

class _SltsAppState extends State<SltsApp> {
  // This widget is the root of your application.

  Logger logger = Logger('_SltsAppState');
  AppBinding bindings = AppBinding();

  @override
  void initState() {
    logger.log('intState');
    bindings.dependencies();

    // storageService.init().then((_) {
    //   logger.debug('loading session...');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData selectedSize = getScreenSize(context);

    return ScreenUtilInit(
        designSize: selectedSize.size,
        builder: (
          context,
          child,
        ) {
          return GetMaterialApp(
            title: 'SLTS',
            theme: ThemeData(
              scaffoldBackgroundColor: backgroundColor,
              canvasColor: Colors.transparent,

              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a purple toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // home: const SltsHomePage(title: 'Flutter Demo Home Page'),
            initialRoute: AppLinks.splash,
            getPages: AppRoutes.pages,
            navigatorObservers: [RouteService(), RouteService().routeObserver],
            onInit: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown
              ]);
            },
            debugShowCheckedModeBanner: false,
          );
        });
  }
}


// {
//   "totalItems": 0,
//   "violations": [],
//   "totalPages": 0,
//   "currentPage": 0
// }


  // floatingActionButton: FloatingActionButton(
  //       onPressed: _incrementCounter,
  //       tooltip: 'Increment',
  //       child: const Icon(Icons.add),
  //     ), 