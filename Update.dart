import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:michel_proj1/List_Emergency.dart';
import 'package:http/http.dart' as http;

class UpdateEmergency extends StatefulWidget {
  final List_Emergency emergency;

  const UpdateEmergency({Key? key, required this.emergency}) : super(key: key);

  @override
  _UpdateEmergencyState createState() => _UpdateEmergencyState();
}

class _UpdateEmergencyState extends State<UpdateEmergency> {
  late List_Emergency selectedEmergency;

  // Controllers for TextFormFields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  List<List_Emergency> emergencyList = [];
  List_Emergency? selectedDropdownEmergency;

  @override
  void initState() {
    super.initState();
    loadEmergencyData();
    selectedEmergency = widget.emergency;

    // Set initial values for controllers
    nameController.text = selectedEmergency.Name;
    numberController.text = selectedEmergency.Number.toString();
    descriptionController.text = selectedEmergency.Description;
    imageController.text = selectedEmergency.Image;
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

        // Set the default selectedDropdownEmergency if the list is not empty
        if (emergencyList.isNotEmpty) {
          selectedDropdownEmergency = emergencyList.first;
          // Set form fields with selectedDropdownEmergency data
          nameController.text = selectedDropdownEmergency!.Name;
          numberController.text = selectedDropdownEmergency!.Number.toString();
          descriptionController.text = selectedDropdownEmergency!.Description;
          imageController.text = selectedDropdownEmergency!.Image;
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

  Future<void> updateEmergencyData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      var response = await http.post(
        Uri.parse("http://localhost/api/Updateemergency.php"),
        headers: {
          'Content-Type': 'application/json', // Update content type to JSON
        },
        body: jsonEncode({
          "originalNumber": selectedEmergency.Number,
          "number": int.parse(numberController.text), // Convert text to int
          "name": nameController.text,
          "description": descriptionController.text,
          "image": imageController.text,
        }),
      );

      if (response.statusCode == 200) {
        print("Emergency data updated successfully");
      } else {
        print("Failed to update emergency data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      errorMessage = 'Failed to update data. $e';
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
        title: const Text("Update Emergency"),
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
                value: selectedDropdownEmergency,
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
                    selectedDropdownEmergency = newValue!;
                    // Set form fields with selectedEmergency data
                    nameController.text = selectedDropdownEmergency!.Name;
                    numberController.text = selectedDropdownEmergency!.Number.toString();
                    descriptionController.text = selectedDropdownEmergency!.Description;
                    imageController.text = selectedDropdownEmergency!.Image;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.red,
                  hintText: 'Select an emergency team',
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
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                await updateEmergencyData();
                // Navigate back to the home page after updating
                Navigator.pop(context);
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
                  'Update Emergency Data',
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
    home: UpdateEmergency(emergency: List_Emergency("", 0, "", "")),
  ));
}
