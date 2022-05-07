import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_club/src/data/local/data_source/app_data_source.dart';
import 'package:blog_club/src/data/model/article_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

part 'article_event.dart';

part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final AppDatasource _appDataSource;

  ArticleBloc({required AppDatasource appDataSource})
      : _appDataSource = appDataSource,
        super(ArticleLoading()) {
    on<ArticleStarted>(_onStarted);
    on<ArticleNavigateToBack>(_onNavigateToBack);
  }

  _onStarted(ArticleStarted event, Emitter<ArticleState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(ArticleSuccess(article: _appDataSource.article));
  }

  _onNavigateToBack(ArticleNavigateToBack event, Emitter<ArticleState> emit) {
    GoRouter.of(event.context).pop();
  }
}
