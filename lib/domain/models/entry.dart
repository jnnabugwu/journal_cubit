class EntryModel {
  final String title;
  final String content;
  final DateTime lastUpdated;
  final int journalId;

  EntryModel(
      {required this.title,
      required this.content,
      required this.lastUpdated,
      required this.journalId});
}
