import 'Mes.dart';
import 'package:flutter/material.dart';
import 'package:tongxinbaike/config/app_colors.dart';
import 'package:tongxinbaike/dio_util/dio_util.dart';
import 'package:tongxinbaike/dio_util/dio_method.dart';

class MessageCard extends StatelessWidget {
  final Mes data;

  const MessageCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  Widget renderCover() {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        Positioned(
          left: 0,
          top: 100,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(80, 0, 0, 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget renderUserInfo() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: <Widget>[
                    Text(
                    data.author!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.bluegreen,
                    ),
                  ),
                    ]),
                  Padding(padding: EdgeInsets.only(top: 2)),
                  Row(
                    children: <Widget>[
                      Text(
                        data.createtime!, //data.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        " 回复了你的帖子",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderPublishContent() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child:
          Text(
            data.content!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
    );
  }


  Widget renderInteractionArea() {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child:
            Container(
              padding: EdgeInsets.fromLTRB(5, 2, 5, 5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.bluegreen, width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Text(
                    data.tiezititle!,
                    style:TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.bluegreen,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    data.tieziContent!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          // Row(
          //   children: <Widget>[
          //     Icon(
          //       Icons.message,
          //       size: 18,
          //       color: Colors.black.withOpacity(0.6),
          //     ),
          //     Padding(padding: EdgeInsets.only(left: 6)),
          //
          //     Text(
          //       data.tiezititle!,
          //       style: TextStyle(
          //         fontSize: 15,
          //         color: Colors.black.withOpacity(0.6),
          //       ),
          //     ),
          //     Text(
          //       data.tieziContent!,
          //       style: TextStyle(
          //         overflow: TextOverflow.ellipsis,
          //         fontSize: 15,
          //         color: Colors.black.withOpacity(0.6),
          //       ),
          //     ),
          //   ],
          // ),
          // Row(
          //   children: <Widget>[
          //     Icon(
          //       Icons.share,
          //       size: 16,
          //       color: Color(0xFF999999),
          //     ),
          //     Padding(padding: EdgeInsets.only(left: 6)),
          //     Text(
          //       data.shares.toString(),
          //       style: TextStyle(
          //         fontSize: 15,
          //         color: Color(0xFF999999),
          //       ),
          //     ),
          //   ],
          // ),
        // ],
      );
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 4,
            color: Color.fromARGB(20, 0, 0, 0),
          ),
        ],
      ),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 18, 0, 0),
            child: CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFCCCCCC),
                backgroundImage: NetworkImage(
                    data.userImgUrl!=null?data.userImgUrl!:"https://wx2.sinaimg.cn/large/005ZZktegy1gvndtv7ic9j62bc2bbhdt02.jpg") //data.userImgUrl),
            ),
          ),
          Expanded(
            child:
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // this.renderCover(),
              this.renderUserInfo(),
              this.renderPublishContent(),
              SizedBox(
                height: 5,
              ),
              this.renderInteractionArea(),
            ],
          ),
          ),
          if(data.isread==false)
          Align(
            alignment: Alignment.topRight,
            child:
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                ),
                ),
          )
        ]
      )
    );
  }
}