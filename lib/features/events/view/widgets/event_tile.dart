import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/utils/datetime_x.dart';
import '../../../../core/utils/open_external.dart';
import '../../../../domain/entities/document.dart';
import '../../../../domain/entities/event.dart';
import '../../../../domain/entities/link.dart';
import '../../../../presentation/widgets/attachment.dart';

class EventTile extends StatefulWidget {
  const EventTile({
    Key key,
    @required this.event,
  }) : super(key: key);

  final Event event;

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  ExpandableController _controller;
  final dateFormat = DateFormat('dd.M.y');

  @override
  void initState() {
    super.initState();
    _controller = ExpandableController(initialExpanded: false);
  }

  @override
  Widget build(BuildContext context) {
    final collapsed = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(widget.event.title).fontSize(20),
          onTap: _controller.toggle,
        ),
      ],
    );

    final expanded = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(left: 16),
          title: Text(widget.event.title).fontSize(20),
          trailing: IconButton(
            icon: Icon(Icons.close),
            onPressed: _controller.toggle,
            padding: EdgeInsets.zero,
          ),
        ),
        ListTile(
          leading: Icon(Icons.emoji_transportation),
          title: Text(
            widget.event.address,
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
          onTap: () => OpenExternal.openMap(widget.event.address),
        ),
        _buildDatesRow(widget.event),
        _buildDescription(widget.event),
        ..._buildLinksWidgets(widget.event.links),
        ..._buildDocumentWidgets(widget.event.documents),
        SizedBox(height: 10),
      ],
    );

    return ExpandableNotifier(
      controller: _controller,
      child: ScrollOnExpand(
        scrollOnCollapse: true,
        scrollOnExpand: true,
        child: ExpandablePanel(
          theme: ExpandableThemeData(
            animationDuration: Duration(milliseconds: 300),
            collapseIcon: Icons.close,
            iconPlacement: ExpandablePanelIconPlacement.right,
            sizeCurve: Curves.ease,
          ),
          collapsed: collapsed,
          expanded: expanded,
        ),
      ),
    )
        .decorated(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        )
        .padding(horizontal: 8.0, vertical: 4.0);
  }

  List<Widget> _buildLinksWidgets(List<Link> links) {
    return links
        .map((e) => Attachment.link(url: e.url, title: e.title))
        .toList();
  }

  List<Widget> _buildDocumentWidgets(List<Document> docs) {
    return docs
        .map((e) =>
            Attachment.document(url: e.url, filename: e.originalFilename))
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDescription(Event event) {
    if (event.description == null || event.description.isEmpty) {
      return Container();
    }
    return ListTile(
      leading: Icon(Icons.description),
      title: Text(
        widget.event.description,
        softWrap: true,
        overflow: TextOverflow.fade,
      ),
    );
  }

  Widget _buildDatesRow(Event event) {
    if (event.startDate.toDate() == event.endDate.toDate()) return Container();
    return ListTile(
      leading: Icon(Icons.date_range),
      title: Text(
        '${dateFormat.format(widget.event.startDate)}'
        ' - ${dateFormat.format(widget.event.endDate)}',
        softWrap: true,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
