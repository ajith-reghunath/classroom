import 'package:flutter/material.dart';
import 'package:register_student/db/data_model.dart';
import 'package:register_student/presentation/edit_students.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key, required this.data});
  final StudentModel data;

  @override
  Widget build(BuildContext context) {
    // getAllStudents();
    return Scaffold(
          appBar: AppBar(
            title: Center(child: Text(data.name.toString().toUpperCase())),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => EditStudentPage(
                              data: data,
                            )),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://pixlok.com/wp-content/uploads/2022/02/Profile-Icon-SVG-09856789.png'),
                    radius: 90,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Name : ${data.name}',
                          style:const TextStyle(fontSize: 20)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Age : ${data.age}',
                          style:const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Email : ${data.email}',
                          style:const TextStyle(fontSize: 20)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Contact : ${data.contact}',
                          style:const TextStyle(fontSize: 20)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
