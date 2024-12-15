import 'package:flutter/material.dart';

class BusinessManager {
  // Lista de empresas
  List<Map<String, dynamic>> businesses = [];
  double totalEarnings = 0.0;

  // Agregar una empresa
  void addBusiness(String title, String category) {
    businesses.add({"title": title, "category": category, "earnings": 0.0});
  }

  // Incrementar ingresos para una empresa específica
  void increaseEarnings(String title, double amount) {
    for (var business in businesses) {
      if (business['title'] == title) {
        business['earnings'] += amount;
        break;
      }
    }
  }

  // Calcular el total de ingresos
  void computeTotalEarnings() {
    totalEarnings = 0.0; // Reiniciar total
    for (var business in businesses) {
      totalEarnings += business["earnings"];
    }
  }

  // Obtener lista de empresas
  List<Map<String, dynamic>> getBusinesses() {
    return businesses;
  }
}

void main() {
  runApp(const BusinessManagerApp());
}

class BusinessManagerApp extends StatelessWidget {
  const BusinessManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Dashboard',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final BusinessManager manager = BusinessManager();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final Map<String, TextEditingController> earningsControllers = {};

  void _addNewBusiness() {
    final title = titleController.text;
    final category = categoryController.text;

    if (title.isNotEmpty && category.isNotEmpty) {
      setState(() {
        manager.addBusiness(title, category);
        earningsControllers[title] = TextEditingController();
      });
      titleController.clear();
      categoryController.clear();
    }
  }

  void _addEarnings(String title) {
    final amount =
        double.tryParse(earningsControllers[title]?.text ?? '') ?? 0.0;

    if (amount > 0) {
      setState(() {
        manager.increaseEarnings(title, amount);
      });
      earningsControllers[title]?.clear();
    }
  }

  void _calculateTotal() {
    setState(() {
      manager.computeTotalEarnings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Dashboard'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Business Name',
                labelStyle: TextStyle(color: Colors.orange),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Business Category',
                labelStyle: TextStyle(color: Colors.orange),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _addNewBusiness,
              child: const Text(
                'Add Business',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Registered Businesses:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: manager.getBusinesses().length,
                itemBuilder: (context, index) {
                  final business = manager.getBusinesses()[index];
                  final title = business['title'];

                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${business['title']}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            "Category: ${business['category']}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Earnings: \$${business['earnings'].toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: earningsControllers[title],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Add Earnings',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                onPressed: () => _addEarnings(title),
                                child: const Text('Add'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            if (manager.totalEarnings > 0)
              Text(
                'Total Earnings: \$${manager.totalEarnings.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _calculateTotal,
              child: const Text(
                'Calculate Total',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
