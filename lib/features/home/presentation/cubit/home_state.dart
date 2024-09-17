part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ChangeIndexSuccessState extends HomeState {}

class ChangeIndexLoadingState extends HomeState {}

class FeatchSurahSuccessState extends HomeState {}

class FeatchSurahLoadingState extends HomeState {}

class FeatchSurahErrorState extends HomeState {}

class PlayAudioLoadingState extends HomeState {}

class PlayAudioSuccessState extends HomeState {}

class FeatchHizbSuccessState extends HomeState {
  final Hizb hizb;
  FeatchHizbSuccessState({required this.hizb});
}

class FeatchHizbLoadingState extends HomeState {}

class FeatchHizbErrorState extends HomeState {}
