import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';
import 'package:openkarateapp/presentation/widgets/fullscreen_message.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../presentation/widgets/app_circular_progress_indicator.dart';
import '../../../presentation/widgets/bottom_loader.dart';
import '../../../presentation/widgets/flushbar_helpers.dart';
import '../../localizations/error_localizations.dart';
import '../bloc/newsfeed_cubit.dart';
import 'widgets/post_widget.dart';

class NewsfeedView extends StatefulWidget {
  NewsfeedView({Key key}) : super(key: key);

  @override
  _NewsfeedViewState createState() => _NewsfeedViewState();
}

class _NewsfeedViewState extends State<NewsfeedView> {
  final ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  Completer<void> _loadingCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<NewsfeedCubit, NewsfeedState>(
        listener: (context, state) {
          if (state.pageStatus.isError) {
            _markLoadingCompleted();
            unawaited(
              FlushbarHelpers.createError(
                title: ErrorLocalizations.failedToLoadFromNetwork('новости'),
                message: ErrorLocalizations.checkNetworkConnection(),
              ).show(context),
            );
          } else if (state.pageStatus.isSuccess) {
            _markLoadingCompleted();
          }
        },
        builder: (context, state) => _buildView(state),
      ),
    );
  }

  Widget _buildView(NewsfeedState state) {
    switch (state.pageStatus) {
      case NewsfeedStatus.initial:
        return AppCircularProgressIndicator().center();
      case NewsfeedStatus.success:
      case NewsfeedStatus.error:
      default:
        return RefreshIndicator(
          child: state.posts.isEmpty && state.hasReachedMax
              ? FullscreenMessage('Нет новостей')
              : ListView.builder(
                  itemCount: state.hasReachedMax
                      ? state.posts.length
                      : state.posts.length + 1,
                  itemBuilder: (context, index) {
                    return index >= state.posts.length
                        ? BottomLoader()
                        : PostWidget(state.posts[index]);
                  },
                ),
          onRefresh: () async =>
              await BlocProvider.of<NewsfeedCubit>(context).refresh(),
        );
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<NewsfeedCubit>(context).fetchMorePosts();
    }
  }

  void _markLoadingCompleted() {
    _loadingCompleter?.complete();
    _loadingCompleter = Completer<void>();
  }
}
