import 'package:flutter/material.dart';
import 'List_Emergency.dart';

class DetailsPage extends StatefulWidget {
  final List_Emergency selectedEmergency;

  DetailsPage(this.selectedEmergency);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedEmergency.Name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10), // Adjusted the SizedBox height
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage("${widget.selectedEmergency.Image}"),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Adjusted the SizedBox height
              Text(
                "You Can Reach The ${widget.selectedEmergency.Name} Team at ${widget.selectedEmergency.Number}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16, // Increased the font size
                  backgroundColor: Colors.red,
                ),
              ),
              const SizedBox(height: 10), // Adjusted the SizedBox height
              Text(
                "${widget.selectedEmergency.Description}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16, // Increased the font size
                  backgroundColor: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
