import 'package:flutter/material.dart';
import 'package:latihan_responsi_123200146/model/model_weapon.dart';
import 'package:latihan_responsi_123200146/service/data_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailWeapon extends StatefulWidget {
  String name;
  DetailWeapon({Key? key, required this.name}) : super(key: key);

  @override
  State<DetailWeapon> createState() => _DetailWeaponPageState();
}

class _DetailWeaponPageState extends State<DetailWeapon> {
  Future<void> _setLastOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_open', widget.name);
    prefs.setString('code', 'weapons');
  }

  @override
  void initState() {
    super.initState();
    _setLastOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
            "Detail ${widget.name[0].toUpperCase()}${widget.name.substring(1).toLowerCase()}"),
      ),
      body: FutureBuilder(
        future: GenshinApi().getDetailWeapon(widget.name),
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
            WeaponModel weapon = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://api.genshin.dev/weapons/${widget.name}/icon'),
                              fit: BoxFit.contain)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      weapon.name,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < weapon.rarity; i++)
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
