import 'package:flutter/material.dart';

@immutable
abstract class NotepadState {}

class NotepadInitial extends NotepadState {}

class NotepadLoadingState extends NotepadState {}

class NotepadLoadedSuccess extends NotepadState {
  final List<dynamic> notepad;
  NotepadLoadedSuccess({required this.notepad});
}

class NotepadErrorState extends NotepadState {
  final String errorMessage;
  NotepadErrorState(this.errorMessage);
}

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

class NotepadAddingState extends NotepadState {}

class NotepadAddedSuccess extends NotepadState {}

class NotepadAddErrorState extends NotepadState {
  final String message;

  NotepadAddErrorState(this.message);
}

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

class NotepadUpdatingState extends NotepadState {}

class NotepadUpdatedSuccess extends NotepadState {}

class NotepadUpdateErrorState extends NotepadState {
  final String message;

  NotepadUpdateErrorState(this.message);
}
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

class NotepadDeletingState extends NotepadState {}

class NotepadDeletedState extends NotepadState {}

class NotepadDeleteErrorState extends NotepadState {
  final String message;

  NotepadDeleteErrorState(this.message);
}
