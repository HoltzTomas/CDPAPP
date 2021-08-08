import 'package:cdp_app/Company/repository/company_cloud_api.dart';
import 'package:flutter/material.dart';

class CompanyCloudRepo {
  final CompanyCloudApi companyCloudApi = CompanyCloudApi();

  Future<void> sendAnonymousComment(
          {required String comment, required BuildContext context}) async =>
      companyCloudApi.sendAnonymousComment(comment: comment, context: context);
}
