class Evento {
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;
  // You can add more properties like location, color for event, etc.

  Evento({required this.title, required this.description, required this.startTime, required this.endTime});

  // Example of an additional method: Calculate event duration
  Duration get duration => endTime.difference(startTime);

  // You might want to add more methods or logic as per your application's needs
}
