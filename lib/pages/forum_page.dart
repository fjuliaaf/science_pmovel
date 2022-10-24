import 'package:flutter/material.dart';
import 'package:sciencenotes/assets/colors/custom_colors.dart';
import 'package:sciencenotes/pages/enter_page.dart';
import 'package:sciencenotes/domain/messages.dart';
import 'package:sciencenotes/data/messages_dao.dart';
import 'package:sciencenotes/widgets/content_card.dart';
import 'package:sciencenotes/widgets/forum_space.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  TextEditingController msgController = TextEditingController();
  Future<List<Messages>> list = MessageDao().listMessages();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: CustomColors.appeButtonColor,
        title: const Text(
          'Science Notes',
          style: TextStyle(
              fontSize: 24,
              color: CustomColors.white,
              fontFamily: 'Staatliches'),
        ),
      ),
      backgroundColor: CustomColors.gradienColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Spacer(),
            buildListView(),
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Digite sua mensagem',
                            labelStyle: TextStyle(
                              color: CustomColors.textColor,
                              fontFamily: 'Abel-Regular',
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: CustomColors.appeButtonColor,
                              ),
                            ),
                          ),
                          controller: msgController,
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: onPressedButton,
                  // style: ElevatedButton.styleFrom(
                  //   primary: CustomColors.appeButtonColor,
                  //   minimumSize: (const Size(170, 40)),
                  // ),
                  color: Color.fromARGB(255, 85, 139, 135),
                  //const Text(

                  // style: TextStyle(
                  //   fontSize: 28,
                  //   color: CustomColors.white,
                  //   fontFamily: 'AmaticSC-Regular',
                  // ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onPressedButton() async {
    String msg = msgController.text;

    Messages message = Messages(msg: msg);
    await MessageDao().saveMessage(message: message);
  }

  buildListView() {
    return FutureBuilder<List<Messages>>(
        future: list,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Messages> list = snapshot.data ?? [];
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return ListMessages(msg: list[index]);
              },
            );
          }
          return Center(child: const CircularProgressIndicator());
        });
  }
}
