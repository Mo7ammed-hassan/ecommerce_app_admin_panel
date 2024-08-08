import 'package:ecommerce_app_admin_panel/core/utils/constants/constants.dart';
import 'package:ecommerce_app_admin_panel/core/utils/functions/show_add_category_form.dart';
import 'package:ecommerce_app_admin_panel/core/utils/services/api_services.dart';
import 'package:ecommerce_app_admin_panel/core/widgets/custom_app_bar.dart';
import 'package:ecommerce_app_admin_panel/core/widgets/main_view_header.dart';
import 'package:ecommerce_app_admin_panel/features/category/data/data_sources/category_remote_data_source.dart';
import 'package:ecommerce_app_admin_panel/features/category/data/repos/category_repo_impl.dart';
import 'package:ecommerce_app_admin_panel/features/category/domain/use_cases/category_use_case.dart';
import 'package:ecommerce_app_admin_panel/features/category/presentatation/manager/cubit/category_cubit.dart';
import 'package:ecommerce_app_admin_panel/features/category/presentatation/views/widgets/category_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(
        CategoryUseCaseImp(
          CategoryRepoImpl(
            CategoryRemoteDataSourceImpl(
              getIt.get<ApiService>(),
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              MainViewsHeader(
                title: 'Category',
                onChange: (vlaue) {},
              ),
              const SizedBox(height: defaultPadding),
              CustomAppBar(
                onPressed: () {
                  showAddCategoryForm(context);
                },
                title: 'My Category',
                onPressedRefresh: () {},
              ),
              const SizedBox(height: 20),
              const CategoryListSection(),
            ],
          ),
        ),
      ),
    );
  }
}
