import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/components/constants.dart';
import 'package:social_app/layouts/Social_layout.dart';
import 'package:social_app/modules/social_login.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  Widget? widget;

  uId=CacheHelper.getData(key: 'uId');

  if(uId != null)
    widget=SocialLayout();
  else
    widget=LoginScreen();


  runApp(MyApp(widget));
}


class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialCubit()..getUserdata(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}


