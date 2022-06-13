class ApplicationControllerEvents {}

class ApplicationControllerEventsLoad extends ApplicationControllerEvents {
  ApplicationControllerEventsLoad({
    required this.imagePath,
    required this.answer,
    required this.properties,
  });
  dynamic properties;
  String answer;
  String imagePath;
}
