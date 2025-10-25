
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crud_project/CRUD/utils/urls.dart';
import '../Model/product_model.dart';

class ProductController{
  List<Data> productes = [];

  Future fatchProduct() async{

    final response = await http.get(Uri.parse(URLS.readProduct));
    //print(response.statusCode);
    //print(response.body);


    if(response.statusCode == 200)
    {
      final data = jsonDecode(response.body);
      ProductModel model = ProductModel.fromJson(data);
      productes = model.data ?? [] ;
    }

  }

  Future<bool>createProduct(String name, String img, int qty,int UnitPrice,int totalPrice) async {

    final response = await http.post(Uri.parse(URLS.CreateProduct),
        headers: {'Content-Type' : 'application/json' },
        body: jsonEncode(
            {
              "ProductName": name,
              "ProductCode": DateTime.now().microsecondsSinceEpoch,
              "Img": img,
              "Qty": qty,
              "UnitPrice": UnitPrice ,
              "TotalPrice": totalPrice,
            }
        )
    );

    //print(response.statusCode);
    //print(response.body);


    if(response.statusCode == 200){
      await fatchProduct();
      return true;
    }
    else{
      return false;
    }

  }
  Future<bool>UpdateProduct(String productId,String name, String img, int qty,int UnitPrice,int totalPrice) async {

    final response = await http.post(Uri.parse(URLS.UpdateProduct(productId)),
        headers: {'Content-Type' : 'application/json' },
        body: jsonEncode(
            {
              "ProductName": name,
              "ProductCode": DateTime.now().microsecondsSinceEpoch,
              "Img": img,
              "Qty": qty,
              "UnitPrice": UnitPrice ,
              "TotalPrice": totalPrice,
            }
        )
    );

    //print(response.statusCode);
    //print(response.body);


    if(response.statusCode == 200){
      await fatchProduct();
      return true;
    }
    else{
      return false;
    }

  }


  Future<bool>DeleteProduct(String ProductId) async{
    final response = await http.delete(Uri.parse(URLS.deleteProduct(ProductId)));

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }

  }
}