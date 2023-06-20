import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_student/application_bloc/homePage/home_page_bloc.dart';
import 'package:register_student/design/design.dart';

import 'package:register_student/presentation/add_students.dart';
import 'package:register_student/presentation/search.dart';
import 'package:register_student/presentation/student_details.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            showSearch(context: context, delegate: MySearch());
          },
          icon: const Icon(
            Icons.search,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        title: const Text(
          'CLASSROOM',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  context.read<HomePageBloc>().add(DisplayStudents());
                  if (state.studentList.isEmpty) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset('lib/assets/nodata.png'),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        const Text(
                          'No students added !',
                          style: TextStyle(fontSize: 20),
                        ),
                        const Spacer(
                          flex: 1,
                        )
                      ],
                    );
                  }
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = state.studentList[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 30,
                              foregroundImage: NetworkImage(
                                  'https://pixlok.com/wp-content/uploads/2022/02/Profile-Icon-SVG-09856789.png'),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text(
                                        'Do you want to delete ?',
                                      ),
                                      content: Text(
                                        'Confirm to delete student named ${data.name}',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context.read<HomePageBloc>().add(
                                                DeleteStudent(index: index));
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Student Deleted Successfully',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            title: Text(
                              data.name,
                              style: const TextStyle(fontSize: fontSize),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) {
                                    return StudentDetails(
                                      data: data,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: ((context, index) {
                        return const Divider(
                          color: Colors.white,
                          thickness: 1,
                        );
                      }),
                      itemCount: state.studentList.length);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(
                    140,
                    50,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const AddStudents()),
                    ),
                  );
                },
                child: const Text(
                  'Add Student',
                  style: TextStyle(fontSize: buttonFontSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
