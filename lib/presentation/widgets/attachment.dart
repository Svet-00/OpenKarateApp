import 'dart:developer';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:pedantic/pedantic.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/injection_container.dart';
import '../../core/network/network_client.dart';
import '../../features/settings/cubit/settings_cubit.dart';
import '../../presentation/widgets/flushbar_helpers.dart';

const iconCircleSize = Size.square(40);

abstract class Attachment extends StatefulWidget {
  const Attachment({Key key}) : super(key: key);

  const factory Attachment.link({
    Key key,
    @required String url,
    String title,
  }) = _Link;

  const factory Attachment.document({
    Key key,
    @required String url,
    @required String filename,
  }) = _Document;
}

class _Link extends Attachment {
  final String url;
  final String title;
  const _Link({
    Key key,
    @required this.url,
    this.title,
  }) : super(key: key);

  @override
  State<_Link> createState() => _LinkState();
}

class _LinkState extends State<_Link> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: _AttachmentIcon(
          icon: Icons.link,
          size: iconCircleSize,
        ),
        title: Text(widget.title ?? widget.url),
        visualDensity: VisualDensity.standard,
        onTap: () async {
          if (await canLaunch(widget.url)) {
            unawaited(launch(widget.url));
          } else {
            FlushbarHelpers.createError(
              message: 'К сожалению, данный тип ссылок не поддерживается',
            )
              // ignore: unawaited_futures
              ..show(context);
          }
        },
      ),
    );
  }
}

class _Document extends Attachment {
  final String url;
  final String filename;

  const _Document({
    Key key,
    @required this.url,
    @required this.filename,
  }) : super(key: key);

  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<_Document> {
  final networkClient = sl<NetworkClient>();

  double downloadProgress = 0;
  bool _fileExists = false;
  String _filepath;

  DownloadState get downloadState {
    if (downloadProgress == 1 || _fileExists) {
      return DownloadState.finished;
    } else {
      return downloadProgress == 0
          ? DownloadState.notStarted
          : DownloadState.inProgress;
    }
  }

  @override
  void initState() {
    super.initState();
    _realInit();
  }

  void _realInit() async {
    final settingsCubit = BlocProvider.of<SettingsCubit>(context);
    if (kIsWeb) {
      setState(() {
        _filepath = widget.filename;
      });
    } else {
      final downloadDir = await settingsCubit.state.downloadsDirectory;

      if (downloadDir != null) {
        _filepath = path.join(downloadDir.path, widget.filename);
        final file = io.File(_filepath);
        final fileExists = await file.exists();
        setState(() {
          _fileExists = fileExists;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        dense: false,
        leading: _FileTypeWithDownloadIndicator(
          downloadProgress: downloadProgress,
          downloadState: downloadState,
          onTap: () async {
            if (downloadState == DownloadState.notStarted) {
              await _downloadDocument(context);
            } else if (downloadState == DownloadState.finished) {
              final result = await OpenFile.open(_filepath);
              if (result.type != ResultType.done) {
                // ошибочки
                log(result.type.toString());
              }
            }
          },
        ),
        title: Text(widget.filename),
        visualDensity: VisualDensity.standard,
        onTap: downloadState == DownloadState.finished
            ? () async {
                final result = await OpenFile.open(_filepath);
                if (result.type != ResultType.done) {
                  // ошибочки
                  log(result.type.toString());
                }
              }
            : null,
      ),
    );
  }

  Future<void> _downloadDocument(BuildContext context) async {
    try {
      await networkClient.download(
        widget.url,
        _filepath,
        onReceiveProgress: (count, total) {
          setState(() {
            downloadProgress = count / total;
            if (downloadProgress == 1) {
              _fileExists = true;
            }
          });
        },
      );
    } on DioError {
      setState(() {
        downloadProgress = 0;
      });
      unawaited(
        FlushbarHelpers.createError(
          message: '''
Не удалось скачать файл "${widget.filename}".
Пожалуйста, проверьте подключение к интернету и повторите попытку''',
          duration: Duration(seconds: 6),
        ).show(context),
      );
    }
  }
}

enum DownloadState { notStarted, inProgress, finished }

class _AttachmentIcon extends StatelessWidget {
  final IconData icon;
  final Size size;
  const _AttachmentIcon({
    Key key,
    @required this.icon,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary,
      ).center().decorated(
            color: Theme.of(context).colorScheme.primaryVariant,
            shape: BoxShape.circle,
          ),
    );
  }
}

class _FileTypeWithDownloadIndicator extends StatelessWidget {
  const _FileTypeWithDownloadIndicator({
    Key key,
    @required this.downloadProgress,
    @required this.downloadState,
    @required this.onTap,
  }) : super(key: key);

  final double downloadProgress;
  final DownloadState downloadState;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final iconLayer = GestureDetector(
      child: _AttachmentIcon(
        icon: downloadState == DownloadState.notStarted
            ? Icons.south
            : Icons.description,
        size: iconCircleSize,
      ),
      onTap: onTap,
    );

    final progressIndicatorLayer = SizedBox.fromSize(
      size: iconCircleSize,
      child: CircularProgressIndicator(
        value: downloadProgress,
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.primaryVariant,
        ),
      ),
    );

    final layers = <Widget>[];
    if (downloadState == DownloadState.inProgress) {
      layers.add(progressIndicatorLayer);
    }
    layers.add(iconLayer);

    return Stack(children: layers);
  }
}
