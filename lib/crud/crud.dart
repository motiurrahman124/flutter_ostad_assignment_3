import 'package:assignment_3/crud/widget/productCard.dart';
import 'package:assignment_3/crud/ProductController.dart';
import 'package:flutter/material.dart';

class Crud extends StatefulWidget {
  const Crud({super.key});

  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  final Productcontroller productcontroller = Productcontroller();

  Future<void> fetchData() async {
    await productcontroller.fetchProducts();
    print(productcontroller.products.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    void productDialog() {
      TextEditingController productNameController = TextEditingController();
      TextEditingController productQTYController = TextEditingController();
      TextEditingController productImageController = TextEditingController();
      TextEditingController productUnitPriceController =
          TextEditingController();
      TextEditingController productTotalPriceController =
          TextEditingController();

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Add product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: productNameController,
                    decoration: InputDecoration(labelText: 'Product name'),
                  ),
                  TextField(
                    controller: productImageController,
                    decoration: InputDecoration(labelText: 'Product image'),
                  ),
                  TextField(
                    controller: productQTYController,
                    decoration: InputDecoration(labelText: 'Product qty'),
                  ),
                  TextField(
                    controller: productUnitPriceController,
                    decoration: InputDecoration(
                      labelText: 'Product unit price',
                    ),
                  ),
                  TextField(
                    controller: productTotalPriceController,
                    decoration: InputDecoration(labelText: ' total price'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Add Product'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product CRUD'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemCount: productcontroller.products.length,
        itemBuilder: (context, index) {
          var product = productcontroller.products[index];
          return ProductCard(
            onEdit: () {
              productDialog();
            },
            onDelete: () {
              productcontroller.DeleteProducts(product.sId.toString())
                  .then((value) async {
                if (value) {
                  await productcontroller.fetchProducts();
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Product Deleted'),
                    duration: Duration(seconds: 2),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Something wrong...!'),
                    duration: Duration(seconds: 2),
                  ));
                }
              });
            },
            product: product,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
