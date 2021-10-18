

import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/components/constants.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/AddPosts.dart';
import 'package:social_app/modules/chats_screen.dart';
import 'package:social_app/modules/feeds_screen.dart';
import 'package:social_app/modules/settings_screen.dart';
import 'package:social_app/modules/users_screen.dart';
import 'package:social_app/shared/cubit/social_states.dart';

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context)=>BlocProvider.of(context);

  UserModel? model;

  void getUserdata() {
    emit(SocialLoadingState());

    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    get().
    then((value){
      print(value.data());
      model=UserModel.fromJson(value.data()!);
      emit(SocialSuccessState('uId'));
    }).
    catchError((error){
      print(error.toString());
      emit(SocialErrorState());
    });
  }

  int currentIndex=0;

  List<Widget> screens=
  [
    FeedsScreen(),
    UsersScreen(),
    AddPostsScreen(),
    ChatsScreen(),
    SettingsScreen()
  ];
  List<String> titles=
  [
    'Home',
    'users',
    'posts',
    'Chats',
    'Settings'
  ];

  void changeBottomNav(int index)
  {
    if(index==2) {
      emit(SocialAddPostState());
    }
    else
      {
        currentIndex = index;
        emit(SocialChangeBottomNavState());
      }

  }
  
  File? profileImage;
  final picker=ImagePicker();
  
  Future<void>getProfileImage()async
  {
    final  pickedFile=await picker.pickImage(source: ImageSource.gallery);
    
    if(pickedFile != null)
    {
      
      emit(SocialPickProfileImageSuccessState());
    }else
      {
        print('no image picked');
        emit(SocialPickProfileImageErrorState());
      }
  }
}