import 'package:flutter/material.dart';
import '../../models/city_model.dart';

class OutfitForm extends StatefulWidget {
  const OutfitForm({super.key});

  @override
  State<OutfitForm> createState() => _OutfitFormState();
}

class _OutfitFormState extends State<OutfitForm> {
  static const defaultCity = City.PhnomPenh;

  final _descriptionController = TextEditingController();
  City _city = defaultCity;
  final _shopNameController = TextEditingController();
  final _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Add Outfit",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        titleSpacing: 12,
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Text("Description", style: TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _descriptionController,
              maxLength: 100,
              decoration: const InputDecoration(
                label: Text("Add description"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Text("City", style: TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Expanded(
              child: DropdownButtonFormField<City>(
                initialValue: _city,
                items: City.values.map((city) {
                  return DropdownMenuItem<City>(
                    value: city,
                    child: Row(
                      children: [
                        Text(city.displayName),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _city = value;
                    });
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Text("Shop Name", style: TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _descriptionController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text("Shop Name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Text("Price", style: TextStyle(fontSize: 16))
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: TextField(
            controller: _priceController,
            maxLength: 10,
            decoration: const InputDecoration(
                label: Text("Price"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
          ),)
        ],
      ),
    );
  }
}
