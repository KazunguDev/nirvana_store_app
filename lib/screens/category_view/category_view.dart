import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nirvana_store_app/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:nirvana_store_app/models/category_model/category_model.dart';
import 'package:nirvana_store_app/models/product_model/product_model.dart';


import '../../constants/routes.dart';
import '../../product_details/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryView({Key? key,required this.categoryModel}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList =[];
  bool isLoading=false;
  void getCatergoryList()async{
    setState(() {
       isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance.getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading=false;
    });
  }
  @override
  void initState() {
    getCatergoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: isLoading?Center(
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),

        ),
      ):
      SingleChildScrollView(child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kTextTabBarHeight*1,),
          Padding(padding: const EdgeInsets.all(12.0),
            child:
          Row(
            children: [
              const BackButton(),
              Text(
                widget.categoryModel.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ), ),
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
                          height: 60,
                          width: 60,
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
                          height: 5,
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
      ),  );
  }
}
