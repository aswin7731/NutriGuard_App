import 'package:flutter/material.dart';
import 'package:nutriguardapp/saved_product_page.dart';

class AnalysisResultScreen extends StatefulWidget {
  const AnalysisResultScreen({super.key});

  @override
  State<AnalysisResultScreen> createState() => _AnalysisResultScreenState();
}

class _AnalysisResultScreenState extends State<AnalysisResultScreen> {
  // This variable tracks which tab is currently selected (0 = Nutritional, 1 = Ingredients, 2 = Health Impact)
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF1E3A8A); 
    const lightBackground = Color(0xFFF9FAFB);
    const healthGreen = Color(0xFF249B62);
    const warningRed = Color(0xFFEF4444);
    const warningOrange = Color(0xFFF59E0B);

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Analysis Result',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header (Image, Title, Score, and "Scanned for: Me")
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100, 
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1599599811452-95f00e572094?q=80&w=600&auto=format&fit=crop'), 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Lay's Classic Chips",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Scanned for: Me',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(color: healthGreen, shape: BoxShape.circle),
                              child: const Icon(Icons.energy_savings_leaf, color: Colors.white, size: 16),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '3.3/10',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: healthGreen),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.warning_amber_rounded, color: Colors.orange.shade300, size: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Interactive Tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(child: _buildTabButton('Nutritional', 0, primaryBlue)),
                    Expanded(child: _buildTabButton('Ingredients', 1, primaryBlue)),
                    Expanded(child: _buildTabButton('Health Impact', 2, primaryBlue)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3. Dynamic Content Area (Changes based on selected tab)
              if (_selectedTabIndex == 0)
                // NUTRITIONAL TAB CONTENT
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildNutrientRow('Calories', '530 Kcal', null, null),
                      _buildNutrientRow('Total Fat', '35 g', 'High', warningRed),
                      _buildNutrientRow('Saturated Fat', '7 g', 'High', warningRed),
                      _buildNutrientRow('Trans fat', '0.9 g', 'Good', healthGreen),
                      _buildNutrientRow('Cholesterol', '0 mg', 'Good', healthGreen),
                      _buildNutrientRow('Sodium', '620 mg', 'High', warningRed),
                      _buildNutrientRow('Total Carbohydrate', '140 g', 'Good', warningOrange),
                      _buildNutrientRow('Sugar', '0.5 g', 'Good', healthGreen),
                      _buildNutrientRow('Protein', '5 g', null, null, isLast: true),
                    ],
                  ),
                )
              else if (_selectedTabIndex == 1)
                // INGREDIENTS TAB CONTENT
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ingredients List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 12),
                      Text(
                        'Potatoes, Vegetable Oil (Sunflower, Corn, and/or Canola Oil), and Salt.',
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade800, height: 1.5),
                      ),
                      const SizedBox(height: 16),
                      const Text('Allergens', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: warningRed)),
                      const SizedBox(height: 8),
                      Text('None detected in standard formulation.', style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                    ],
                  ),
                )
              else if (_selectedTabIndex == 2)
                // HEALTH IMPACT TAB CONTENT
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: warningRed, size: 20),
                          const SizedBox(width: 8),
                          const Text('High Sodium', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Frequent consumption of high-sodium foods can lead to increased blood pressure and strain on the heart.',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.4),
                      ),
                      const Divider(height: 32),
                      Row(
                        children: [
                          Icon(Icons.fastfood, color: warningOrange, size: 20),
                          const SizedBox(width: 8),
                          const Text('Saturated Fats', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This product contains saturated fats from vegetable oils. Moderation is recommended to maintain healthy cholesterol levels.',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.4),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 24),

              // 4. AI Recommendation Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: healthGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.auto_awesome, color: healthGreen),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AI Recommendation',
                            style: TextStyle(fontWeight: FontWeight.bold, color: healthGreen, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Great choice of servings, but high in sodium and saturated fats. Best consumed in moderation.',
                            style: TextStyle(fontSize: 13, color: Colors.green.shade900, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 5. Bottom Action Buttons
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SavedProductsScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Save to History', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.grey, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Share', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the Toggle Tabs that now responds to taps
  Widget _buildTabButton(String text, int tabIndex, Color activeColor) {
    bool isSelected = _selectedTabIndex == tabIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = tabIndex;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for the Nutritional List Rows
  Widget _buildNutrientRow(String label, String value, String? badgeText, Color? badgeColor, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
              const Spacer(),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
              if (badgeText != null && badgeColor != null) ...[
                const SizedBox(width: 12),
                Container(
                  width: 50, 
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badgeText,
                    style: TextStyle(color: badgeColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ] else ...[
                const SizedBox(width: 62), 
              ]
            ],
          ),
        ),
        if (!isLast) Divider(color: Colors.grey.shade200, height: 1, thickness: 1),
      ],
    );
  }
}