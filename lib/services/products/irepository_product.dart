

import 'package:adminpanelecommerce/models/prdouct.dart';

abstract class IrepositoryProduct
{
    Future<List<Product>> getProducts();

}