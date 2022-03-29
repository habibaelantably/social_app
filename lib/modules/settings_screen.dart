
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/reusable_components.dart';
import 'package:social_app/modules/Edit_Profile.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';

class SettingsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) 
  {
    return BlocConsumer<SocialCubit,SocialStates>(
        builder: (context,index)
        {
          var UserModel =SocialCubit.get(context).socialModel;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
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
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 65.0,
                        backgroundColor:Colors.white ,
                        child: CircleAvatar(
                          radius: 63.0,
                          backgroundImage: NetworkImage('${UserModel.image}'),

                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  '${UserModel.name}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 10.0),
                Text(
                  '${UserModel.bio}',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.grey
                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100'),
                              Text('posts'),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100'),
                              Text('photos'),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100'),
                              Text('Followers'),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100'),
                              Text('following'),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton
                        (
                        onPressed: () {  },
                        child: Text('Add photo'),
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    OutlinedButton
                      (
                      onPressed: () { NavigateTo(context, editProfileScreen()); },
                      child: Icon(Icons.edit),

                    ),
                   // OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.search), label: Text('google'))

                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(onPressed: (){
                      FirebaseMessaging.instance.subscribeToTopic('announcement');
                    }, child: Text('subscribe')),

                    SizedBox(width: 8.0,),

                    OutlinedButton(onPressed: (){
                      FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
                    }, child: Text('unsubscribe')),

                    Spacer(),

                    OutlinedButton(onPressed: (){

                     SocialCubit.get(context).logOut(context);
                    }, child: Icon(Icons.logout)),
                  ],
                )

              ],
            ),
          );
        },
        listener:(context,index)
        {
        }
        );
  }

}