import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String yourname = "";
  String secondname = "";
  TextEditingController yournamecontroller = TextEditingController();
  TextEditingController secondnamecontroller = TextEditingController();
  Map<String, String> data = {
    'F': "friend",
    'L': "Love",
    'A': "Affection",
    'M': "Marriage",
    'E': "Enemy",
    'S': "Sister/brother"
  };
  String getrelationship(List<String> flames, length) {
    final findRemovelength = length % flames.length;
    final local = [...flames];
    local.removeAt(
        findRemovelength == 0 ? flames.length - 1 : findRemovelength - 1);
    if (flames.length == 1) {
      return flames.join('');
    }
    return getrelationship(local, length);
  }

  void yourrelationship() {
    List<String> longestname =
        (yourname.length > secondname.length ? yourname : secondname).split('');
    List<String> smallestname =
        (yourname.length < secondname.length ? yourname : secondname).split('');
    final local = [...longestname];
    for (var singlecharacters in local) {
      if (smallestname.contains(singlecharacters)) {
        longestname.remove(singlecharacters);
        smallestname.remove(singlecharacters);
      }
    }
    final totallength = longestname.length + smallestname.length;
    List<String> flames = ['F', 'L', 'A', 'M', 'E', 'S'];
    final result = getrelationship(flames, totallength);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Your relationship'),
        content: Text(data[result] ?? ""),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cleartext();
            },
            child: Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void cleartext() {
    yournamecontroller.clear();
    secondnamecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flames_app'),
        backgroundColor: Colors.green,
      ),
    
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: TextField(
                onChanged: ((value) {
                  yourname = value;
                }),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter yourname',
                ),
                controller: yournamecontroller,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: TextField(
                onChanged: ((value) {
                  secondname = value;
                }),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Partnername'),
                controller: secondnamecontroller,
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
                onPressed: () {
                  yourrelationship();
                },
                child: Text('your relationship'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                ),
          ],
        ),
      ),
    );
  }
}
