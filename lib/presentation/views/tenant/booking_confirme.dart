import 'package:booking/helper/constant/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class BookingConfirme extends StatefulWidget {
  const BookingConfirme({super.key});

  @override
  State<BookingConfirme> createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirme> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _confirmPayment() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      // final data = _formKey.currentState!.value;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Payment Confirmed ✅')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm and book'),
        centerTitle: true,
        leading: IconButton(
          onPressed: (() => {Navigator.pop(context)}),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [Color(0xFF137FEC), Color(0xFF4DA3FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wallet Balance',
                    style: TextStyle(
                      color: context.appTheme.thirdly,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$4,200.00',
                    style: TextStyle(
                      color: context.appTheme.thirdly,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 40),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDhCGqi5UzD3_eJjUcLFLmKkvn0pAoHL9a5zWj0AqdRNkxylzmhAGFpC87ueFT7INvF503zJ9fbc8mMXcC70qPO_meAuRPgqYVVVDfIdbFiPWFC82IeVcYbNWtlnecMQA5NYKE3Lz8vfGbzqmhnv_kilmm3MM6JVnQCOpBs2QYJ6up6nJof4MXaJJTGhnVWKFzPnWlAHFA3IdMJzrPvd2Dic3spTR574snC-p92UYn_OyePWkwQSwBZCUjkYvmnBOvowoHL1DJQMQ',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  'Modern Loft in Downtown',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('San Francisco, CA'),
              ),
            ),
            SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your trip',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: const Text(
                    'Dates',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Oct 5 - Oct 30, 2024'),
                  trailing: Text(
                    'Edit',
                    style: TextStyle(color: context.appTheme.fourthly),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Guests',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('2 guests'),
                  trailing: Text(
                    'Edit',
                    style: TextStyle(color: context.appTheme.fourthly),
                  ),
                ),
              ],
            ),
            Divider(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('\$140 x 25 nights'), Text("\$3,500")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Cleaning fee'), Text("\$60")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Service fee'), Text("\$150")],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Taxes'), Text("\$245.20")],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total (USD)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$3,955.20",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 32),
            FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pay with',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  FormBuilderTextField(
                    name: 'card_number',
                    decoration: const InputDecoration(labelText: 'Card number'),
                    validator: FormBuilderValidators.required(),
                    keyboardType: TextInputType.number,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'expiry',
                          decoration: const InputDecoration(
                            labelText: 'MM / YY',
                          ),
                          validator: FormBuilderValidators.required(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'cvv',
                          decoration: const InputDecoration(labelText: 'CVV'),
                          validator: FormBuilderValidators.required(),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  FormBuilderTextField(
                    name: 'holder',
                    decoration: const InputDecoration(
                      labelText: 'Cardholder name',
                    ),
                    validator: FormBuilderValidators.required(),
                  ),

                  FormBuilderCheckbox(
                    name: 'save_card',
                    title: const Text('Save card for future use'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _confirmPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF137FEC),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Confirm and Pay',
            style: TextStyle(fontSize: 18, color: context.appTheme.thirdly),
          ),
        ),
      ),
    );
  }
}
