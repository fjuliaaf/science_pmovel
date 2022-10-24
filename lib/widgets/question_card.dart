import 'package:flutter/material.dart';
import 'package:sciencenotes/domain/content.dart';
import 'package:sciencenotes/assets/colors/custom_colors.dart';

class QuestionCard extends StatefulWidget {
  final Content content;
  final int index;

  const QuestionCard({
    Key? key,
    required this.content,
    required this.index,
  }) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int selectedValue = 0;
  Color colorAltCorrect = Colors.transparent;
  Color colorAltIncorrect = Colors.transparent;
  bool isAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: widget.content.question[widget.index].colorQuestion,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(
                  text: widget.content.question[widget.index].institute,
                  isBold: true),
              const SizedBox(
                height: 4,
              ),
              buildText(text: widget.content.question[widget.index].question),
              const SizedBox(
                height: 4,
              ),
              buildContainerQuestion(
                  alternative: widget.content.question[widget.index].alt1,
                  index: 1),
              const SizedBox(
                height: 4,
              ),
              buildContainerQuestion(
                  alternative: widget.content.question[widget.index].alt2,
                  index: 2),
              const SizedBox(
                height: 4,
              ),
              buildContainerQuestion(
                  alternative: widget.content.question[widget.index].alt3,
                  index: 3),
              const SizedBox(
                height: 4,
              ),
              buildContainerQuestion(
                  alternative: widget.content.question[widget.index].alt4,
                  index: 4),
              const SizedBox(
                height: 4,
              ),
              buildContainerQuestion(
                  alternative: widget.content.question[widget.index].alt5,
                  index: 5),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: widget.content.colorButton,
                      ),
                      onPressed: () {
                        setState((){
                          checkAlternative();
                          isAnswer = true;
                        });
                      },
                      child: const Text(
                        'Responder',
                        style: TextStyle(
                          fontSize: 26,
                          color: CustomColors.white,
                          fontFamily: 'AmaticSC-Regular',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      isAnswer == true && selectedValue !=
                          widget.content.question[widget.index].alterCorrect ?
                      'A resposta certa era a de opção '
                          '${widget.content.question[widget.index].
                      alterCorrect}!' : '',
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text buildText({
    required String text,
    bool isBold = false,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : null,
        fontSize: 18,
        color: Colors.black,
        fontFamily: 'Abel-Regular',
      ),
      textAlign: TextAlign.justify,
    );
  }

  // Color applyColor({
  //   required int selected, required int altCorrect,
  // }) {
  //   if(altCorrect != selected){
  //     return colorAltIncorrect;
  //   }
  //   return colorAltCorrect;
  // }

  Container buildContainerQuestion({
    required String alternative,
    required int index,
    int replyCurrent = 0,
  })
  {
    return Container(
      color: isAnswer==true && selectedValue == index && index !=
          widget.content.question[widget.index].alterCorrect ?
          colorAltIncorrect
          : Colors.transparent,
      child: Row(
        children: [
          Radio(
            activeColor: isAnswer == true && selectedValue == index && index ==
                widget.content.question[widget.index].alterCorrect ?
            Colors.green : Colors.blueGrey,
            value: index,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                if (isAnswer==true && index !=
                    widget.content.question[widget.index].alterCorrect){
                  replyCurrent = index;
                }
                selectedValue = index;
                isAnswer = false;
              });
            },
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              alternative,
              style: TextStyle(
                fontSize: 18,
                color: isAnswer == true && selectedValue == index && index ==
                    widget.content.question[widget.index].alterCorrect ?
                    Colors.green : Colors.black,
                fontFamily: 'Abel-Regular',
                fontWeight: isAnswer == true && selectedValue == index && index ==
                    widget.content.question[widget.index].alterCorrect ?
                FontWeight.bold : null,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  void checkAlternative() {
    if (selectedValue ==
        widget.content.question[widget.index].alterCorrect) {
      colorAltCorrect = CustomColors.biologyColor;
    } else {
      colorAltIncorrect = CustomColors.redColor;
    }
  }
}
