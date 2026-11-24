class NoteModel {
  String? id;
  String title;
  String content;
  List<String> categories; // أصبح مصفوفة لدعم أقسام متعددة مثل ['Work', 'Ideas']
  String dateTime;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.categories,
    required this.dateTime,
  });

  factory NoteModel.fromFirestore(Map<String, dynamic> json, String id) {
    return NoteModel(
      id: id,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      // تحويل البيانات القادمة من الفايربيس إلى لستة نصوص في فلاتر
      categories: List<String>.from(json['categories'] ?? []), 
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'categories': categories, // تُحفظ كمصفوفة (Array) في الفاير ستور
      'dateTime': dateTime,
    };
  }
}