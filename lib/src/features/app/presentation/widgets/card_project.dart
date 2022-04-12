import 'package:flutter/material.dart';

class CardProject extends StatelessWidget {
  final String? name;
  final String? avatarUrls;
  final Map<String, String>? headers;

  const CardProject({Key? key, this.name, this.avatarUrls, this.headers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(avatarUrls!, headers: headers ?? {
              'authorization':
                  'Basic Z3JlZ29yeS5pc2NhbGFAdHJpYnUudGVhbTpIakFhUFhyRE5TV09makZHWkJ2Z0Y5NEU='
            }),
            radius: 25.0,
          ),
          SizedBox(width: 20),
          Text(name!, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
