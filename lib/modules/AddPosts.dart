import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/reusable_components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';

class addPostsScreen extends StatelessWidget
{
  var postTextController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(

        builder: (context,state)
      {

        return Scaffold(
            appBar: deafultAppBar(
              context: context,
              title: 'create post',
              actions:[
                TextButton(
                  onPressed: ()
                  {
                    var now = DateTime.now();

                    if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).createNewPost(
                          dateTime:now.toString() ,
                          postText: postTextController.text);
                    }else
                    {
                      SocialCubit.get(context).createNewPostImage(
                          dateTime:now.toString() ,
                          postText: postTextController.text);

                    }
                  }, child: Text('post'))],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if(state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialCreatePostLoadingState)
                    SizedBox(height:5.0),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage('https://image.freepik.com/free-photo/portrait-cute-happy-girl-smiling-touching-her-curly-red-hair_176420-9241.jpg'),
                      ),
                      SizedBox(width: 5.0,),
                      Text('Habiba gamal')
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: postTextController,
                      decoration: InputDecoration(
                          hintText: 'what`s in your mind...? ',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  if(SocialCubit.get(context).postImage != null)
                    Stack(
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
                                image: FileImage(SocialCubit.get(context).postImage!) ,
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            SocialCubit.get(context).removeImage();
                          },
                          icon: CircleAvatar(
                              radius: 15.0,
                              child:Icon(Icons.close)
                          )
                      ),
                    ],
                  ),

                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: [
                              SizedBox(height: 15,),
                              Icon(Icons.image),
                              Text('addphoto'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image),
                              Text('# tags'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );

        },
        listener: (context,state){});
  }

}