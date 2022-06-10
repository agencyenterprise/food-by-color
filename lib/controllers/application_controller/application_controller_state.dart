abstract class ApplicationControllerState {}

class ApplicationControllerStateInitial extends ApplicationControllerState {}

class ApplicationControllerStateLoaded extends ApplicationControllerState {
  ApplicationControllerStateLoaded({required this.imagePath});

  String imagePath;
}
