import 'package:flutter/material.dart';
import 'package:nutriguardapp/resultofscannig_page.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primarySkyBlue = Color(0xFF0284C7); 
    const healthGreen = Color(0xFF249B62);

    return Scaffold(
      backgroundColor: Colors.black, // Dark background for camera mode
      body: Stack(
        children: [
          // 1. Simulated Camera Feed Background
          Positioned.fill(
            child: Container(
              color: Colors.black87,
              child: const Center(
                child: Icon(Icons.camera_alt, color: Colors.white24, size: 100),
              ),
            ),
          ),

          // 2. The Viewfinder Frame (Center - ONLY Corners now)
          Center(
            child: SizedBox(
              width: 280, // Made the overall scanning area slightly wider
              height: 320,
              child: Stack(
                children: [
                  // Positioned the 4 larger corners correctly
                  Positioned(top: 0, left: 0, child: _buildCorner(healthGreen, 0)),    // Top-Left
                  Positioned(top: 0, right: 0, child: _buildCorner(healthGreen, 1)),   // Top-Right
                  Positioned(bottom: 0, right: 0, child: _buildCorner(healthGreen, 2)),// Bottom-Right
                  Positioned(bottom: 0, left: 0, child: _buildCorner(healthGreen, 3)), // Bottom-Left
                ],
              ),
            ),
          ),

          // 3. Top Navigation Bar (Overlaid)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context); // Goes back to Home Dashboard
                      },
                    ),
                  ),
                  const Text(
                    'Scan Food',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // Flash Toggle Button
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.flash_off, color: Colors.white),
                      onPressed: () {
                        // TODO: Toggle Flashlight
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Bottom Controls Section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 24, bottom: 40, left: 24, right: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Align the packaged food in the frame',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Upload from Gallery Button
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.image, color: primarySkyBlue, size: 30),
                            onPressed: () {},
                          ),
                          const Text('Gallery', style: TextStyle(fontSize: 12, color: primarySkyBlue)),
                        ],
                      ),
                      
                      // Main Capture Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AnalysisResultScreen()));
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: primarySkyBlue, width: 4),
                          ),
                          child: Center(
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                color: primarySkyBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
                            ),
                          ),
                        ),
                      ),
                      
                      // Search Manually Button
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search, color: Colors.grey, size: 30),
                            onPressed: () {},
                          ),
                          const Text('Search', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to draw the corners of the scanner frame
  Widget _buildCorner(Color color, int rotationQuadrant) {
    return RotatedBox(
      quarterTurns: rotationQuadrant,
      child: Container(
        // INCREASED SIZE: Made the L-shapes much larger (from 30 to 60)
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border(
            // INCREASED THICKNESS: Made the lines thicker (from 4 to 6)
            top: BorderSide(color: color, width: 6),
            left: BorderSide(color: color, width: 6),
          ),
        ),
      ),
    );
  }
}