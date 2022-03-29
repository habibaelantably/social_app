
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/reusable_components.dart';
import 'package:social_app/models/PostModel.dart';
import 'package:social_app/modules/comments_screen.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';

class FeedsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (BuildContext context, state)
      {
        return BuildCondition(
          condition: SocialCubit.get(context).posts.length > 0 && SocialCubit.get(context).socialModel != null,
          builder:(context)=> SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 4.0,
                    margin: EdgeInsets.all(8.0),
                    child:Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage('https://image.freepik.com/free-photo/wondered-curly-haired-woman-has-curious-excited-gaze-shows-product-empty-space-gives-advice-dressed-brown-sweatshirt-says-click-link-isolated-beige-wall_273609-37595.jpg?w=740'),
                          height:200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all( 7.0),
                          child: Text('communicate with people',
                              style:Theme.of(context).textTheme.subtitle1
                          ),
                        )
                      ],
                    )
                ),
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>postBuilder(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
                    itemCount: SocialCubit.get(context).posts.length),
                SizedBox(height: 10.0,)
              ],
            ),
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}

Widget postBuilder(PostModel model,context,index)=>Card(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  elevation: 5.0,
  margin: EdgeInsets.symmetric(
      horizontal: 10.0
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('${model.userImage}'),
            ),
            //SocialCubit.get(context).socialModel!.uId == model.uId?
            //               NetworkImage('${SocialCubit.get(context).socialModel!.image}') && FileImage(profileImage) as ImageProvider
            //                   :
            SizedBox(width: 5.0,),
            Expanded(
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${model.name}',
                        //style: Theme.of(context).textTheme.bodyText1
                      ),
                      SizedBox(width: 5.0,),
                      Icon(Icons.check_circle,color: Colors.blue,size: 15.0,)
                    ],
                  ),
                  Text('${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey,
                          height: 1.3
                      )
                  ),
                ],
              ),
            ),
            SizedBox(width:10.0,),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz,color: Colors.grey,))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: myDivider(),
        ),
        Text(
            '${model.postText}',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
               // height: 1.2
            )),

        if(model.postImage != '')
        // Container(
        //   width: double.infinity,
        //   child: Wrap(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsetsDirectional.only(end:5.0),
        //         child: MaterialButton(onPressed: (){},
        //           height: 20.0,
        //           minWidth: 1.0,
        //           padding: EdgeInsets.zero,
        //           child: Text('#software',
        //               style: Theme.of(context).textTheme.caption!.copyWith(
        //                   color: Colors.blue
        //               )
        //           ),
        //         ),
        //       ),
        //
        //       Padding(
        //         padding: const EdgeInsetsDirectional.only(end:5.0),
        //         child: MaterialButton(onPressed: (){},
        //           height: 20.0,
        //           minWidth: 1.0,
        //           padding: EdgeInsets.zero,
        //           child: Text('#software',
        //               style: Theme.of(context).textTheme.caption!.copyWith(
        //                   color: Colors.blue
        //               )
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          height: 150,
          width:double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: NetworkImage('${model.postImage}'),
                  fit: BoxFit.cover
              )
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border,color: Colors.red,size: 20.0,),
                      SizedBox(width: 5.0,),
                      Text('${SocialCubit.get(context).likes[index]}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                onTap: (){},
              ),
            ),
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.mode_comment_outlined,color: Colors.amberAccent,size: 20.0),
                      SizedBox(width: 5.0,),
                      Text('0',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                onTap: (){},
              ),
            ),
          ],
        ),
        myDivider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    SocialCubit.get(context).comments=[];
                    NavigateTo(
                        context,
                        AddComment(
                            SocialCubit.get(context).postId[index],
                            SocialCubit.get(context).socialModel));
                    },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${SocialCubit.get(context).socialModel!.image}'),
                      ),
                      SizedBox(width: 5.0,),
                      Text(
                          'write comment...',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey,
                              height: 1.3
                          )
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.favorite_border,color: Colors.red,size: 20.0),
                            SizedBox(width: 5.0,),
                            Text('like',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){
                          SocialCubit.get(context).postLikes(SocialCubit.get(context).postId[index]);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.share_outlined,color: Colors.green,size: 20.0),
                            SizedBox(width: 5.0,),
                            Text('share',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),


        )
      ],
    ),
  ),
);