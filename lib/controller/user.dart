import 'package:crud_operation_firebase/services/firestore.dart';
import 'package:get/get.dart';


class NotesController extends GetxController {
  final FirestoreServices firestoreServices = FirestoreServices();
  var notes = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    notes.bindStream(firestoreServices.getNotesStream());
  }

  void addNote(String note) {
    firestoreServices.addNote(note);
  }

  void updateNote(String docID, String newNote) {
    firestoreServices.updateNote(docID, newNote);
  }

  void deleteNote(String docID) {
    firestoreServices.deleteNote(docID);
  }
}
