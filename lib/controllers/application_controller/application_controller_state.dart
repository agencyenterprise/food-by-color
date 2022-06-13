abstract class ApplicationControllerState {}

class ApplicationControllerStateInitial extends ApplicationControllerState {}

class ApplicationControllerStateLoaded extends ApplicationControllerState {
  ApplicationControllerStateLoaded({
    required this.imagePath,
    required this.answer,
    required this.properties,
  });
  dynamic properties;
  String answer;
  String imagePath;
}
