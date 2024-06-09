import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final CollectionReference notesCollection = FirebaseFirestore.instance.collection('notes');

  // CREATE: add a new note
  Future<void> addNote(String note) {
    return notesCollection.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get notes from the database
  Stream<List<Map<String, dynamic>>> getNotesStream() {
    return notesCollection.orderBy('timestamp', descending: true).snapshots().map((query) {
      return query.docs.map((doc) {
        return {
          'id': doc.id,
          'note': doc['note'],
          'timestamp': doc['timestamp'],
        };
      }).toList();
    });
  }

  // UPDATE: update a note given a doc ID
  Future<void> updateNote(String docID, String newNote) {
    return notesCollection.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: delete a note given a doc ID
  Future<void> deleteNote(String docID) {
    return notesCollection.doc(docID).delete();
  }
}
