import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:michel_proj1/Login.dart';
import 'package:michel_proj1/Update.dart';
import 'Details.dart';
import 'Insert.dart';
import 'List_Emergency.dart';
import 'Delete.dart'; // Import the Delete.dart file
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<List_Emergency> emergencyList = [];
  List_Emergency? selectedEmergency;

  @override
  void initState() {
    super.initState();
    loadEmergency();
  }

  Future<void> loadEmergency() async {
    String url = "http://localhost/api/listemergency.php";

    try {
      var response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        String res = response.body;
        emergencyList = [];

        for (var row in jsonDecode(res)) {
          var emergency = List_Emergency(
            row["Name"],
            int.parse(row["Number"]),
            row["Description"],
            row["Image"],
          );
          emergencyList.add(emergency);
        }

        // Set the default selectedEmergency if the list is not empty
        if (emergencyList.isNotEmpty) {
          selectedEmergency = emergencyList.first;
        }
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        // Update the UI
      });
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> navigateToUpdateEmergency() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateEmergency(emergency: selectedEmergency!),
      ),
    );
    // After returning from UpdateEmergency, reload the data
    await loadEmergency();
  }

  Future<void> navigateToInsertEmergency() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InsertEmergency()),
    );
    // After returning from InsertEmergency, reload the data
    await loadEmergency();
  }

  Future<void> navigateToDeleteEmergency() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeleteEmergency()),
    );
    // After returning from DeleteEmergency, reload the data if the result is true
    if (result == true) {
      await loadEmergency();
    }
  }

  void logout() {
    // Navigate back to the LoginPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select a Lebanese Emergency Service",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://images.unsplash.com/photo-1612642132744-cc0e7c59cbae?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 55,
                child: DropdownButtonFormField<List_Emergency>(
                  value: selectedEmergency,
                  items: emergencyList.map((List_Emergency emergency) {
                    return DropdownMenuItem<List_Emergency>(
                      value: emergency,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          emergency.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (List_Emergency? newValue) {
                    setState(() {
                      selectedEmergency = newValue!;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(selectedEmergency!),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.red,
                    hintText: 'Ex: Police',
                    hintStyle: const TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  dropdownColor: Colors.red,
                  style: const TextStyle(color: Colors.white),
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  alignment: Alignment.center,
                  selectedItemBuilder: (BuildContext context) {
                    return emergencyList.map<Widget>((List_Emergency? item) {
                      return Text(
                        item?.toString() ?? "",
                        style: const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedEmergency == null
                    ? () {
                  showSnackBar("Please select an Emergency to be updated");
                }
                    : navigateToUpdateEmergency,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Update Emergency',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: navigateToInsertEmergency,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Insert A New Emergency Team',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: navigateToDeleteEmergency,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Delete Emergency',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
