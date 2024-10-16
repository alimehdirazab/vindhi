import 'package:vindhi_app/data/models/Banner/banner_model.dart';

abstract class BannerState {}

class BannerInitialState extends BannerState {}

class BannerLoadingState extends BannerState {}

class BannerSuccessState extends BannerState {
  final BannerModel response;

  BannerSuccessState(this.response);
}

class BannerFailureState extends BannerState {
  final String error;

  BannerFailureState(this.error);
}
