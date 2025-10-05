import 'package:flutter/material.dart';
import 'package:america/services/AppLocalizations.dart';
import 'package:america/widgets/text_field.dart';
class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField({super.key});

  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  Country selectedCountry = countries[0];


  void showCountrySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Country'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int index) {
                final country = countries[index];
                return ListTile(
                  leading: Image.asset(country.flag),
                  title: Text(country.name),
                  onTap: () {
                    setState(() {
                      selectedCountry = country;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.0),

      child: GestureDetector(
        onTap: () {
          showCountrySelectionDialog(context);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                selectedCountry.flag,
                height: 50.0,
                width: 50.0,
              ),
            ),

          ],
        ),
      ),
    );
  }
}


class Country {
  final String name;
  final String flag;

  Country({required this.name, required this.flag});
}

List<Country> countries = [
  Country(name: 'United Arab Emirates', flag: 'assets/images/uae.jpg'),
  Country(name: 'Saudi Arabia', flag: 'assets/images/Saudi-Arabia.jpg'),
  Country(name: 'Kuwait', flag: 'assets/images/Kuwait.jpg'),
  Country(name: 'Bahrain', flag: 'assets/images/Bahrain.jpg'),
  Country(name: 'Oman', flag: 'assets/images/Oman.jpg'),
  Country(name: 'Qatar', flag: 'assets/images/Qatar.jpg'),
];