import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notepad_bloc.dart';
import '../bloc/notepad_state.dart';
import '../data/repository/notepad_reposiory.dart';
import '../data/widget/message_widget.dart';
import 'notepad_list.dart';

class AddNotePad extends StatelessWidget {
  const AddNotePad({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    TextEditingController descriptionController = TextEditingController();
    return BlocProvider(
      create: (context) => NotepadBloc(NotepadRepository()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Note'),
        ),
        body: BlocListener<NotepadBloc, NotepadState>(
          listener: (context, state) {
            if (state is NotepadAddedSuccess) {
              titleController.clear();
              descriptionController.clear();
            } else if (state is NotepadAddErrorState) {
              SnackbarUtils.showError(context, state.message);
            }
          },
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                minLines: 1,
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                controller: titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(hintText: 'Title'),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: descriptionController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 10,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text;
                  final description = descriptionController.text;
                  log('message');
                  context.read<NotepadBloc>().add(AddNotepadEvent(
                        title: title,
                        description: description,
                      ));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const NotePadList()),
                      (route) => false);
                  SnackbarUtils.showSuccess(context, 'Creation Success');
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
