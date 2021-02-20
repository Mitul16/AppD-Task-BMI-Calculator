import 'package:flutter/material.dart';
import 'dart:io';
import 'globals.dart';
import 'dart:convert';

class Note {
  String value, filename;
  bool checked;

  Note(String value, bool checked, {String filename}) {
    this.value = value;
    this.checked = checked;
    this.filename = filename;
  }
  
  void setValue(String value) {
    this.value = value;
  }
  
  void setFilename(String filename) {
    this.filename = filename;
  }
  
  void setChecked(bool checked) {
    this.checked = checked;
  }
  
  Note.fromJson(Map<String, dynamic> json) : value = json['value'], checked = json['checked'] == 'true';

  Map<String, dynamic> toJson() => {
    'value': value,
    'checked': checked.toString()
  };

  Note.fromFile(File file) {
    Map<String, dynamic> json = jsonDecode(file.readAsStringSync());

    this.value = json['value'];
    this.checked = json['checked'] == 'true';
    this.filename = file.path;
  }

  void toFile(File file) {
    file.writeAsStringSync(jsonEncode(this));
  }

  Note.readFromFile() {
    if (filename != null) {
      File file = File(filename);
      if (file.existsSync()) {
        Map<String, dynamic> json = jsonDecode(file.readAsStringSync());

        this.value = json['value'];
        this.checked = json['checked'] == 'true';
      }
    }
  }

  void saveToFile() {
    File file = File(filename);

    if (!file.existsSync()) {
      file.createSync();
    }
    
    file.writeAsStringSync(jsonEncode(this));
  }
}

class NoteModel extends ChangeNotifier {
  List<Note> notes;
  Directory notesDir;

  NoteModel() {
    notes = <Note>[];
    notesDir = Directory('$appDirPath/notes');

    if (!notesDir.existsSync()) {
      notesDir.createSync();
    }
  }

  void addNote(Note note) {
    notes.add(note);
    
    String filename = '${notesDir.path}/note_${DateTime.now()}.json';
    note.setFilename(filename);
    note.saveToFile();
    
    notifyListeners();
  }
  
  void editNote(int index, String newValue) {
    notes[index].setValue(newValue);
    notes[index].saveToFile();
    
    notifyListeners();
  }

  void removeNote(int index) {
    File(notes[index].filename).deleteSync();
    notes.removeAt(index);

    notifyListeners();
  }

  void toggleNoteCheckedMark(int index) {
    notes[index].setChecked(!notes[index].checked);
    notes[index].saveToFile();

    notifyListeners();
  }

  bool isEmpty() {
    return notes.isEmpty;
  }

  int getNoteCount() {
    return notes.length;
  }

  Note getNote(int index) {
    return notes[index];
  }

  void readData() {
    notes = <Note>[];

    // how to read in background? Isolate? Multi-threading in single threaded Dart?????????????????????????????????????????????
    notesDir.listSync().forEach((filename) {
      notes.add(Note.fromFile(File(filename.path)));
    });

    notifyListeners();
  }
}
