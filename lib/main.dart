import 'dart:convert';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fake_api_app/Models/User.dart';
import 'package:fake_api_app/Models/Category.dart';
import 'package:fake_api_app/Models/Product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    main();
  }

  Future<dartz.Either<String, Product>> fetchProduct(int id) async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        return dartz.Right(Product.fromJson(jsonResponse));
      } else {
        return dartz.Left('Failed to load product');
      }
    } catch (e) {
      return dartz.Left('An error occurred: $e');
    }
  }

  Future<dartz.Either<String, List<Product>>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final products = jsonData.map((json) => Product.fromJson(json)).toList();
      return dartz.Right(products);
    } else {
      return dartz.Left('Failed to load products');
    }
  }

  Future<dartz.Either<String, List<Category>>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final categories =
          jsonData.map((json) => Category.fromJson({'name': json})).toList();
      return dartz.Right(categories);
    } else {
      return dartz.Left('Failed to load categories');
    }
  }

  Future<dartz.Either<String, List<User>>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/users'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final users = jsonData.map((json) => User.fromJson(json)).toList();
      return dartz.Right(users);
    } else {
      return dartz.Left('Failed to load users');
    }
  }

  void main() async {
    final productsResult = await fetchProducts();
    final categoriesResult = await fetchCategories();
    final usersResult = await fetchUsers();

    productsResult.fold(
      (error) => print('Error fetching products: $error'),
      (products) {
        print('Products:');
        for (var product in products) {
          print('Product ID: ${product.id}');
          print('Product Title: ${product.title}');
          print('Product Price: ${product.price}');
          print('Product Description: ${product.description}');
          print('Product Category: ${product.category}');
          print('Product Image: ${product.image}');
          print('Product Rating: ${product.rating.rate}');
          print('Product Rating Count: ${product.rating.count}');
        }
      },
    );

    categoriesResult.fold(
      (error) => print('Error fetching categories: $error'),
      (categories) {
        print('Categories:');
        for (var category in categories) {
          print('Name: ${category.name}');
        }
      },
    );

    usersResult.fold(
      (error) => print('Error fetching users: $error'),
      (users) {
        print('Users:');
        for (var user in users) {
          print('Username: ${user.username}, Email: ${user.email}');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            //Text(_message)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
