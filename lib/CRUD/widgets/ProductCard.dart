import 'package:flutter/material.dart';

import '../../Model/product_model.dart';


class ProductCard extends StatelessWidget {
  final Data product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProductCard({
    super.key,
    required this.product, required this.onDelete, required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: Image.network(
              (product.img != null && product.img.toString().startsWith('http')) ?
              product.img.toString() : 'https://media.istockphoto.com/id/938396020/photo/no-sign-on-isolated-white-background.jpg?s=612x612&w=0&k=20&c=KrkO01NGnhca4AzCe65dSLb-b_aCjCcbaxQxhn7RA2I=',

            ),
          ),
          Text(
            product.productName.toString() ,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Price : \$${product.unitPrice} | QTY : ${product.qty}',
            style:TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ) ,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              IconButton(onPressed: onEdit, icon: Icon(Icons.edit, color: Colors.blue,)),
              IconButton(onPressed: onDelete, icon: Icon(Icons.delete, color: Colors.red,)),
            ],
          )
        ],
      ),
    );
  }
}
