
import 'package:flutter/material.dart';
import 'package:sciencenotes/widgets/video_card.dart';
import '../domain/content.dart';

class VideosPage extends StatefulWidget {
  final Content conteudo;

  const VideosPage({
    Key? key,
    required this.conteudo,
  }) : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPage();
}

class _VideosPage extends State<VideosPage> {
  //List<VideoCardWidget> lista = DBcontent.listaVideos;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        VideoCardWidget(
          content: widget.conteudo,
          index: 0,
        ),
        const SizedBox(height: 4),
        VideoCardWidget(
          content: widget.conteudo,
          index: 1,
        ),
        const SizedBox(height: 4),
        VideoCardWidget(
          content: widget.conteudo,
          index: 2,
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
