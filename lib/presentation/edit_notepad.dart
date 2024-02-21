import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notepad_bloc.dart';
import '../bloc/notepad_state.dart';
import '../data/repository/notepad_reposiory.dart';
import '../data/widget/message_widget.dart';
import 'notepad_list.dart';

class EditNotePad extends StatefulWidget {
  final Map notepad;
  const EditNotePad({super.key, required this.notepad});

  @override
  State<EditNotePad> createState() => _EditNotePadState();
}

class _EditNotePadState extends State<EditNotePad> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.notepad['title'];
    descriptionController.text = widget.notepad['description'];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotepadBloc(NotepadRepository()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Edit Note'),
        ),
        body: BlocListener<NotepadBloc, NotepadState>(
          listener: (context, state) {
            if (state is NotepadUpdatedSuccess) {
              SnackbarUtils.showSuccess(context, 'Edit Success');
              titleController.clear();
              descriptionController.clear();
            } else if (state is NotepadUpdateErrorState) {
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
                  final body = {
                    "title": titleController.text,
                    "description": descriptionController.text,
                    "is_completed": widget.notepad['is_completed'],
                  };
                  context
                      .read<NotepadBloc>()
                      .add(UpdateNotepadEvent(widget.notepad['_id'], body));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const NotePadList()),
                      (route) => false);
                  SnackbarUtils.showSuccess(context, 'Update Success');
                },
                child: const Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
