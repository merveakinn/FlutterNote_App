import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class Note {
  String title;
  String content;

  Note({
    required this.title,
    required this.content,
  });
}

class NotesController extends GetxController {
  final notes = <Note>[].obs;

  void addNote(String title, String content) {
    notes.add(Note(
      title: title,
      content: content,
    ));
  }

  void deleteNote(int index) {
    notes.removeAt(index);
  }
}

class MyApp extends StatelessWidget {
  final NotesController notesController = Get.put(NotesController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes App',
      home: Scaffold(
        appBar: AppBar(
        /*  title: Text(
              'Notes App',
            style: ProjectStyles.merveStyle,


          ),*/


          title: const TitleTextWidget(text: "Not Uygulaması"),




        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Enter Note Title',
                  labelStyle: ProjectStyles.merveStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: 'Enter Note Content'),
                ),
              ),
           /*   ElevatedButton(
                onPressed: () {
                  notesController.addNote(
                    titleController.text,
                    contentController.text,
                  );
                  titleController.clear();
                  contentController.clear();
                },
                child: Text('Add Note'),
              ),*/


              Container(//container vererek buton genişliğini ayarladım bu olmasa sabit widget değeriydi
          width: 100.0, // Genişlik
              child: FloatingActionButton(onPressed: () {
                notesController.addNote(
                    titleController.text,
                    contentController.text,

                );
    titleController.clear();
    contentController.clear();

    },
    child: Text('Not Ekle',
    textAlign: TextAlign.center,
    ),
    ),
        ),

              SizedBox(height: 20),
              Obx(
                    () => Expanded(
                  child: ListView.builder(
                    itemCount: notesController.notes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(notesController.notes[index].title),
                        subtitle: Text(notesController.notes[index].content),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => notesController.deleteNote(index),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ProjectStyles {
  static const TextStyle merveStyle = TextStyle(
    color: Colors.amber,
  );
}

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // style: Theme.of(context).textTheme.headlineMedium,//aşağıda bir de color ekliyorum ek özellik
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      color: Colors.blue,
    )
    );
  }
}
