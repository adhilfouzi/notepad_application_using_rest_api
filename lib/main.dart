import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_rest_api/bloc/notepad_bloc.dart';
import 'data/repository/notepad_reposiory.dart';
import 'package:todo_app_rest_api/presentation/notepad_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NotepadRepository(),
      child: BlocProvider(
        create: (context) => NotepadBloc(context.read<NotepadRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: const NotePadList(),
        ),
      ),
    );
  }
}
