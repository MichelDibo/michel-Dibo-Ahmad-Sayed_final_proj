import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:michel_proj1/List_Emergency.dart';
import 'package:http/http.dart' as http;

class DeleteEmergency extends StatefulWidget {
  @override
  _DeleteEmergencyState createState() => _DeleteEmergencyState();
}

class _DeleteEmergencyState extends State<DeleteEmergency> {
  List<List_Emergency> emergencyList = [];
  List_Emergency? selectedEmergency;

  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadEmergencyData();
  }

  Future<void> loadEmergencyData() async {
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

  Future<void> deleteEmergencyData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      var response = await http.post(
        Uri.parse("http://localhost/api/Deleteemergency.php"),
        headers: {
          'Content-Type': 'application/json', // Update content type to JSON
        },
        body: jsonEncode({
          "number": selectedEmergency!.Number,
        }),
      );

      if (response.statusCode == 200) {
        print("Emergency deleted successfully");
        // Set the result to true to indicate a successful deletion
        Navigator.pop(context, true);
      } else {
        print("Failed to delete emergency. Status code: ${response.statusCode}");
      }
    } catch (e) {
      errorMessage = 'Failed to delete data. $e';
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Emergency"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // DropdownButtonFormField for emergency selection
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
                        emergency.Name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (List_Emergency? newValue) {
                  setState(() {
                    selectedEmergency = newValue!;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.red,
                  hintText: 'Select an emergency team to delete',
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
                      item?.Name ?? "",
                      style: const TextStyle(color: Colors.white),
                    );
                  }).toList();
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                if (selectedEmergency != null) {
                  await deleteEmergencyData();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : const Text(
                  'Delete Emergency',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DeleteEmergency(),
  ));
}
