import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/injection_container.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/configuration_controller.dart';

class ConfigurationPage extends StatelessWidget {
  static const String routeName = '/configuration/page';
  final ConfigurationController _controller = sl<ConfigurationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Configuración', style: TextStyle(color: Colors.black87)),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white54
      ),
      body: GetBuilder<ConfigurationController>(
        init: _controller,
        builder: (_) {
          return Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  controller: _.tokenCtrl,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_circle, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                      hintText: 'Ingrese Token',
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.grey,
                    child: Container(
                      width: 100,
                      height: 50,
                      child: const Center(child: Text('Setear Token',style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)),
                    ),
                    onPressed: (){}
                )
              ],
            ),

          );
        }
      ),
    );
  }
}
