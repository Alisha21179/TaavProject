abstract class AdminPageBaseEditDTO {
  final String title;
  final String? imageBase64String;

  const AdminPageBaseEditDTO(
      {required this.title, required this.imageBase64String});

  Map<String, dynamic> toJson();
}
