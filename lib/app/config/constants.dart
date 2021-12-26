import 'package:flutter/material.dart';

BoxDecoration decoration(double boderradius) => BoxDecoration(
        borderRadius: BorderRadius.circular(boderradius),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.7),
          )
        ]);
