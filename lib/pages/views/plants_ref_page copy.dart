import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seeds/models/plantsRef.dart';

class PlantsRefPage extends StatelessWidget {
  const PlantsRefPage({super.key});

  Stream<List<PlantRef>> readPlants() => FirebaseFirestore.instance
      .collection('plantsRef')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => PlantRef.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<PlantRef>>(
        stream: readPlants(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final plants = snapshot.data!;
            return ListView(
              children: plants.map((plant) => buildPlant(plant)).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildPlant(PlantRef plant) {
    return ListTile(title: Text(plant.nom));
  }
}