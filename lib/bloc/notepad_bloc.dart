import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
import '../data/repository/notepad_reposiory.dart';
import 'notepad_state.dart';

part 'notepad_event.dart';

class NotepadBloc extends Bloc<NotepadEvent, NotepadState> {
  final NotepadRepository notepadRepository;
  NotepadBloc(this.notepadRepository) : super(NotepadInitial()) {
    on<GetNotepadEvent>(_onGetNotepadEvent);
    on<AddNotepadEvent>(_onAddNotepadEvent);
    on<UpdateNotepadEvent>(_onUpdateNotepadEvent);
    on<DeleteNotepadEvent>(_onDeleteNotepadEvent);
  }

  void _onGetNotepadEvent(
      GetNotepadEvent event, Emitter<NotepadState> emit) async {
    emit(NotepadLoadingState());
    try {
      final notepad = await notepadRepository.fetchNotepad();
      emit(NotepadLoadedSuccess(notepad: notepad!));
    } catch (e) {
      log(e.toString());
      emit(NotepadErrorState(e.toString()));
    }
  }

  void _onAddNotepadEvent(
      AddNotepadEvent event, Emitter<NotepadState> emit) async {
    emit(NotepadAddingState());
    try {
      final title = event.title;
      final description = event.description;
      final body = {
        "title": title,
        "description": description,
        "is_completed": false,
      };
      final response = await notepadRepository.addData(body);
      if (response) {
        emit(NotepadAddedSuccess());
      } else {
        emit(NotepadAddErrorState('Creation failed'));
      }
    } catch (e) {
      log(e.toString());
      emit(NotepadAddErrorState(e.toString()));
    }
  }

  void _onUpdateNotepadEvent(
      UpdateNotepadEvent event, Emitter<NotepadState> emit) async {
    emit(NotepadUpdatingState());
    try {
      final responce = await notepadRepository.updatedata(event.id, event.body);
      if (responce) {
        emit(NotepadUpdatedSuccess());
      } else {
        emit(NotepadUpdateErrorState('Edit failed'));
      }
    } catch (e) {
      log(e.toString());
      emit(NotepadUpdateErrorState(e.toString()));
    }
  }

  void _onDeleteNotepadEvent(
      DeleteNotepadEvent event, Emitter<NotepadState> emit) async {
    emit(NotepadDeletingState());
    try {
      final responce = await notepadRepository.delectById(event.id);
      if (responce) {
        emit(NotepadDeletedState());
        final notepad = await notepadRepository.fetchNotepad();
        emit(NotepadLoadedSuccess(notepad: notepad!));
      } else {
        emit(NotepadDeleteErrorState('Deletion Failed'));
      }
    } catch (e) {
      log(e.toString());
      emit(NotepadDeleteErrorState(e.toString()));
    }
  }
}
