class Item {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  Item({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  Item copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
} 