import 'package:flutter/material.dart';
import 'package:grocery_shopping/providers/category_provider.dart';
import 'file:///F:/work/fluter/grocery_shopping/lib/models/product.dart';
import 'package:grocery_shopping/providers/product_provider.dart';
import 'package:provider/provider.dart';

class MangeProductScreen extends StatefulWidget {
  static const routeId = '/mange-product';

  @override
  _MangeProductScreenState createState() => _MangeProductScreenState();
}

class _MangeProductScreenState extends State<MangeProductScreen> {
  final _form = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _imgFocusNode = FocusNode();
  final _categoryFocusNode = FocusNode();
  final _discountFocusNode = FocusNode();
  final _imgController = TextEditingController();
  final _imgUrlFocusNode = FocusNode();
  var _editedProduct = ProductModel(
    id: null,
    categoryId: 'Household',
    title: '',
    img: '',
    price: 0,
    discount: 0,
  );
  var _initValue = {
    'title': '',
    'price': '',
    'category': '',
    'discount': '',
    'img': '',
  };
  var _isInit = true;


  @override
  void initState() {
    _imgFocusNode.addListener(_upDateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<ProductController>(context).findById(productId);
        _initValue = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'category': _editedProduct.categoryId,
          'discount': _editedProduct.discount.toString(),
          'img': '',
        };
        _imgController.text = _editedProduct.img;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _upDateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if ((!_imgController.text.startsWith("http") &&
          !_imgController.text.startsWith("https")) ||
          (!_imgController.text.endsWith("png") &&
              !_imgController.text.endsWith("jpg") &&
              !_imgController.text.endsWith("jpeg"))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imgController.dispose();
    _imgUrlFocusNode.addListener(_upDateImageUrl);
    _priceFocusNode.dispose();
    _categoryFocusNode.dispose();
    _discountFocusNode.dispose();
    super.dispose();
  }
  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedProduct.id != null) {
      Provider.of<ProductController>(context, listen: false)
          .updateProducts(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<ProductController>(context, listen: false)
          .addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    final categoryPro = Provider.of<CategoryController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveForm();
//                Navigator.of(context).pop();
              }),
        ],
      ),
       body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValue['title'],
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a Title";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = ProductModel(
                    id: _editedProduct.id,
                    categoryId: _editedProduct.categoryId,
                    title: val,
                    discount: _editedProduct.discount,
                    img: _editedProduct.img,
                    price: _editedProduct.price,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['price'],
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_discountFocusNode);
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a Price";
                  }
                  if (double.tryParse(val) == null) {
                    return "Please Enter a Valid Number!";
                  }
                  if (double.tryParse(val) <= 0) {
                    return "Please Enter a Number Greater Than 0";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = ProductModel(
                    id: _editedProduct.id,
                    categoryId: _editedProduct.categoryId,
                    title: _editedProduct.title,
                    discount: _editedProduct.discount,
                    img: _editedProduct.img,
                    price: double.parse(val),
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['discount'],
                decoration: InputDecoration(labelText: "Discount"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _discountFocusNode,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a Discount";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = ProductModel(
                    id: _editedProduct.id,
                    categoryId: _editedProduct.categoryId,
                    title: _editedProduct.title,
                    discount: double.parse(val),
                    img: _editedProduct.img,
                    price: _editedProduct.price,
                  );
                },
              ),
              DropdownButton<String>(
                value: initialVal,
                items: categoryPro.categories.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.title,
                    child: Text(e.title),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    initialVal = newValue;
                    _editedProduct = ProductModel(
                      id: _editedProduct.id,
                      categoryId: initialVal,
                      title: _editedProduct.title,
                      discount: _editedProduct.discount,
                      img: _editedProduct.img,
                      price: _editedProduct.price,
                    );
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Img Url"),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.url,
                controller: _imgController,
                focusNode: _imgFocusNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return "Please Enter a ImgUrl";
                  }
                  if (!val.startsWith("http") && !val.startsWith("https")) {
                    return "Please Enter Valid Url";
                  }
                  if (!val.endsWith("png") &&
                      !val.endsWith("jpg") &&
                      !val.endsWith("jpeg")) {
                    return "Enter a Valid img";
                  }
                  return null;
                },
                onSaved: (val) {
                  _editedProduct = ProductModel(
                    id: _editedProduct.id,
                    categoryId: _editedProduct.categoryId,
                    title: _editedProduct.title,
                    discount: _editedProduct.discount,
                    img: val,
                    price: _editedProduct.price,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String initialVal = "Household";
}
