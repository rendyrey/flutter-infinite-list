import 'dart:io';

import 'package:http/http.dart' show Client;
import 'Mahasiswa.dart';

class ApiService{
  final String baseUrl = "http://api.ratisa-media.com/";
  Client client = Client();

  Future<List<Mahasiswa>> getMahasiswa() async {
    final response = await client.get(
      "$baseUrl/api/mahasiswa",headers: {HttpHeaders.authorizationHeader:"Bearer rEnDy"});
    if(response.statusCode == 200){
      return mahasiswaFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<List<Mahasiswa>> getMahasiswaPagination(int from,int to) async {
    final response = await client.get(
      "$baseUrl/api/mahasiswa/pagination/"+from.toString()+"/"+to.toString(),headers: {HttpHeaders.authorizationHeader:"Bearer rEnDy"});
    if(response.statusCode == 200){
      return mahasiswaFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<bool> createMahasiswa(Mahasiswa data) async {
  final response = await client.post(
    "$baseUrl/api/mahasiswa/create",
    headers: {"content-type": "application/json",HttpHeaders.authorizationHeader:"Bearer rEnDy"},
    body: mahasiswaToJson(data),
  );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateMahasiswa(Mahasiswa data) async {
    final response = await client.post("$baseUrl/api/mahasiswa/update/${data.id}",headers:{HttpHeaders.authorizationHeader:"Bearer rEnDy",
    "content-type":"application/json"},body:mahasiswaToJson(data));
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> deleteMahasiswa(int id) async {
    final response = await client.delete("$baseUrl/api/mahasiswa/delete/$id",headers:{HttpHeaders.authorizationHeader:"Bearer rEnDy",
    "content-type":"application/json"});
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}