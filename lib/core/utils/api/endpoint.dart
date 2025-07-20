class EndPoint {
  static String baseUrl = "http://78.89.159.126:9393/TheOneAPILahj/api";

  // Login and Password
  static String login = "$baseUrl/Member/login";
  static String forgetpassw = "$baseUrl/Member/forgotpassword";
  static String changePassconfirm = "$baseUrl/Member/resetpassword";

  // Member
  static String getallmembers="$baseUrl/Member/getAllMembers";

  // Advertisement
  static String getAllAdvertisements = "$baseUrl/Advertisement/GetAll";
  static String getApprovedAdvertisements = "$baseUrl/Advertisement/GetApproved";
  static String getAdvertisementById = "$baseUrl/Advertisement/By-Id/{Id}";
  static String searchAdvertisementsByName = "$baseUrl/Advertisement/By-Name/{Name}";
  static String getAdvertisementsByGroupId = "$baseUrl/Advertisement/By-GroupId/{groupId}";
  static String getAdvertisementsByServiceId = "$baseUrl/Advertisement/By-ServiceId/{serviceId}";
  static String getAdvertisementsByGovernorateId = "$baseUrl/Advertisement/By-GovernorateId/{governorateId}";
  static String getAdvertisementsByMemberId = "$baseUrl/Advertisement/By-MemberId/{memberId}";
  static String getMyAdvertisements = "$baseUrl/Advertisement/myAdvertisements";
  static String addAdvertisement = "$baseUrl/Advertisement/AddAdvertisement";
  static String updateAdvertisement = "$baseUrl/Advertisement/updateAdvertisement";
  static String deleteAdvertisement = "$baseUrl/Advertisement/DeleteAdvertisement";
  static String deleteAdvertisementImage = "$baseUrl/Advertisement/{advertisementId}/DeleteImage/{imageId}";
  static String restoreAdvertisement = "$baseUrl/Advertisement/RestoreAdvertisement/{Id}";
  static String approvalAdvertisement = "$baseUrl/Advertisement/Approval/{Id}";
  static String addAdvertisementFavorite = "$baseUrl/Advertisement/AddAdvertisementFavorite";
  static String deleteAdvertisementFavorite = "$baseUrl/Advertisement/DeleteAdvertisementFavorite";
  static String likeAdvertisement = "$baseUrl/Advertisement/Like/{Id}";
  static String unlikeAdvertisement = "$baseUrl/Advertisement/UnLike/{Id}";
  static String addComment = "$baseUrl/Advertisement/addComment";
  static String reportComment = "$baseUrl/Advertisement/ReportComment";
  static String getAllCommentReports = "$baseUrl/Advertisement/getAllCommentReports";
  static String approvalCommentReport = "$baseUrl/Advertisement/ApprovalCommentReport/{Id}";
  static String deleteCommentReport = "$baseUrl/Advertisement/DeleteCommentReport/{Id}";
  // Currency
  static String getcurrency =    "$baseUrl/Currency/getAllCurrencies";
  static String addcurrrency =   "$baseUrl/Currency/addCurrency";
  static String updatecurrency = "$baseUrl/Currency/updateCurrency";
  static String deleteCurrency(int id) {
    return "$baseUrl/Currency/deleteCurrency?id=$id";
  }
  // Governorate
  static String getAllGovernorates = "$baseUrl/Governorate/getAllGovernorates";
  static String addGovernorate = "$baseUrl/Governorate/addGovernorate";
  static String addGovernorateFromBody = "$baseUrl/Governorate/addGovernorateFromBody";
  static String updateGovernorate = "$baseUrl/Governorate/updateGovernorate";
  static String deleteGovernorate(int id) {
    return "$baseUrl/Governorate/deleteGovernorate?id=$id";
  }

  ///Service
  static String getallServices = "$baseUrl/Service/getAllServices";
  static String Addservices = "$baseUrl/Service/addService";
  static String updateservices = "$baseUrl/Service/updateService";
  static String deleteService(int id) {
  return   "$baseUrl/Service/deleteService?id=$id";

  }

  ///Group
  static String getallGroups = "$baseUrl/Group/getAllGroups";
  static String addGroups = "$baseUrl/Group/addGroup";
  static String updateGroups = "$baseUrl/Group/updateGroup";
  static String deleteGroup(int id) {

    return "$baseUrl/Group/deleteGroup?id=$id";

  }
  }