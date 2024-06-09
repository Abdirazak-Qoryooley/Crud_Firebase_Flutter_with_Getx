import 'package:crud_operation_firebase/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Homepage extends StatelessWidget {
  final NotesController notesController = Get.put(NotesController());
  final TextEditingController textController = TextEditingController();

  void openNoteBox() {
    Get.defaultDialog(
      title: 'Add Note',
      content: TextFormField(
        controller: textController,
        decoration: InputDecoration(hintText: 'Enter your note'),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            notesController.addNote(textController.text);
            textController.clear();
            Get.back();
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: Icon(Icons.add),
      ),
      body: Obx(() {
        if (notesController.notes.isEmpty) {
          return Center(child: Text('No notes available'));
        }
        return ListView.builder(
          itemCount: notesController.notes.length,
          itemBuilder: (context, index) {
            final note = notesController.notes[index];
            return ListTile(
              title: Text(note['note']),
              subtitle: Text(note['timestamp'].toDate().toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => notesController.deleteNote(note['id']),
              ),
              onTap: () => openEditNoteBox(note['id'], note['note']),
            );
          },
        );
      }),
    );
  }

  void openEditNoteBox(String docID, String currentNote) {
    textController.text = currentNote;
    Get.defaultDialog(
      title: 'Edit Note',
      content: TextFormField(
        controller: textController,
        decoration: InputDecoration(hintText: 'Edit your note'),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            notesController.updateNote(docID, textController.text);
            textController.clear();
            Get.back();
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
