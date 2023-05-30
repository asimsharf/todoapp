import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/BL/blocs/todo/todo_blocs.dart';
import 'package:todoapp/DL/entities/todo.dart';
import 'package:todoapp/utils/the_colors.dart';

class CreateTodos extends StatelessWidget {
  const CreateTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController theIdController = TextEditingController();
    TextEditingController theTaskController = TextEditingController();
    TextEditingController theDescriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة مهمة جديدة"),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم إضافة المهمة بنجاح")),
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "معرف المهمة",
              style: TextStyle(
                fontSize: 16,
                color: TheColors.white,
              ),
            ),
            const SizedBox(height: 10),
            _inputField(
              context: context,
              controller: theIdController,
              hintText: "ادخل معرف المهمة",
            ),
            const SizedBox(height: 10),
            const Text(
              "عنوان المهمة",
              style: TextStyle(
                fontSize: 16,
                color: TheColors.white,
              ),
            ),
            const SizedBox(height: 10),
            _inputField(
              context: context,
              controller: theTaskController,
              hintText: "ادخل عنوان المهمة",
            ),
            const SizedBox(height: 10),
            const Text(
              "وصف المهمة",
              style: TextStyle(
                fontSize: 16,
                color: TheColors.white,
              ),
            ),
            const SizedBox(height: 10),
            _inputField(
              context: context,
              controller: theDescriptionController,
              hintText: "ادخل وصف المهمة",
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              color: TheColors.secondary,
              child: const Text(
                "إضافة المهمة",
                style: TextStyle(
                  fontFamily: 'montserrat_regular',
                ),
              ),
              onPressed: () {
                Todo todo = Todo(
                  id: theIdController.text,
                  task: theTaskController.text,
                  description: theDescriptionController.text,
                );
                context.read<TodosBloc>().add(AddTodos(todo: todo));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({context, controller, hintText}) {
    return TextField(
      controller: controller,
      onChanged: (value) {},
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: TheColors.deepWhite,
      ),
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        fillColor: TheColors.darkGrey,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: TheColors.whiteGrey,
          fontSize: 14,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
