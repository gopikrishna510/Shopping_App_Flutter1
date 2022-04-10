import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';
class LocalStorageHelper{
  static Storage localStorage = window.localStorage;

  //to save data in localStorage
  static Object saveValue(String key, Object value){
    return localStorage[key]= value as String;
  }

  //to get a data
  static String? getValue(String key){
    return localStorage[key];
  }

  //remove data
  static void removeData(String key){
    localStorage.remove(key);
  }
  static void clearAll(){
    localStorage.clear();
  }
}