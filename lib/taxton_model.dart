class TaxonModalClass {
  final int id;
  final String commonName;
  final String latinName;
  final String swaziName;
  final String distribution;
  final String danger;
  final String habits;
  final String description;
  final String behaviour;
  final String firstAid;
  final String biteSymptoms;
  final String media;

  const TaxonModalClass({
    required this.id,
    required this.commonName,
    required this.latinName,
    required this.swaziName,
    required this.distribution,
    required this.danger,
    required this.habits,
    required this.description,
    required this.behaviour,
    required this.firstAid,
    required this.biteSymptoms,
    required this.media,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "commonName": commonName,
        "latinName": latinName,
        "swaziName": swaziName,
        "distribution": distribution,
        "danger": danger,
        "habits": habits,
        "description": description,
        "behaviour": behaviour,
        "firstAid": firstAid,
        "biteSymtomps": biteSymptoms,
        "media": media,
      };
}



//!like....

// class Dog {
//   final int id;
//   final String name;
//   final int age;

//   const Dog({
//     required this.id,
//     required this.name,
//     required this.age,
//   });

//   // Convert a Dog into a Map. The keys must correspond to the names of the
//   // columns in the database.
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'age': age,
//     };
//   }

//   // Implement toString to make it easier to see information about
//   // each dog when using the print statement.
//   @override
//   String toString() {
//     return 'Dog{id: $id, name: $name, age: $age}';
//   }
// }
