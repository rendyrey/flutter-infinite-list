import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Mahasiswa.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState(){
    super.initState();
    // fetchJml();
    fetchFive();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        fetchFive();
      }
    });
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  List<String> setring = new List();
  List<Mahasiswa> mahasiswa = new List();
  ScrollController _scrollController = new ScrollController();
  Client http = Client();
  int jmlmhs;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(   
        title: Text(widget.title),
      ),
      body:ListView.builder(
        controller: _scrollController,
        itemCount:setring.length,
        itemBuilder:(BuildContext context, int index){
          return Container(
            constraints: BoxConstraints.tightFor(height:200.0),
            child:Text(setring[index]+" "+index.toString()+" "+mahasiswa[index].nama)
          );
        }
      )
    );
  }

  fetch() async {
    final response = await http.get("http://api.ratisa-media.com/api/mahasiswa/31",headers: {HttpHeaders.authorizationHeader:"Bearer rEnDy"});
    if(response.statusCode == 200){
      setState((){
        setring.add(json.decode(response.body)['nama']);
        Mahasiswa mhs = new Mahasiswa();
        var data = json.decode(response.body);
        mhs.nama = data['nama'];
        // mahasiswa = mahasiswaFromJson(response.body);
        mahasiswa.add(mhs);
        // String receivedJson = response.body;
      });
    }else{
      throw Exception('Failed to loadssssssssssssssssssss');
    }
  }

  // fetchJml() async {
  //   final response = await http.get("http://api.ratisa-media.com/api/jmlmhs");
  //   if(response.statusCode == 200){
  //     setState((){
  //       jmlmhs = json.decode(response.body)['jmlmhs'];
  //     });
  //   }else{
  //     throw Exception('Failed to load');
  //   }
  // }

  fetchFive(){
    for(int i = 0; i < 5; i++){
      fetch();
    }
  }
}
