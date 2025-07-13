import 'package:flutter/material.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';
import 'package:lahj_center/core/utils/font/fonts.dart';
import '../../../../core/const/widget/search.dart';
import '../../../../core/const/widget/tab_header.dart';

class UserResponsive extends StatelessWidget {
  const UserResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          // ===== Mobile Layout =====
          return CustomScrollView(
            slivers: [
              // ======= Header with Title + Search + Button ========
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // العنوان
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اداره المستخدمين",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: Fonts.cairo,
                                color: Appcolors.kblue,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "معلومات تفصيلية عن العناصر",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: Fonts.cairo,
                                color: Appcolors.kgrey3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // حقل البحث
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SearchTextformfield(controller: search),
                        ),
                      ),

                      // زر انشاء حساب
                      ElevatedButton(
                        onPressed: () {
                          // TODO: handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "انشاء حساب",
                          style: TextStyle(
                            fontFamily: Fonts.cairo,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Appcolors.kwhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===== Spacing =====
              SliverToBoxAdapter(child: SizedBox(height: 20)),

              // ===== Table Header =====
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: const Color(0xffF9FAFB),
                  child: Row(
                    children: const [
                      TableHeader(text: "الاسم"),
                      TableHeader(text: "البريد الإلكتروني"),
                      TableHeader(text: "تاريخ التسجيل"),
                      TableHeader(text: "الحالة"),
                    ],
                  ),
                ),
              ),

              // ===== Table Rows =====
              SliverList.separated(
                itemCount: 5,
                separatorBuilder: (context, index) => Divider(
                  color: Color(0xffF1F2F4),
                  thickness: 1,
                  height: 20,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      children: [
                        Expanded(child: Center(child: Text("محمد فتحي"))),
                        Expanded(child: Center(child: Text("mohamed12@gmail.com"))),
                        Expanded(child: Center(child: Text("15/3/2025"))),
                        Expanded(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _actionButton(icon: Icons.close, color: Colors.orange, label: ''),
                                SizedBox(width: 8),
                                _actionButton(icon: Icons.delete, color: Colors.red, label: ''),
                                SizedBox(width: 8),
                                _actionButton(icon: Icons.edit, color: Colors.green, label: ''),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          // ===== Desktop Layout =====
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child:
                SizedBox(height: 20,),),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // العنوان
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اداره المستخدمين",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: Fonts.cairo,
                                color: Appcolors.kblue,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "معلومات تفصيلية عن العناصر",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: Fonts.cairo,
                                color: Appcolors.kgrey3,
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Appcolors.kwhite,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // ===== Top Bar: Button + Search =====
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 250,
                                height: 40,

                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: SearchTextformfield(controller: search),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),

                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolors.blue,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  "إنشاء حساب",
                                  style: TextStyle(
                                    fontFamily: Fonts.cairo,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),


                        // ===== Table Header =====

                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          color: const Color(0xffF9FAFB),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              children: const [
                                TableHeader(text: "الاسم",),
                                TableHeader(text: "البريد الإلكتروني",),

                                TableHeader(text: "تاريخ التسجيل",),


                                TableHeader(text: "الإجراء",flex: 2,),
                              ],
                            ),
                          ),
                        ),

                        Divider(height: 1, color: Colors.grey.shade300),

                        // ===== Table Body (List) =====
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 20,
                          separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey.shade200),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(child: Center(child: Text("محمد فتحي"))),
                                  Expanded(child: Center(child: Text("mohamed12@gmail.com"))),
                                  Expanded(child: Center(child: Text("2025/6/10"))),

                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          _actionButton(icon: Icons.block, color: Colors.orange, label: "حظر"),
                                          SizedBox(width: 6),
                                          _actionButton(icon: Icons.delete, color: Colors.red, label: "حذف"),
                                          SizedBox(width: 6),
                                          _actionButton(icon: Icons.edit, color: Colors.green, label: "تعديل"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          );
        }
      },
    );
  }

  // ===== Reusable Action Button =====
  static Widget _actionButton({required IconData icon, required Color color, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}




