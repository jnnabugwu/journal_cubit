import 'package:cloud_firestore/cloud_firestore.dart';

class EntryModel {
  final String title;
  final String content;
  final DateTime lastUpdated;
  final String journalId;
  final String userId;

  EntryModel(
      {required this.title,
      required this.content,
      required this.lastUpdated,
      required this.journalId,
      required this.userId
      });

  // make to json and from json

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'lastUpdated': lastUpdated,
      "journalId": journalId,
      "userId" : userId
    };
  }

  EntryModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        content = json['content'] as String,
        lastUpdated = json['lastUpdated'] as DateTime,
        journalId = json['journalId'] as String,
        userId = json['userId'] as String;

  factory EntryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return EntryModel(
      title: data?['title'] as String,
      content: data?['content'] as String,
      lastUpdated: data?['lastUpdated'] as DateTime,
      journalId: data?['journalId'] as String,
      userId: data?['userId'] as String
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'lastUpdated': lastUpdated,
      "journalId": journalId,
      "userId": userId
    };
  }

}
