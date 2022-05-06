import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/injection_container.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/configuration_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/pages/home_page.dart';

class ConfigurationPage extends StatelessWidget {
  static const String routeName = '/configuration/page';
  final ConfigurationController _controller = sl<ConfigurationController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Configuración', style: TextStyle(color: Colors.black87)),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white54
      ),
      body: GetBuilder<ConfigurationController>(
        init: _controller,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextFormField(
                  controller: _.userNameCtrl,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_circle, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'User Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  controller: _.tokenCtrl,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                      hintText: 'Ingrese Token',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style:  ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                    child: const SizedBox(
                      width: 100,
                      height: 50,
                      child: Center(child: Text('Setear Token',style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)),
                    ),
                    onPressed: (){
                    _.saveToken(_.tokenCtrl.text, _.userNameCtrl.text);
                    Get.to(HomePage());
                    // print(_.tokenCtrl.text);
                    }
                )
              ],
            ),

          );
        }
      ),
    );
  }
}
