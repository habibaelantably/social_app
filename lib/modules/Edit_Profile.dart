
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
  @override
  Widget build(BuildContext context)
  {
    var UserModel=SocialCubit.get(context).model;
   // var profileImage=SocialCubit.get(context).profileImage;

    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (BuildContext context, state)
      {
        return Scaffold(
            appBar: deafultAppBar(
                context: context,
                title: 'Edit profile',
                actions: [
                  TextButton(
                      onPressed: (){},
                      child: Text('Update')
                  )
                ]
            ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children:
              [
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
                                      image: NetworkImage('${UserModel!.cover}'),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          IconButton(
                              onPressed: (){},
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
                              backgroundImage: NetworkImage('${UserModel.image}'),

                            ),
                          ),
                          IconButton(
                              onPressed: (){},
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
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}