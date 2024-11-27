import 'package:certify/presentation/views/shared_widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared_widgets/header_pad.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, String>> items = [
    {"name": "Maltina", "date": "Oct 18th, 11:24:09", "status": "Verified"},
    {
      "name": "Vaseline Body Lotion",
      "date": "Oct 18th, 11:00:00",
      "status": "Verified"
    },
    {
      "name": "MTN Recharge Cards",
      "date": "Oct 18th, 10:34:01",
      "status": "Verified"
    },
    {
      "name": "Honeywell Flour",
      "date": "Oct 18th, 09:24:09",
      "status": "Verified"
    },
    {
      "name": "Amstel Malta",
      "date": "Oct 16th, 08:24:09",
      "status": "Verified"
    },
    {
      "name": "Indomie Noodles",
      "date": "Oct 16th, 11:04:09",
      "status": "Verified"
    },
    {"name": "Guinness", "date": "Oct 15th, 08:08:00", "status": "Verified"},
    {
      "name": "Golden Penny Pasta",
      "date": "Oct 15th, 07:24:00",
      "status": "Verified"
    },
    {
      "name": "Emzor Paracetamol",
      "date": "Oct 15th, 07:14:09",
      "status": "Verified"
    },
    {
      "name": "Game shakers",
      "date": "Oct 15th, 07:14:09",
      "status": "Counterfeit"
    },
    {
      "name": "Emzor Paracetamol",
      "date": "Oct 15th, 07:14:09",
      "status": "Counterfeit"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar with filter icon
              const CertifyAppBar(
                text: 'History',
                bottomPadding: 10,
              ),
              CustomTextField(
                labelText: 'Search',
                prefixIcon: 'search',
                suffixIcon: 'filter',
                controller: searchController,
              ),
              // Sort by text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Sort by: Recent',
                  style: TextStyle(
                    color: const Color.fromRGBO(51, 51, 51, .5),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // List of history items
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return HistoryItem(
                      name: item["name"]!,
                      date: item["date"]!,
                      status: item["status"]!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String name;
  final String date;
  final String status;

  const HistoryItem({
    super.key,
    required this.name,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Circular icon with border
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(130, 70, 243, 0.1),
                  border: Border.all(
                    width: 2.sp,
                    color: status.toLowerCase() == 'verified'
                        ? Theme.of(context).colorScheme.primary
                        : Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Name and date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Int",
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(51, 51, 51, 0.5),
                      fontFamily: "Int",
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Status text
          Text(
            status,
            style: TextStyle(
              color: status.toLowerCase() == 'verified'
                  ? Theme.of(context).colorScheme.primary
                  : Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: 11.sp,
              fontFamily: "Int",
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
