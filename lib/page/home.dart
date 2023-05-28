import 'package:flutter/material.dart';
import 'package:latihan_responsi_123200146/page/detail_karakter.dart';
import 'package:latihan_responsi_123200146/page/detail_weapon.dart';
import 'package:latihan_responsi_123200146/page/list_karakter.dart';
import 'package:latihan_responsi_123200146/page/list_weapon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomepageState();
}

class _HomepageState extends State<Home> {
  String? _lastOpen;
  String? _code;

  Future<void> _getLastOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastOpen = prefs.getString("last_open");
      _code = prefs.getString("code");
    });
  }

  @override
  void initState() {
    super.initState();
    _lastOpen = "";
    _code = "";
    _getLastOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://static.tvtropes.org/pmwiki/pub/images/gi_34.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_lastOpen != null && _lastOpen != "")
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Card(
                  child: ListTile(
                    onTap: () async {
                      if (_code == "characters") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailKarakter(name: _lastOpen!),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailWeapon(
                                name: _lastOpen!,
                              ),
                            ));
                      }
                    },
                    leading: Image.network(
                        'https://api.genshin.dev/${_code}/${_lastOpen!.toLowerCase()}/icon'),
                    title: Text(_lastOpen.toString().toUpperCase()),
                  ),
                ),
              ),
            Container(
              width: 150,
              child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KarakterList(),
                        ));
                    _getLastOpen();
                  },
                  child: Text("Karakter")),
            ),
            Container(
                width: 150,
                child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeaponList(),
                          ));
                      _getLastOpen();
                    },
                    child: Text("Weapon")))
          ],
        ),
      ),
    );
  }
}
