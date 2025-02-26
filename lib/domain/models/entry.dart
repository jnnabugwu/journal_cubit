import 'package:cloud_firestore/cloud_firestore.dart';

class EntryModel {
  final String title;
  final String content;
  final DateTime lastUpdated;
  final String journalId;
  final String userId;

  EntryModel({
    required this.title,
    required this.content,
    required this.lastUpdated,
    required this.journalId,
    required this.userId
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'lastUpdated': Timestamp.fromDate(lastUpdated), // Convert DateTime to Timestamp when storing
      "journalId": journalId,
      "userId": userId
    };
  }

  EntryModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        content = json['content'] as String,
        lastUpdated = (json['lastUpdated'] as Timestamp).toDate(), // Convert Timestamp to DateTime
        journalId = json['journalId'] as String,
        userId = json['userId'] as String;

  factory EntryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return EntryModel(
      title: data['title'] as String,
      content: data['content'] as String,
      lastUpdated: data['lastUpdated'] is Timestamp 
          ? (data['lastUpdated'] as Timestamp).toDate()
          : data['lastUpdated'] is DateTime 
              ? data['lastUpdated'] as DateTime
              : DateTime.now(), // Fallback for any legacy or corrupted data
      journalId: data['journalId'] as String,
      userId: data['userId'] as String
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'lastUpdated': Timestamp.fromDate(lastUpdated), // Convert DateTime to Timestamp when storing
      "journalId": journalId,
      "userId": userId
    };
  }
}