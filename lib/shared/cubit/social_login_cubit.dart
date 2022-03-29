
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/social_login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginIntialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password
  })
  {
    emit(SocialLoginLoadingstate());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value){
          emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });

  }

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;


  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix= isPassword? Icons.visibility_outlined :Icons.visibility_off_outlined;

    emit(SocialLoginChangePasswordVisibilityState());
  }

}