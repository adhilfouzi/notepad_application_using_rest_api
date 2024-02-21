part of 'notepad_bloc.dart';

@immutable
sealed class NotepadEvent {}

final class GetNotepadEvent extends NotepadEvent {}

final class AddNotepadEvent extends NotepadEvent {
  final String title;
  final String description;
  AddNotepadEvent({required this.title, required this.description});
}

class UpdateNotepadEvent extends NotepadEvent {
  final String noteId;
  final Map body;
  UpdateNotepadEvent(this.noteId, this.body);
}

class DeleteNotepadEvent extends NotepadEvent {
  final String noteId;
  DeleteNotepadEvent(this.noteId);
}
