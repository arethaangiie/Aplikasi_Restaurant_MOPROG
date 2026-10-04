import 'package:flutter/material.dart';
import '../models/food_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 50,
              backgroundColor: kPrimary,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kelompok 10',
              style: TextStyle(
                color: kTextDark,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'kelompok10@email.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.receipt_long, color: kPrimary),
                    title: const Text('Riwayat Pesanan'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.location_on, color: kPrimary),
                    title: const Text('Alamat Tersimpan'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.help_outline, color: kPrimary),
                    title: const Text('Bantuan'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
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