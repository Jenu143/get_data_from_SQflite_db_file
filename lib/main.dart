// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_database/taxton_model.dart';

void main() {
  runApp(
    const AssetsDatabase(),
  );
}

class AssetsDatabase extends StatefulWidget {
  const AssetsDatabase({Key? key}) : super(key: key);

  @override
  _AssetsDatabaseState createState() => _AssetsDatabaseState();
}

class _AssetsDatabaseState extends State<AssetsDatabase> {
  bool readTable = false;
  Database? database;

  Future<String> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "taxon.db");

//! Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        print("Try Catch");
      }

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "taxon.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Reading Existing Database");
    }

    // open the database
    database = await openDatabase(path, readOnly: true);

    return path;
  }

//! read tabale and get data
  Future<List<TaxonModalClass>> readTables1() async {
    final Database? db = database;
    final List<Map<String, dynamic>> res = await db!.query("species");

    if (res.isNotEmpty) {
      return List.generate(res.length, (i) {
        return TaxonModalClass(
          id: res[i]['id'],
          commonName: res[i]['commonName'],
          latinName: res[i]['latinName'],
          swaziName: res[i]['swaziName'],
          distribution: res[i]['distribution'],
          danger: res[i]['danger'],
          habits: res[i]['habits'],
          description: res[i]['description'],
          behaviour: res[i]['behaviour'],
          firstAid: res[i]['firstAid'],
          biteSymptoms: res[i]['biteSymptoms'] ?? "F",
          media: res[i]['media'],
        );
      });
    } else {
      return [];
    }
  }

  late Future<List<TaxonModalClass>> getDataList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataList = readTables1();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black87,
            title: const Text(
              "Read Assets Database",
              style: TextStyle(fontSize: 14),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                FutureBuilder(
                  future: initDatabase(),
                  builder: (context, snapshot) {
                    double sWidth = MediaQuery.of(context).size.width;
                    double sHeight = MediaQuery.of(context).size.height;
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: sWidth,
                        height: sHeight * 1.1,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(height: 5),
                            const Text(
                              "Database Created, Now you can load tables",
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black87),
                              ),
                              onPressed: () {
                                setState(() {
                                  readTable = true;
                                });
                              },
                              child: const Text("Load Tables"),
                            ),
                            FutureBuilder<dynamic>(
                              future: readTables1(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null &&
                                    readTable == true) {
                                  List<TaxonModalClass> tx = snapshot.data;

                                  return SizedBox(
                                    height: sHeight * 0.779,
                                    child: ListView.builder(
                                      itemCount: tx.length,
                                      itemBuilder: ((context, index) {
                                        return Card(
                                          margin: const EdgeInsets.only(
                                              top: 15, left: 5, right: 5),
                                          color: Colors.grey.shade200,
                                          child: ListTile(
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 12),
                                                RixhTextNameAndAns(
                                                  heading: "ID",
                                                  ans: "${tx[index].id}",
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "commonName",
                                                  ans: tx[index].commonName,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "latinName",
                                                  ans: tx[index].latinName,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "swaziName",
                                                  ans: tx[index].swaziName,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "distribution",
                                                  ans: tx[index].distribution,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "danger",
                                                  ans: tx[index].danger,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "habits",
                                                  ans: tx[index].habits,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "description",
                                                  ans: tx[index].description,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "behaviour",
                                                  ans: tx[index].behaviour,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "firstAid",
                                                  ans: tx[index].firstAid,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "biteSymptoms",
                                                  ans: tx[index].biteSymptoms,
                                                ),
                                                const SizedBox(height: 12),

                                                //
                                                RixhTextNameAndAns(
                                                  heading: "media",
                                                  ans: tx[index].media,
                                                ),
                                                const SizedBox(height: 12),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(height: 250),
                                      CircularProgressIndicator(
                                        color: Colors.black87,
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  readTablesFromDb() {}
}

//heading and name
class RixhTextNameAndAns extends StatelessWidget {
  const RixhTextNameAndAns({
    Key? key,
    required this.heading,
    required this.ans,
  }) : super(key: key);

  final String heading;
  final String ans;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "$heading :  ".toUpperCase(),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
          children: [
            TextSpan(
              text: ans,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
    );
  }
}
