import 'package:flutter/material.dart';
import 'package:sciencenotes/domain/messages.dart';

class ListMessages extends StatefulWidget {
  final Messages msg;
  const ListMessages({
    Key? key,
    required this.msg,
  }) : super(key: key);

  @override
  State<ListMessages> createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.msg.msg,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                  fontFamily: 'Abel-Regular'),
            ),
          ]),
        ]),
      ],
    );
  }
}
