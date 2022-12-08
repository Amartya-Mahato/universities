import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class DashBoardEvent extends Equatable {
  const DashBoardEvent();
}

@immutable
class InitializeDashBoard extends DashBoardEvent {
  @override
  List<Object?> get props => [];
}