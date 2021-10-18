
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
        image:'https://labs.openheritage.eu/assets/decidim/default-avatar-43686fd5db4beed0141662a012321bbccd154ee1d9188b0d1f41e37b710af3cb.svg',
        cover: 'https://labs.openheritage.eu/assets/decidim/default-avatar-43686fd5db4beed0141662a012321bbccd154ee1d9188b0d1f41e37b710af3cb.svg'
    );

    FirebaseFirestore.instance.collection('users').
    doc(uId).
    set(model.toMap()).then((value) {
      emit(SocialSuccessCreateState());
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