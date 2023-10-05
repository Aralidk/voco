import 'package:flutter/material.dart';

ButtonStyle roundedIndigoButton(){
  return  ElevatedButton.styleFrom(
      backgroundColor: Colors.indigo,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0)
  ));
}