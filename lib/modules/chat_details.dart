
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/MessageModel.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/styles/colors.dart';

class ChatDetails extends StatelessWidget
{
   UserModel? socialModel;
   MessageModel? model;
   TextEditingController messageController=TextEditingController();
   ChatDetails({this.socialModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: socialModel!.uId);
        return BlocConsumer<SocialCubit,SocialStates>(
          builder: ( context, state) {
            return  Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${socialModel!.image}'),
                    ),
                    SizedBox(width: 7.0,),
                    Text('${socialModel!.name}')
                  ],
                ),
              ),
              body: BuildCondition(
                condition: SocialCubit.get(context).messages.length >0,
                builder: (context)=>Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index){
                              var message =SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).socialModel!.uId == message.senderId )
                                return buildMyMessage(message);

                              return buildMessage(message);
                            },
                            separatorBuilder: (context,state)=>SizedBox(height: 10.0,),
                            itemCount: SocialCubit.get(context).messages.length),
                      ),
                      SizedBox(height: 8.0,),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type message here...'
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: deafultColor,
                              child: MaterialButton(
                                onPressed:(){
                                  SocialCubit.get(context).sendMessages(
                                      receiverId: socialModel!.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  messageController.text='';
                                },
                                child: Icon(Icons.send,
                                  color: Colors.white,
                                ),
                                color:deafultColor,
                                minWidth: 1.0,

                              ),
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
                fallback: (context)=>  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(children: [
                          Center(
                            child: Text('no messeges yet',style: TextStyle(color: Colors.grey),),)
                        ],),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type message here...'
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: deafultColor,
                              child: MaterialButton(
                                onPressed:(){
                                  SocialCubit.get(context).sendMessages(
                                      receiverId: socialModel!.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  messageController.text='';
                                },
                                child: Icon(Icons.send,
                                  color: Colors.white,
                                ),
                                color:deafultColor,
                                minWidth: 1.0,

                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ),

            );
          },
          listener: ( context,  state) {  },

        );
      }
    );
  }

  Widget buildMessage( model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
        color: Colors.grey[400],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 5.0 ,
        vertical: 10.0,
      ),
      child: Text(model.text),
    ),
  );
   Widget buildMyMessage( model)=>Align(
     alignment: AlignmentDirectional.centerEnd,
     child: Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.only(
           bottomLeft: Radius.circular(10.0),
           topRight: Radius.circular(10.0),
           topLeft: Radius.circular(10.0),
         ),
         color: deafultColor.withOpacity(0.2),
       ),
       padding: EdgeInsets.symmetric(
         horizontal: 5.0 ,
         vertical: 10.0,
       ),
       child: Text(model.text),
     ),
   );
}