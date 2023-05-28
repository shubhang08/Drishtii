import 'package:flutter/material.dart';

class DeveloperInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Developer Info'),
        backgroundColor: Colors.transparent,

      ),
      backgroundColor: Color(0x993C3E52),
      body:
      Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          ListView(
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children:[
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DeveloperCard(
                        name: 'Shubhang Verma',
                        email: 'shubhang1911014@akgec.ac.in',
                        imagePath: 'assets/shubhang.jpg',
                      ),
                      SizedBox(height: 16),
                      DeveloperCard(
                        name: 'Harshita Singhal',
                        email: 'harshita1911053@akgec.ac.in',
                        imagePath: 'assets/harshita.jpg',
                      ),
                      SizedBox(height: 16),
                      DeveloperCard(
                        name: 'Anisha Singh',
                        email: 'anisha1911061@akgec.ac.in',
                        imagePath: 'assets/anisha.jpg',
                      ),
                      SizedBox(height: 16),
                      DeveloperCard(
                        name: 'Rydam Agrawal',
                        email: 'rydam1911007@akgec.ac.in',
                        imagePath: 'assets/rydam.jpg',
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ]
          )

      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final String name;
  final String email;
  final String? imagePath;

  const DeveloperCard({
    required this.name,
    required this.email,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Container(
        color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imagePath != null)
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(imagePath!),
                ),
              SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                email,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}