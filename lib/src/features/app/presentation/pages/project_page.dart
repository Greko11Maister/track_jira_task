import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectPage extends StatelessWidget {
  final String ? id;

  const ProjectPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: Text(('Project id:' + id!), style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.white54),
      body: Container(

      ),
    );
  }
}
