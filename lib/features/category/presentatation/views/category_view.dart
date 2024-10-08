import 'package:ecommerce_app_admin_panel/core/utils/constants/constants.dart';
import 'package:ecommerce_app_admin_panel/core/widgets/secoundry_view_header.dart';
import 'package:ecommerce_app_admin_panel/core/widgets/view_header.dart';
import 'package:ecommerce_app_admin_panel/features/category/presentatation/manager/cubit/category_cubit.dart';
import 'package:ecommerce_app_admin_panel/features/category/presentatation/views/functions/show_add_category_alert_dialog.dart';
import 'package:ecommerce_app_admin_panel/features/category/presentatation/views/widgets/build_category_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        primary: false,
        child: Column(
          children: [
            ViewHeader(
              title: 'Category',
              onChanged: (p0) {},
            ),
            const SizedBox(height: defaultPadding * 1.5),
            SecoundyViewHeader(
              title: 'My Categories',
              addNewOnTap: () {
                showAddCategoyAlertDialog(context);
              },
              refreshOnTap: () async {
                final cubit = context.read<CategoryCubit>();
                await cubit.fetchCategories(); // Refresh the category list
              },
            ),
            const SizedBox(height: 20),
            const BuildCategoryListSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
