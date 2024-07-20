import 'package:ecommerce_app_admin_panel/core/utils/constants/constants.dart';
import 'package:ecommerce_app_admin_panel/core/utils/functions/show_add_product_form.dart';
import 'package:ecommerce_app_admin_panel/core/utils/lists/order_info_list.dart';
import 'package:ecommerce_app_admin_panel/core/widgets/custom_app_bar.dart';
import 'package:ecommerce_app_admin_panel/features/dashboard/presentation/views/widgets/order_info_card.dart';
import 'package:ecommerce_app_admin_panel/features/dashboard/presentation/views/widgets/product_list_section.dart';
import 'package:ecommerce_app_admin_panel/features/dashboard/presentation/views/widgets/product_summary_section.dart';
import 'package:flutter/material.dart';

class DashboardContaint extends StatelessWidget {
  const DashboardContaint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              CustomAppBar(
                onPressed: () {
                  showAddProductForm(context);
                },
                title: 'My Products',
              ),
              const SizedBox(height: defaultPadding),
              // product summary section
              const ProductSummarySection(),
              const SizedBox(height: defaultPadding),
              // product list section
              const ProductListSection(),
            ],
          ),
        ),
        const SizedBox(width: defaultPadding),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Orders Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Container(
                  height: 150,
                  color: Colors.blueGrey,
                ),
                Column(
                  children: List.generate(
                    orderList.length,
                    (index) {
                      return OrderInfoCard(
                        orderInfoModel: orderList[index],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}