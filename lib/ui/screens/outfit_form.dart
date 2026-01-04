import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/city_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/outfit.dart';

class OutfitForm extends StatefulWidget {
  const OutfitForm({super.key});

  @override
  State<OutfitForm> createState() => _OutfitFormState();
}

class _OutfitFormState extends State<OutfitForm> {
  static const defaultCity = City.PhnomPenh;
  static const defaultWeather = Weather.Sunny;
  static const defaultStyle = Styles.Casual;
  final _descriptionController = TextEditingController();
  City _city = defaultCity;
  final _shopNameController = TextEditingController();
  final _priceController = TextEditingController();
  File? _selectedImage;
  Weather _suitableWeather = defaultWeather;
  Styles _style = defaultStyle;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _back() {
    Navigator.of(context).maybePop();
    return;
  }

  void _addOutfit() {
    final description = _descriptionController.text.trim();
    final shopName = _shopNameController.text.trim();
    final priceText = _priceController.text.trim();
    final suitableWeather = _suitableWeather;
    final style = _style;

    if (description.isEmpty || shopName.isEmpty || priceText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }
    final price = double.tryParse(priceText);
    if (price == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Price must be a number")));
    } else if (price < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Price must be positive number")),
      );
      return;
    }

    final newOutfit = Outfit(
      description: description,
      city: _city,
      shopName: shopName,
      price: price!,
      suitableWeather: suitableWeather,
      style: style,
      imagePath: _selectedImage?.path ?? '',
    );
    print("New outfit added: $newOutfit");

    Navigator.of(context).pop(newOutfit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4E6),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF4E6),
        leading: IconButton(
          onPressed: _back,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Add Outfit",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        titleSpacing: 12,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            // Text("Description", style: TextStyle(fontSize: 16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonFormField<City>(
                dropdownColor: Color(0xFFFFF4E6),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                initialValue: _city,
                items: City.values.map((city) {
                  return DropdownMenuItem<City>(
                    value: city,
                    child: Row(children: [Text(city.displayName)]),
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
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              child: Text("Shop Name", style: TextStyle(fontSize: 16)),
            ),
            // Text("Description", style: TextStyle(fontSize: 16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _shopNameController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Add shop name"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Text("Price", style: TextStyle(fontSize: 16)),
            ),
            // Text("Description", style: TextStyle(fontSize: 16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _priceController,
                maxLength: 10,
                decoration: const InputDecoration(
                  label: Text("Add price"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Text("Style/Weather", style: TextStyle(fontSize: 16)),
            ),
            // Text("Description", style: TextStyle(fontSize: 16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<Weather>(
                      dropdownColor: Color(0xFFFFF4E6),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      initialValue: _suitableWeather,
                      items: Weather.values.map((weather) {
                        return DropdownMenuItem<Weather>(
                          value: weather,
                          child: Row(children: [Text(weather.name)]),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _suitableWeather = value;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<Styles>(
                      dropdownColor: Color(0xFFFFF4E6),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      initialValue: _style,
                      items: Styles.values.map((style) {
                        return DropdownMenuItem<Styles>(
                          value: style,
                          child: Row(children: [Text(style.name)]),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _style = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Text("Image", style: TextStyle(fontSize: 16)),
            ),
            // Text("Description", style: TextStyle(fontSize: 16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black),
                  ),
                  child: _selectedImage == null
                      ? Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Transform.rotate(
                                angle: -1,
                                child: Icon(Icons.attachment),
                              ),
                            ),
                            Text(
                              "Attach Photo",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(_selectedImage!, fit: BoxFit.cover),
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addOutfit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF456882),
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20,
                      ),
                    ),
                    child: const Text(
                      "Add Outfit",
                      style: TextStyle(color: Color(0xFFFFF4E6)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
