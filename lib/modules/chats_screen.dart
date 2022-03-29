
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/reusable_components.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';

class ChatsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state)
      {
        
      },
      builder: (context,state){
        return BuildCondition(
          condition: SocialCubit.get(context).allUsers.length >0,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).allUsers[index],context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: SocialCubit.get(context).allUsers.length),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

  Widget buildChatItem(UserModel model,context)=>InkWell(
    onTap:(){NavigateTo(context, ChatDetails(socialModel: model,));} ,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 5.0,),
          Text('${model.name}',
            //style: Theme.of(context).textTheme.bodyText1
          ),
        ],
      ),
    ),
  );

}