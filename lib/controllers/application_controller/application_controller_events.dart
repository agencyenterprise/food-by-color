class ApplicationControllerEvents {}

class ApplicationControllerEventsLoad extends ApplicationControllerEvents {
  ApplicationControllerEventsLoad({
    required this.imagePath,
    required this.answer,
  });
  String answer;
  String imagePath;
}
