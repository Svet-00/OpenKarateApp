import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../domain/entities/document.dart';
import '../../../../domain/entities/photo.dart';
import '../../../../domain/entities/post.dart';
import '../../../../presentation/widgets/attachment.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget(this.post, {Key key}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final _controller = ExpandableController(initialExpanded: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        widget.post.photos.forEach((photo) {
          precacheImage(NetworkImage(photo.url), context);
        });
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textBuilder = LayoutBuilder(
      builder: (context, size) {
        // determine if text will exceed max lines
        // -- start --
        var span = TextSpan(
          text: widget.post.text,
          style: TextStyle(fontSize: 16),
        );

        var tp = TextPainter(
          maxLines: 5,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: span,
        );

        tp.layout(maxWidth: size.maxWidth);

        final exceeded = tp.didExceedMaxLines;
        // -- end --

        final expandablePanel = ExpandablePanel(
          controller: _controller,
          collapsed: Column(
            children: [
              Text.rich(
                TextSpan(text: widget.post.text),
                overflow: TextOverflow.fade,
                maxLines: 5,
              ),
              TextButton(
                onPressed: _controller.toggle,
                child: Text('Показать полностью'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  textStyle:
                      Theme.of(context).textTheme.button.copyWith(fontSize: 15),
                ),
              ).alignment(Alignment.bottomLeft).constrained(maxHeight: 40),
            ],
          ),
          expanded: Column(
            children: [
              Text(widget.post.text),
              TextButton(
                onPressed: _controller.toggle,
                child: Text('Свернуть'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  textStyle:
                      Theme.of(context).textTheme.button.copyWith(fontSize: 15),
                ),
              ).alignment(Alignment.bottomLeft).constrained(maxHeight: 40),
            ],
          ),
        );

        final shortText = AutoSizeText.rich(
          TextSpan(
            text: widget.post.text,
            style: TextStyle(fontSize: 19),
          ),
          minFontSize: 16,
          maxFontSize: 20,
          maxLines: 5,
        ).padding(bottom: 8);

        final displayedText = exceeded ? expandablePanel : shortText;
        return displayedText
            .padding(horizontal: 16, top: 8)
            .alignment(Alignment.topLeft);
      },
    );

    return Container(
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            textBuilder,
            _buildPhotos(widget.post.photos),
            ..._buildDocuments(widget.post.documents),
          ],
        ),
      ).padding(bottom: 4),
    );
  }

  Widget _buildPhotos(List<Photo> photos) {
    if (photos.isEmpty) {
      return Container();
    }
    // TODO: handle multiple images
    // TODO: open fullscreen on tap on photo
    return Image.network(photos[0].url);
  }

  List<Widget> _buildDocuments(List<Document> docs) {
    final result = <Widget>[];
    result.addAll(
      docs.map(
        (d) => Attachment.document(
          url: d.url,
          filename: d.originalFilename,
        ),
      ),
    );
    if (result.isNotEmpty) {
      final space = SizedBox(height: 8);
      result.insert(0, space);
      result.add(space);
    }
    return result;
  }
}
