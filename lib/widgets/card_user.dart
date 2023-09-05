import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finalproject/models/chat_user.dart';
import 'package:flutter_finalproject/pages/chat_page.dart';
import '../pages/message_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatUser extends StatefulWidget {
  final ChatUserProfile user;
  const ChatUser({super.key, required this.user});

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => ChatPage(user: widget.user)));
        },
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(ms.height * .03),
            child: CachedNetworkImage(
              width: ms.height * .055,
              height: ms.height * .055,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) => const CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),
            ),
          ),
          title: Text(widget.user.name),
          //last message
          subtitle: Text(
            widget.user.lastMess,
            maxLines: 1,
          ),
          //time
          trailing: Text('1:00 PM', style: TextStyle(color: Colors.black26)),
        ),
      ),
    );
  }
}
