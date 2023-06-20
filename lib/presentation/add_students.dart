import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_student/application_bloc/addStudent/add_student_bloc.dart';
import 'package:register_student/application_bloc/homePage/home_page_bloc.dart';
import 'package:register_student/db/data_model.dart';
import 'package:register_student/design/design.dart';
import 'package:register_student/presentation/home_page.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _contactController = TextEditingController();

  final _emailController = TextEditingController();

  final _imageController = TextEditingController();

  dynamic imageurl;

  bool visibilityImage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ADD STUDENT',
        ),
      ),
      body: BlocBuilder<AddStudentBloc, AddStudentState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://pixlok.com/wp-content/uploads/2022/02/Profile-Icon-SVG-09856789.png'),
                    radius: 90,
                  ),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            controller: _nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name is required';
                              } else if (value.contains('@') ||
                                  value.contains('.')) {
                                return 'Enter valid Name';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Name",
                              hintText: 'Name',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _ageController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Age is required';
                              } else if (!RegExp(r'^[0-9]{1,2}')
                                      .hasMatch(value) ||
                                  (value.length) > 2) {
                                return 'Enter valid age';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Age",
                              hintText: 'Age',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (_emailController.text.isEmpty ||
                                  !RegExp(r'[A-Za-z\._\-[0-9]*[@][A-Za-z]*[\.][a-z]{2,4}')
                                      .hasMatch(value!)) {
                                return 'Enter valid Email ID';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Email",
                              hintText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _contactController,
                            validator: (value) {
                              if ((_contactController.text.isEmpty)) {
                                return 'Phone Number is required';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Contact",
                              hintText: 'Contact',
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(
                                140,
                                50,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final name = _nameController.text.trim();
                                final age = _ageController.text.trim();
                                final email = _emailController.text.trim();
                                final contact = _contactController.text.trim();
                                imageurl = _imageController.text;

                                if (name.isEmpty ||
                                    age.isEmpty ||
                                    email.isEmpty ||
                                    contact.isEmpty) {
                                  return;
                                }
                                final student = StudentModel(
                                    name: name,
                                    age: age,
                                    email: email,
                                    contact: contact,
                                    image: imageurl);
                                context
                                    .read<AddStudentBloc>()
                                    .add(AddStudent(student: student));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> onAddButton() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Student Added Successfully',
        ),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  String imageValidation() {
    if (imageurl == null || imageurl.toString().isEmpty) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png';
    } else {
      return imageurl;
    }
  }
}
