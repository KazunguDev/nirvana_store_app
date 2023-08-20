import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nirvana_store_app/constants/constants.dart';
import 'package:nirvana_store_app/constants/routes.dart';
import 'package:nirvana_store_app/models/product_model/product_model.dart';
import 'package:nirvana_store_app/provider/app_provider.dart';
import 'package:nirvana_store_app/screens/cart_screen/cart_screen.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({Key? key, required this.singleProduct})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}
class _ProductDetailsState extends State<ProductDetails> {
  int qty=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance.push(widget: CartScreen(), context: context);
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child:

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.singleProduct.image,
              height: 300,
              width: 300,
            ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.singleProduct.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleProduct.isFavourite =
                              !widget.singleProduct.isFavourite;
                        });
                      },
                      icon: Icon(widget.singleProduct.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
                  ],
                ),
            Text(widget.singleProduct.description,style: const TextStyle(
              fontSize: 18,
            ),),
             const SizedBox(height: 15,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Price: Rs.",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(width: 5,),
                Text(widget.singleProduct.price.toString(),style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
            const SizedBox(height: 15,),
             Row(
              children: [
                CupertinoButton( onPressed: (){
                if (qty >=1){
                  setState(() {
                    qty--;
                  });
                }
                },
                  padding: EdgeInsets.zero,
                child:  const CircleAvatar(
                  child: Icon(Icons.remove),
                ),),
                const SizedBox(width: 15,),
                Text(qty.toString(),style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(width: 15,),
                CupertinoButton( onPressed: (){
                  setState(() {
                    qty++;
                  });
                },
                  child:   CircleAvatar(
                    child: Icon(Icons.add),
                  ),
                  padding: EdgeInsets.zero,),
              ],
            ),
             const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
            OutlinedButton(onPressed: (){
              AppProvider appProvider = Provider.of<AppProvider>
                (context,listen: false);
              ProductModel productModel =widget.singleProduct.copyWith(qty: qty);
              appProvider.addCartProduct(productModel);
              showMessage("Item added to Cart");
            }, child: const Text("Add to Cart"),),
            ElevatedButton(onPressed: (){}, child: const Text("Buy Now"),),

          ],
        ),
            const SizedBox(height:10,),

          ],

        ),
      ),

       );
  }
}