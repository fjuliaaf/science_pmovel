///essa página é para reaproveitamento global, já que o widget será usado outras vezes
import 'package:flutter/material.dart';
import 'package:sciencenotes/domain/content.dart';
// import 'package:url_launcher/url_launcher.dart';

class VideoCardWidget extends StatefulWidget {
  final Content content;
  final int index;

  const VideoCardWidget({Key? key, required this.content, required this.index})
      : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCardWidget> {
  //Videos get video => widget.video; //esse video é igual a video da classe VideoCardWidget | isso é pra não estar fazendo widget.video em todo lugar

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(),
            const SizedBox(height: 8),
            Text(
                widget.content.videos[widget.index].tituloVideo,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Abel-Regular')),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.timer_outlined),
                SizedBox(width: 8),
                Text(widget.content.videos[widget.index].tempoDuracao,
                    style: TextStyle(fontSize: 24, fontFamily: 'Abel-Regular')),
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    onPressed: (){} , //openURL
                    child: Text(
                      'ASSISTIR AGORA',
                      style: TextStyle(color: Color(0xffffffff), fontSize: 24, fontFamily: 'AmaticSC-Regular'),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff411049),
                        padding: EdgeInsets.all(16))),
              ],
            ),
          ],
        ),
      ),
      color: Color(0xfff6e7f9),
    );
  }

  buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(4), bottom: Radius.circular(4)),
      child: Image.network(widget.content.videos[widget.index]
          .urlImage), 
    );
  }

  // void openURL() async {
  //   const url =
  //       'https://www.youtube.com/watch?v=_6ILoTeChCE'; //widget.content.video[widget.index].urlVideo
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw "Falha ao carregar";
  //   }
  // }
}
