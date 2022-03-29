import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/components/constants.dart';
import 'package:social_app/layouts/Social_layout.dart';
import 'package:social_app/modules/social_login.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/styles/theme.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   print('OnBackground Message');
   print(message.data.toString());
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token=await FirebaseMessaging.instance.getToken();
  print(token.toString());

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  Widget? widget;

  uId=CacheHelper.getData(key: 'uId');

  if(uId != null)
    widget=SocialLayout();
  else
    widget=LoginScreen();

   FirebaseAuth.instance
      .idTokenChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!**************');
    }
  });

  runApp(MyApp(widget));
}


class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialCubit()..getUserdata()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home:startWidget,
      ),
    );
  }
}


