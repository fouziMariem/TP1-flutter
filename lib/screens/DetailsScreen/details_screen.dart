import 'package:flutter/material.dart';
import '../../models/book.dart';

class DetailsPage extends StatefulWidget {
  final Book book;
  
  const DetailsPage({super.key, required this.book});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int quantity = 10; // Global variable for quantity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.book.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
            tooltip: 'Add to favorites',
          ),
        ],
      ),
      body: ListView(
        children: [
          // Image
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.book.image,
                  width: 250,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          
          // Description
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Lorem ipsum dolor sit amet consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Price
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.book.price.toString()} TND",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Quantity display
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Available: $quantity",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Buy button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  setState(() {
                    if (quantity > 0) {
                      quantity--;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${widget.book.name} purchased! Available: $quantity'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Out of stock!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  });
                },
                icon: const Icon(Icons.shopping_bag),
                label: const Text(
                  "Purchase",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
