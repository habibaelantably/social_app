
//import 'dart:html';
//import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/reusable_components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';


class editProfileScreen extends StatelessWidget
{
  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context)
  {



    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (BuildContext context, state)
      {
        var userModel=SocialCubit.get(context).socialModel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;


        nameController.text=userModel!.name!;
        bioController.text=userModel.bio!;
        phoneController.text=userModel.phone!;

        return Scaffold(
            appBar: deafultAppBar(
                context: context,
                title: 'Edit profile',
                actions: [
                  TextButton(
                      onPressed: (){
                        SocialCubit.get(context).updateUser(
                        name: nameController.text,
                       bio: bioController.text,
                        phone: phoneController.text);
                        },
                      child: Text('Update')
                  )
                ]
            ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:
                [
                  if(state is SocialUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  if(state is! SocialUpdateUserLoadingState)
                    SizedBox(height: 10.0,),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            children: [
                              Container(
                                height: 145,
                                width:double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    image: DecorationImage(
                                        image: coverImage==null ?NetworkImage('${userModel.cover}')
                                      : FileImage(coverImage,) as ImageProvider,
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  radius: 15.0,
                                  child:Icon(Icons.camera_alt_outlined)
                                )
                            ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor:Colors.white ,
                              child: CircleAvatar(
                                radius: 63.0,
                                backgroundImage:  profileImage == null ?
                                NetworkImage('${userModel.image}') :
                                FileImage(profileImage) as ImageProvider

                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                    radius: 15.0,
                                    child:Icon(Icons.camera_alt_outlined)
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                 Row(
                   children: [
                     if(SocialCubit.get(context).profileImage != null)
                     Expanded(
                         child: Column(
                           children: [
                             deafultbutton(
                             function: (){
                               SocialCubit.get(context).upLoadProfileImage(
                                   name: nameController.text,
                                   bio: bioController.text,
                                   phone: phoneController.text);
                             },
                             text: 'Upload Profil '),
                             if(state is SocialUpdateUserLoadingState)
                             SizedBox(height: 5.0,),
                             if(state is SocialUpdateUserLoadingState)
                             LinearProgressIndicator()
                           ],
                         )
                     ),
                     SizedBox(width: 5.0,),
                     if(SocialCubit.get(context).coverImage != null)
                     Expanded(
                         child: Column(
                           children: [
                             deafultbutton(
                             function: (){
                               SocialCubit.get(context).upLoadCoverImage(
                                   name: nameController.text,
                                   bio: bioController.text,
                                   phone: phoneController.text);
                             },
                             text: 'Upload cover '),
                             SizedBox(height: 5.0,),
                             if(state is SocialUpdateUserLoadingState)
                               LinearProgressIndicator()
                           ],
                         )),
                   ],
                 ),
                 // if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                  SizedBox(height: 20.0,),
                  deafultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validator: (value)
                      {
                        if(value!.isEmpty){
                          return 'enter your name';
                        }
                        return null;
                      },
                      prefix: Icons.person,
                      label: 'name'
                  ),
                  SizedBox(height: 10.0,),
                  deafultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validator: (value)
                      {
                        if(value!.isEmpty){
                          return 'enter your bio';
                        }
                        return null;
                      },
                      prefix: Icons.info_outline,
                      label: 'bio'
                  ),
                  SizedBox(height: 10.0,),
                  deafultFormField(
                      controller: phoneController,
                      type: TextInputType.text,
                      validator: (value)
                      {
                        if(value!.isEmpty){
                          return 'enter your phone';
                        }
                        return null;
                      },
                      prefix: Icons.info_outline,
                      label: 'phone'
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}