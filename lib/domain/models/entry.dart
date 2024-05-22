class EntryModel {
  final String title;
  final String content;
  final DateTime lastUpdated;
  final String journalId;

  EntryModel(
      {required this.title,
      required this.content,
      required this.lastUpdated,
      required this.journalId});

  // make to json and from json

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'lastUpdated': lastUpdated,
      "journalId": journalId
    };
  }

  EntryModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        content = json['content'] as String,
        lastUpdated = json['lastUpdated'] as DateTime,
        journalId = json['journalId'] as String;
}
