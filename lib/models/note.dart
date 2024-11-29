class Note {
  int? id;
  String hashTag;
  String url;
  String summarize;
  String sence;
  DateTime? createdAt;
  DateTime? updatedAt;

  Note({
    this.id,
    required this.hashTag,
    required this.url,
    required this.summarize,
    required this.sence,
    this.createdAt,
    this.updatedAt,
  });

  // Convert a Note to a Map. The keys must correspond to the column names in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hash_tag': hashTag,
      'url': url,
      'summarize': summarize,
      'sence': sence,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Create a Note from a Map. This method is useful when retrieving data from the database
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      hashTag: map['hash_tag'],
      url: map['url'],
      summarize: map['summarize'],
      sence: map['sence'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  // Optional: Create a copy of the Note with optional parameter overrides
  Note copyWith({
    int? id,
    String? hashTag,
    String? url,
    String? summarize,
    String? sence,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      hashTag: hashTag ?? this.hashTag,
      url: url ?? this.url,
      summarize: summarize ?? this.summarize,
      sence: sence ?? this.sence,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Optional: Override toString for easy printing
  @override
  String toString() {
    return 'Note{id: $id, hashTag: $hashTag, url: $url, summarize: $summarize, sence: $sence, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  // Optional: Implement equality
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          hashTag == other.hashTag &&
          url == other.url &&
          summarize == other.summarize &&
          sence == other.sence;

  @override
  int get hashCode =>
      id.hashCode ^
      hashTag.hashCode ^
      url.hashCode ^
      summarize.hashCode ^
      sence.hashCode;
}
