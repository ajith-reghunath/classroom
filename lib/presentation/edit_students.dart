import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_student/application_bloc/homePage/home_page_bloc.dart';
import 'package:register_student/db/data_model.dart';
import 'package:register_student/design/design.dart';

class EditStudentPage extends StatelessWidget {
  EditStudentPage({super.key, required this.data});

  final StudentModel data;

  final _updateNameController = TextEditingController();

  final _updateAgeController = TextEditingController();

  final _updateContactController = TextEditingController();

  final _updateEmailController = TextEditingController();

  final _updateImagecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _updateAgeController.text = data.age;
    _updateNameController.text = data.name;
    _updateContactController.text = data.contact;
    _updateEmailController.text = data.email;
    _updateImagecontroller.text = data.image;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit ${data.name} ',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://pixlok.com/wp-content/uploads/2022/02/Profile-Icon-SVG-09856789.png'),
                  radius: 90,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _updateNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    } else if (value.contains('@') || value.contains('.')) {
                      return 'Enter valid Name';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 165, 89, 83),
                      ),
                    ),
                    labelText: 'Name',
                    hintText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _updateAgeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age is required';
                    } else if (!RegExp(r'^[0-9]{1,2}').hasMatch(value) ||
                        (value.length) > 2) {
                      return 'Enter valid age';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Age',
                    hintText: 'Age',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _updateEmailController,
                  validator: (value) {
                    if (_updateEmailController.text.isEmpty ||
                        !RegExp(r'[A-Za-z\._\-[0-9]*[@][A-Za-z]*[\.][a-z]{2,4}')
                            .hasMatch(value!)) {
                      return 'Enter valid Email ID';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email',
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _updateContactController,
                  validator: (value) {
                    if ((_updateContactController.text.isEmpty)) {
                      return 'Phone Number is required';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Contact',
                    hintText: 'Contact',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<HomePageBloc, HomePageState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        final name = _updateNameController.text.trim();
                        final age = _updateAgeController.text.trim();
                        final email = _updateEmailController.text.trim();
                        final contact = _updateContactController.text.trim();
                        final image = _updateImagecontroller.text;

                        final student = StudentModel(
                            name: name,
                            age: age,
                            contact: contact,
                            email: email,
                            id: data.id,
                            image: image);

                        context
                            .read<HomePageBloc>()
                            .add(EditStudent(student: student));

                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                ' Details of ${data.name} updated successfully!',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                  ' Details of ${data.name} updated failed!',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.red),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(
                          140,
                          50,
                        ),
                      ),
                      child: const Text('Confirm', style: TextStyle(fontSize: buttonFontSize),),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
