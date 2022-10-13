abstract class AdminPageBaseInsertDTO{
  final String title;

  const AdminPageBaseInsertDTO({
    required this.title,
  });

  Map<String, dynamic> toJson();
}