/// Bir iş ilanını temsil eden model sınıfı.
/// JSON'dan gelen veriyi tip güvenli bir Dart nesnesine çeviririz.
class Job {
  final int id;
  final String title;
  final String company;
  final String location;
  final String type;
  final String salary;
  final String experience;
  final String education;
  final String category;
  final String about;
  final List<String> requirements;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.salary,
    required this.experience,
    required this.education,
    required this.category,
    required this.about,
    required this.requirements,
  });

  /// JSON (Map) -> Job nesnesi.
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as int,
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      type: json['type'] as String,
      salary: json['salary'] as String,
      experience: json['experience'] as String,
      education: json['education'] as String,
      category: json['category'] as String,
      about: json['about'] as String,
      requirements: (json['requirements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }
}
