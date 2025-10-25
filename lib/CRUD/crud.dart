import 'package:crud_project/CRUD/widgets/ProductCard.dart';
import 'package:flutter/material.dart';
import 'productcontoller.dart';


class Crud extends StatefulWidget {
  const Crud({super.key});

  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  ProductController productController = ProductController();

  Future fetchdata() async {
    await productController.fatchProduct();
    setState(() {});
  }

  productDialog({
    String? id,
    String? name,
    String? img,
    int? qty,
    int? uniPricee,
    int? totalprice,
    required bool isupdate,
  }) {
    TextEditingController productNameController = TextEditingController(
      text: name,
    );
    TextEditingController productIMGController = TextEditingController(
      text: img,
    );
    TextEditingController productQTYController = TextEditingController(
      text: qty != null ? qty.toString() : '',
    );
    TextEditingController productUnitPriceController = TextEditingController(
      text: uniPricee != null ? uniPricee.toString() : '',
    );
    TextEditingController productTotalPriceController = TextEditingController(
      text: totalprice != null ? totalprice.toString() : '',
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isupdate ? 'Update product' : "Add product"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: productIMGController,
              decoration: InputDecoration(labelText: 'Product img'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: productQTYController,
              decoration: InputDecoration(labelText: 'Product QTY'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: productUnitPriceController,
              decoration: InputDecoration(labelText: 'Product Unit Price'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: productTotalPriceController,
              decoration: InputDecoration(labelText: 'Product Total Price'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: () async {
                    setState(() async {
                      isupdate
                          ? productController.UpdateProduct(
                        id.toString(),
                        productNameController.text,
                        productIMGController.text,
                        int.parse(productQTYController.text),
                        int.parse(productUnitPriceController.text),
                        int.parse(productTotalPriceController.text),
                      )
                          : await productController.createProduct(
                        productNameController.text,
                        productIMGController.text,
                        int.parse(productQTYController.text),
                        int.parse(productUnitPriceController.text),
                        int.parse(productTotalPriceController.text),
                      );
                    });
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.fatchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product CRUD'),
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: productController.productes.length,
        itemBuilder: (context, index) {
          var product = productController.productes[index];
          return ProductCard(
            product: product,
            onDelete: () {
              productController.DeleteProduct(product.sId.toString()).then((
                  value,
                  ) async {
                if (value) {
                  await productController.fatchProduct();
                  setState(() {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(' Product Deleted')));
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Something wrong.....!')),
                  );
                }
              });
            },
            onEdit: () {
              productDialog(
                name: product.productName,
                img: product.img,
                id: product.sId,
                qty: product.qty,
                uniPricee: product.unitPrice,
                totalprice: product.totalPrice,
                isupdate: true,

              );

              setState(() {
                fetchdata();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productDialog(isupdate: false);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
