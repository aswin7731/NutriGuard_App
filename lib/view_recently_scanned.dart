import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  final String pageTitle; // This allows us to reuse the screen for different lists

  const ProductListScreen({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    const primarySkyBlue = Color(0xFF0284C7);
    const appBackgroundSky = Color(0xFFF0F9FF);

    // Mock data for the list
    final List<Map<String, dynamic>> products = [
      {"name": "Oreo Original", "score": "45/100", "color": Colors.orange, "date": "Today"},
      {"name": "Whole Wheat Bread", "score": "82/100", "color": const Color(0xFF249B62), "date": "Yesterday"},
      {"name": "Diet Coke", "score": "30/100", "color": Colors.redAccent, "date": "Sept 18"},
    ];

    return Scaffold(
      backgroundColor: appBackgroundSky,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primarySkyBlue, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          pageTitle, // Dynamically changes based on what the user clicked!
          style: const TextStyle(color: primarySkyBlue, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: products.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: primarySkyBlue.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                ],
              ),
              child: Row(
                children: [
                  // Placeholder for Product Image
                  Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2FE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.fastfood_outlined, color: primarySkyBlue),
                  ),
                  const SizedBox(width: 16),
                  
                  // Product Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        Text("Scanned: ${product["date"]}", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                      ],
                    ),
                  ),
                  
                  // Health Score
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: product["color"].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product["score"],
                      style: TextStyle(color: product["color"], fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}