import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nirvana_store_app/models/product_model/product_model.dart';

import '../../../constants/constants.dart';
import '../../../provider/app_provider.dart';

class SingleCartItem extends StatefulWidget {
 final ProductModel singleProduct;

  const SingleCartItem({Key? key,required this.singleProduct}) : super(key: key);

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int  qty=1;
  @override
  void initState() {
    qty =widget.singleProduct.qty??1;
    setState(() {
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blueAccent,width: 3),
      ),
      child: Row(
        children: [
          Expanded(child: Container(
            height: 140,
            color: Colors.blueAccent.withOpacity(0.4),
            child: Image.network(widget.singleProduct.image),
          ),),
          const Column(
            children: [
            ],
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child:Padding(padding: const EdgeInsets.all(12.0),
                child:
                    Stack(
                      alignment: Alignment.bottomRight,
                        children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                      widget.singleProduct.name,
                          style:  const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            CupertinoButton( onPressed: (){
                              if (qty >=1){
                                setState(() {
                                  qty--;
                                });
                              }
                            },
                              padding: EdgeInsets.zero,
                              child:  const CircleAvatar(
                                maxRadius: 13,
                                child: Icon(Icons.remove),
                              ),),
                            Text(qty.toString(),style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),),
                            CupertinoButton(
                              onPressed: (){
                                setState(() {
                                  qty++;
                                });
                              },
                              padding: EdgeInsets.zero,
                              child:  const CircleAvatar(
                                maxRadius: 13,
                                child: Icon(Icons.add),
                              ),),
                          ],
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child:const Text("Add to Wishlist",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: (){},
                        ),
              ]),
                      Text("Rs:${widget.singleProduct.price.toString()}",style:  const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold),),
    ]),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: (){
                              AppProvider appProvider = Provider.of<AppProvider>(context,listen: false);
                              appProvider.removeCartProduct(widget.singleProduct);
                              showMessage("Item removed from Cart");
                            },
                            child: const CircleAvatar(
                              maxRadius: 13,
                              child: Icon(Icons.delete,size: 18,),
                            ),
                          ),
             ] ),
            ),
            ),
          )],
      ),
    );
  }
}