import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Product List Screen"),
        ),
      ),
    );
  }
}