import 'package:flutter/material.dart';
import '../api/apis.dart';
import '../helper/my_date_util.dart';
import '../models/chat_user.dart';
import '../models/message.dart';
import '../screens/chat_screen.dart';
import 'dialogs/profile_dialog.dart';

// Instagram-inspired user card
class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? _message;  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to chat screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(user: widget.user),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            // Subtle shadow for depth
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Profile Image with border
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => ProfileDialog(user: widget.user),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(2), // Border width
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.greenAccent,
                      Colors.blueAccent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(widget.user.image),
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),
            const SizedBox(width: 16),
            // User Info and Last Message
            Expanded(
              child: StreamBuilder(
                stream: APIs.getLastMessage(widget.user),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  final list =
                      data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
                  if (list.isNotEmpty) _message = list[0];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Name and Last Message Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // User Name
                          Text(
                            widget.user.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: _message != null && _message!.read.isEmpty &&
                                        _message!.fromId != APIs.user.uid
                                    ? FontWeight.bold : FontWeight.w400,
                              color:Colors.black87 
                            ),
                          ),
                          // Last Message Time
                          _message != null
                              ? Text(
                                  MyDateUtil.getLastMessageTime(
                                      context: context, time: _message!.sent),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _message!.read.isEmpty &&
                                            _message!.fromId != APIs.user.uid
                                        ? Colors.blueAccent
                                        : Colors.grey,
                                    fontWeight: _message!.read.isEmpty &&
                                            _message!.fromId != APIs.user.uid
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Last Message Preview
                      Row(
                        children: [
                          // Message Type Icon
                          if (_message != null)
                          _message!.type == Type.image
                            ? Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Icon(Icons.image,
                                size: 20,
                                color: _message!.read.isEmpty &&
                                        _message!.fromId != APIs.user.uid
                                    ? Colors.blueAccent
                                    : const Color.fromARGB(255, 199, 199, 199),
                              ),
                            )
                            :
                          _message!.type == Type.image 
                            ? const SizedBox(width: 14)
                            : const SizedBox(),
                          // Message Text
                          Expanded(
                            child: Text(
                              _message != null
                                  ? _message!.type == Type.image
                                      ? 'Sent a photo'
                                      : _message!.msg
                                  : widget.user.about,
                              style: TextStyle(
                                fontSize: 14,
                                color: _message != null && _message!.read.isEmpty &&
                                        _message!.fromId != APIs.user.uid
                                    ? Colors.black
                                    : const Color.fromARGB(255, 150, 150, 150),
                                fontWeight:_message != null && _message!.read.isEmpty &&
                                        _message!.fromId != APIs.user.uid
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          // Unread Badge
                          if (_message != null &&
                              _message!.read.isEmpty &&
                              _message!.fromId != APIs.user.uid)
                            Container(
                              margin: const EdgeInsets.only(left: 8, top: 18),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
