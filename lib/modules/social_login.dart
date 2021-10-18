
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/reusable_components.dart';
import 'package:social_app/layouts/Social_layout.dart';
import 'package:social_app/modules/social_register.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/cubit/social_login_cubit.dart';
import 'package:social_app/shared/cubit/social_login_states.dart';

class LoginScreen extends StatelessWidget
{
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar:AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        Text(
                          'login now to communicate with friends ',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 40.0,),
                        deafultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value)
                            {
                              if(value!.isEmpty){
                                return 'please enter email address';
                              }
                              return null;
                            },
                            prefix: Icons.email,
                            label: 'Email Address'
                        ),
                        SizedBox(height: 15,),

                        deafultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validator: (value)
                            {
                              if(value!.isEmpty){
                                return 'please enter password';
                              }
                              return null;
                            },
                            isPassword: SocialLoginCubit.get(context).isPassword,
                            prefix: Icons.vpn_key,
                            suffix: SocialLoginCubit.get(context).suffix,
                            suffixButton: ()
                            {
                              SocialLoginCubit.get(context).changePasswordVisibility();
                            },
                            label: 'password'
                        ),
                        SizedBox(height: 20.0,),
                        BuildCondition(
                          condition: state is! SocialLoginLoadingstate,
                          builder: (context)=>deafultbutton(
                              function:()
                              {
                                if(formkey.currentState != null && formkey.currentState!.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login'.toUpperCase()
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),

                        ),
                        SizedBox(height: 20.0,),
                        Row(
                          children: [
                            Text(
                                'Don`t have an account?'
                            ),
                            TextButton(
                                onPressed: ()
                                {
                                  NavigateTo(context, RegisterScreen());
                                },
                                child: Text('Creat an account'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },
        listener: (BuildContext context, Object? state)
        {
          if(state is SocialLoginErrorState)
            showToast(text:state.error.toString(), states: ToastStates.ERROR);
          if(state is SocialLoginSuccessState)
            CacheHelper.saveData
              (
                 key: 'uId',
                  value: state.uId)
                  .then((value) {
                if(value){
                  NavigateAndKill(context, SocialLayout());
                }
              });

          // if(state is AppSuccessState)
          // {
          //   if(state.loginModel.status==true)
          //   {
          //     print(state.loginModel.status);
          //     print(state.loginModel.message);
          //     //print(state.loginModel.data!.token);
          //     // showToast(states: ToastStates.SUCCESS,text:state.loginModel.message.toString() );
          //     cacheHelper.saveData
          //       (key: 'token',
          //         value: state.loginModel.data!.token)
          //         .then((value) {
          //       if(value){
          //
          //         token=state.loginModel.data!.token;
          //         NavigateAndKill(context, shoplayoutScreen());
          //       }
          //     });
          //
          //
          //   }else
          //   {
          //     print(state.loginModel.message);
          //
          //     showToast(states: ToastStates.ERROR,text:state.loginModel.message.toString() );
          //
          //   }
          //
          // }
        },

      ),
    );
  }

}