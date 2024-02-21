import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notepad_bloc.dart';
import '../bloc/notepad_state.dart';
import '../data/widget/message_widget.dart';
import 'add_notepad.dart';
import 'edit_notepad.dart';

class NotePadList extends StatelessWidget {
  const NotePadList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotepadBloc>().add(GetNotepadEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Note Pad'),
      ),
      body: BlocConsumer<NotepadBloc, NotepadState>(
        listener: (context, state) {
          if (state is NotepadErrorState) {
            SnackbarUtils.showError(context, 'Error: ${state.errorMessage}');
          }
        },
        builder: (context, state) {
          if (state is NotepadErrorState) {
            return Center(
                child: Text(
              'Error: ${state.errorMessage}',
            ));
          } else if (state is! NotepadLoadedSuccess) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final items = state.notepad;
            if (items.isEmpty) {
              return const Center(
                child: Text("No Note found"),
              );
            }
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['_id'];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(
                    item['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item['description'],
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 13),
                    textWidthBasis: TextWidthBasis.longestLine,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 'edit') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditNotePad(notepad: item)));
                      } else if (value == 'delete') {
                        context.read<NotepadBloc>().add(DeleteNotepadEvent(id));
                      } else {
                        log('error on PopupMenuButton');
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        )
                      ];
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddNotePad()));
          },
          label: const Text('Add Note')),
    );
  }
}
