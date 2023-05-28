import 'package:flutter/material.dart';
import 'package:latihan_responsi_123200146/page/detail_karakter.dart';
import 'package:latihan_responsi_123200146/service/data_api.dart';

class KarakterList extends StatefulWidget {
  const KarakterList({Key? key}) : super(key: key);

  @override
  State<KarakterList> createState() => _ListKarakterPageState();
}

class _ListKarakterPageState extends State<KarakterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Karakter"),
      ),
      body: Container(
          child: FutureBuilder(
        future: GenshinApi().getKarakter(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: Text("Tidak ada data"),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailKarakter(
                                name: snapshot.data[index].toLowerCase()),
                          ));
                    },
                    leading: Image.network(
                      'https://api.genshin.dev/characters/${snapshot.data[index]}/icon',
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(snapshot.data[index].toUpperCase()),
                  ),
                );
              },
            );
          }
        },
      )),
      backgroundColor: Colors.orange,
    );
  }
}
