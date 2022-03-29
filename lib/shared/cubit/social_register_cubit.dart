
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/social_register_state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialIntialRegisterState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);


  // ShopLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone
  })
  {
    emit(SocialLoadingRegisterstate());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          createUser(name: name, email: email, phone: phone,uId: value.user!.uid);
    }).catchError((error){
      emit(SocialErrorRegisterState());
    });

  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,

  })
  {
    UserModel model=UserModel
      (name:name,
        email:email,
        phone:phone,
        uId:uId,
        isEmailVerified:false,
        bio:'write your bio',
        image:'https://media.istockphoto.com/photos/blue-open-sea-environmenttravel-and-nature-concept-picture-id1147989465?k=20&m=1147989465&s=612x612&w=0&h=nVI1UKhyr2WPZ5-gnFB3Q7jjToru4lg_ubBFx-Jomq0=',
        cover: 'https://merriam-webster.com/assets/mw/images/gallery/gal-wap-slideshow-slide/onding-3320-6e61bc8bd8bc5a03b97984a30b1f1bc3@1x.jpg'
    );

    FirebaseFirestore.instance.collection('users').
    doc(uId).
    set(model.toMap()).then((value) {
      emit(SocialSuccessCreateState(uId));
    }).catchError((error){
      emit(SocialErrorCreateState());
    });

  }

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;


  void changePasswordVisibilityRegister()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.visibility_outlined :Icons.visibility_off_outlined;

    emit(SocialChangePasswordVisibilityRegisterState());
  }

}