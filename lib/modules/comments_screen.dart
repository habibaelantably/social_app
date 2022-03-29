
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/reusable_components.dart';
import 'package:social_app/models/CommentsModel.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';
import 'package:social_app/styles/colors.dart';

class AddComment extends StatefulWidget
{

  String? postId;
  UserModel? model;
  AddComment(this.postId,this.model);

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  TextEditingController commentController=TextEditingController();
  bool enableButton=false;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        SocialCubit.get(context).getComments(widget.postId);
        return BlocConsumer<SocialCubit,SocialStates>(
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: BuildCondition(
                condition: SocialCubit.get(context).comments.length > 0 ,
                builder:(context)=> Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder:(context,index)=>
                                commentBuilder(context,SocialCubit.get(context).comments[index],index),
                            separatorBuilder: (context,state)=>myDivider(),
                            itemCount: SocialCubit.get(context).comments.length
                        ),
                      ),
                      SizedBox(height: 5.0,),
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
                                  controller: commentController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type comment here...'
                                  ),
                                  onChanged: (String value){
                                    enableButton=value.isNotEmpty;
                                    SocialCubit.get(context).emit(SocialButtonActivationState());
                                  },
                                ),
                              ),
                            ),

                              Container(
                                height: 50.0,
                                child: MaterialButton(
                                  onPressed:enableButton?(){
                                    SocialCubit.get(context).comment(postId:widget.postId, text:commentController.text);
                                  }:null,
                                  child: Icon(Icons.send,
                                    color: Colors.white,
                                  ),
                                  color:enableButton?deafultColor:Colors.grey,
                                  minWidth: 1.0,

                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback:(context)=>  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            if(state is SocialGetCommentLoadingState )
                              CircularProgressIndicator(),
                            if(state is SocialGetCommentSuccessState)
                            Center(
                            child: Text('no comments yet',style: TextStyle(color: Colors.grey),),)
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
                                  controller: commentController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type comment here...'
                                  ),
                                  onChanged: (String value){
                                    enableButton=value.isNotEmpty;
                                    SocialCubit.get(context).emit(SocialButtonActivationState());
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              child: MaterialButton(
                                onPressed:enableButton?(){
                                  SocialCubit.get(context).comment(postId:widget.postId, text:commentController.text);
                                }:null,
                                child: Icon(Icons.send,
                                  color: Colors.white,
                                ),
                                color:enableButton?deafultColor:Colors.grey,
                                minWidth: 1.0,

                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (BuildContext context, Object? state)
          {

          },
        );
      }
    );
  }

  Widget commentBuilder(context,CommentsModel cM,index)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('${cM.image}'),
            ),
            SizedBox(width: 5.0,),
            Text('${cM.name}'),
          ],
        ),
        SizedBox(height: 5.0,),
        Text(
            '${cM.text}',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              // height: 1.2
            )),
      ],
    ),
  );
}