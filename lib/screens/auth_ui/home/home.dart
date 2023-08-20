import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nirvana_store_app/constants/routes.dart';
import 'package:nirvana_store_app/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:nirvana_store_app/models/category_model/category_model.dart';
import 'package:nirvana_store_app/product_details/product_details.dart';
import 'package:nirvana_store_app/screens/category_view/category_view.dart';
import 'package:nirvana_store_app/widgets/top_titles/top_titles.dart';

import '../../../models/product_model/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopTitle(title: "Nirvana Store", subtitle: ""),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "Search...",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "Top Categories",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Categories is Empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: CupertinoButton(
                                      padding:EdgeInsets.zero,
                                    onPressed:(){
                                        Routes.instance.push(widget: CategoryView(categoryModel: e), context: context);
                                    },
                                      child:
                                    Card(
                                      elevation: 6.0,
                                      color: Colors.lightBlueAccent[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      ),
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(e.image),
                                      ),
                                    ),
                                    ), ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12, top: 12),
                    child: Text(
                      "Best Selling Products",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Best product is Empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(
                            12,
                          ),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: productModelList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 0.9),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        singleProduct.image,
                                        fit: BoxFit.cover,
                                        height: 50,
                                        width: 50,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        singleProduct.name,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text("Price: \Rs.${singleProduct.price}"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: 140,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Routes.instance.push(
                                                widget: ProductDetails(
                                                    singleProduct:
                                                        singleProduct),
                                                context: context);
                                          },
                                          child: const Text("Buy Now"),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                  const SizedBox(height: 12.0,),
                ],
              ),
            ),
    );
  }
}
//HomePage Completed.