
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/components/reusable_components.dart';

class FeedsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
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
                    image: NetworkImage('https://image.freepik.com/free-photo/happy-curly-haired-african-american-woman-laughs-positively-points-aside-copy-space-wears-black-t-shirt_273609-38585.jpg'),
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
               itemBuilder: (context,index)=>postBuilder(context),
               separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
               itemCount: 10),
            SizedBox(height: 10.0,)
          ],
        ),
      ),
    );
  }
}

Widget postBuilder(context)=>Card(
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
              backgroundImage: NetworkImage('https://image.freepik.com/free-photo/portrait-cute-happy-girl-smiling-touching-her-curly-red-hair_176420-9241.jpg'),
            ),
            SizedBox(width: 5.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Habiba Gamal',
                        //style: Theme.of(context).textTheme.bodyText1
                      ),
                      SizedBox(width: 5.0,),
                      Icon(Icons.check_circle,color: Colors.blue,size: 15.0,)
                    ],
                  ),
                  Text('october 7,2021 at 12:00pm',
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
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ultricies odio non libero molestie tristique. Nulla elementum, lectus sed rutrum euismod, nisl mauris faucibus nibh, vitae vehicula arcu ligula a augue',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                height: 1.2
            )),
        Container(
          width: double.infinity,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end:5.0),
                child: MaterialButton(onPressed: (){},
                  height: 20.0,
                  minWidth: 1.0,
                  padding: EdgeInsets.zero,
                  child: Text('#software',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.blue
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end:5.0),
                child: MaterialButton(onPressed: (){},
                  height: 20.0,
                  minWidth: 1.0,
                  padding: EdgeInsets.zero,
                  child: Text('#software',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.blue
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          width:double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: NetworkImage('https://image.freepik.com/free-photo/happy-curly-haired-african-american-woman-laughs-positively-points-aside-copy-space-wears-black-t-shirt_273609-38585.jpg'),
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
                      Text('120',
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
                      Text('30 comments',
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
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('https://image.freepik.com/free-photo/portrait-cute-happy-girl-smiling-touching-her-curly-red-hair_176420-9241.jpg'),
                    ),
                    SizedBox(width: 5.0,),
                    Text('write comment...',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.grey,
                            height: 1.3
                        )
                    ),
                  ],
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
                        onTap: (){},
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