import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/reusable_components.dart';
import 'package:social_app/modules/AddPosts.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/cubit/social_states.dart';

class SocialLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state)
      {
        if(state is SocialAddPostState)
        {
          NavigateTo(context, AddPostsScreen());
        }
      },
      builder: (BuildContext context, Object? state)
      {
        var cubit=SocialCubit.get(context);
        return Scaffold(
            appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
        ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
             cubit.changeBottomNav(index);
            },
            items:
            [
              BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(Icons.location_on_outlined),label: 'users'),
              BottomNavigationBarItem(icon:Icon(Icons.upload_file),label: 'Post'),
              BottomNavigationBarItem(icon:Icon(Icons.chat_rounded),label: 'chats'),
              BottomNavigationBarItem(icon:Icon(Icons.settings_applications),label: 'settings'),
            ],
          ),
        );
        // return BuildCondition(
        //   condition: SocialCubit.get(context).model !=null,
        //   builder:(context)
        //
        //
        //     //var model=SocialCubit.get(context).model;
        //
        //       body: Column(
        //         children: [
        //           if(!FirebaseAuth.instance.currentUser!.emailVerified)
        //           Container(
        //             color: Colors.amberAccent[100],
        //             child: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Row(
        //                 children: [
        //                   Icon(Icons.info_outline),
        //                   Text(
        //                       'please verify your email'
        //                   ),
        //                   Spacer(),
        //                   SizedBox(width: 20,),
        //                   TextButton(
        //                       onPressed: ()
        //                       {
        //                         FirebaseAuth.instance.currentUser!.
        //                         sendEmailVerification().
        //                         then((value) {
        //                           showToast(text: 'check you mail', states: ToastStates.SUCCESS);
        //                         }).
        //                         catchError((error){
        //                           print(error.toString());
        //                         });
        //
        //                       },
        //                       child: Text('send'))
        //                 ],
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     );
        //   },
        //   fallback:(context)=> Center(child: CircularProgressIndicator()),

      },

    );
  }

}