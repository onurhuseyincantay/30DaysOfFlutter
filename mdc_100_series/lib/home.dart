// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/products_repository.dart';
import 'model/product.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  // TODO: Make a collection of cards (102)
  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              semanticLabel: "menu",
            ),
            onPressed: _pressedMenuButton,
          ),
          title: Text("Shrine"),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  semanticLabel: "Search",
                ),
                onPressed: _searchPressed),
            IconButton(
                icon: Icon(
                  Icons.tune,
                  semanticLabel: "Filter",
                ),
                onPressed: _filterPressed),
          ],
        ),
        body: AsymmetricView(
          products: ProductsRepository.loadProducts(Category.all),
        ));
  }

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    List<Card> cards = products
        .map((product) => Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 18.0 / 11.0,
                    child: Image.asset(
                      product.assetName,
                      package: product.assetPackage,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          product == null ? '' : product.name,
                          style: theme.textTheme.button,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          product == null
                              ? ''
                              : formatter.format(product.price),
                          style: theme.textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              elevation: 0,
            ))
        .toList();
    return cards;
  }

  void _pressedMenuButton() {
    print("Menu Pressed");
  }

  void _searchPressed() {
    print("Search Pressed");
  }

  void _filterPressed() {
    print("Filter Pressed");
  }
}
