import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertEmergency extends StatefulWidget {
  const InsertEmergency({Key? key}) : super(key: key);

  @override
  _InsertEmergencyState createState() => _InsertEmergencyState();
}

class _InsertEmergencyState extends State<InsertEmergency> {
  final _formKey = GlobalKey<FormState>();
  final _emergencyNameController = TextEditingController();
  final _numberController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert Emergency"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://images.unsplash.com/photo-1612642132744-cc0e7c59cbae?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emergencyNameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Emergency Name',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.red.withOpacity(0.7),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Emergency Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _numberController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Number',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.red.withOpacity(0.7),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.red.withOpacity(0.7),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _imageUrlController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.red.withOpacity(0.7),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Form is valid, proceed to submit
                    await submitForm();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Insert Emergency'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitForm() async {
    // Construct JSON payload
    Map<String, dynamic> payload = {
      "EmergencyName": _emergencyNameController.text,
      "Number": int.parse(_numberController.text),
      "Description": _descriptionController.text,
      "ImageUrl": _imageUrlController.text,
    };

    // Convert payload to JSON
    String jsonData = jsonEncode(payload);


    String apiUrl = "http://localhost/api/Insertemergency.php";
    var response = await http.post(Uri.parse(apiUrl), body: jsonData);

    // Check the response status
    if (response.statusCode == 200) {
      print("Insert successful");

      // Optionally, you can handle the success scenario here

      // Navigate back to the Home Page
      Navigator.pop(context);
    } else {
      print("Failed to insert data. Status code: ${response.statusCode}");
      // Optionally, you can handle the failure scenario here
    }
  }
}
