import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final Function(String) onSubCategorySelected;
  final VoidCallback onSuggestionTap;

  const CategorySelector({
    super.key,
    required this.onSubCategorySelected,
    required this.onSuggestionTap,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector>
    with TickerProviderStateMixin {
  bool _isCategoryExpanded = false;
  int? _selectedMainCategory;
  int? _selectedSubCategoryId;

  // 대주제 Map: mainIndex 기준으로 대주제명 관리
  static const Map<int, String> mainCategoryMap = {
    0: '올바른 분리배출',
    1: '다회용품 사용',
    2: '자원 절약 및 재활용',
    3: '건의하기',
  };

  // 소주제 Map: 고유 ID로 소주제명 + 대주제 인덱스 관리
  static const Map<int, Map<String, dynamic>> subCategoryMap = {
    // mainIndex: 0
    0: {'name': '페트병 라벨 제거', 'mainIndex': 0},
    1: {'name': '택배 상자 테이프/송장 제거', 'mainIndex': 0},
    2: {'name': '내용물이 비워진 우유갑/주스팩', 'mainIndex': 0},
    3: {'name': '깨끗한 스티로폼 박스', 'mainIndex': 0},

    // mainIndex: 1
    4: {'name': '카페/식당에서의 텀블러 사용', 'mainIndex': 1},
    5: {'name': '다회용기(용기내) 포장', 'mainIndex': 1},
    6: {'name': '장바구니 사용', 'mainIndex': 1},

    // mainIndex: 2
    7: {'name': '이면지 활용', 'mainIndex': 2},
    8: {'name': '전자영수증 발급 화면', 'mainIndex': 2},
    9: {'name': '사용하지 않는 플러그 뽑기', 'mainIndex': 2},
  };

  // 서버에서 아래와 같이 소주제 ID만 보내면 됨
  // 예시 JSON: { "subCategoryId": 6 }

  // 클라이언트에서 처리 예시:
  // final subId = 6;
  // final subName = subCategoryMap[subId]!['name'];
  // final mainIndex = subCategoryMap[subId]!['mainIndex'];
  // final mainName = mainCategoryMap[mainIndex];


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() => _isCategoryExpanded = !_isCategoryExpanded);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey.shade100,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.category, size: 18),
                const SizedBox(width: 8),
                Text(
                  _selectedSubCategoryId != null
                      ? subCategoryMap[_selectedSubCategoryId]!['name']
                      : '카테고리',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(_isCategoryExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isCategoryExpanded
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(mainCategoryMap.length, (index) {
              final isSelected = _selectedMainCategory == index;
              final isSuggestion = index == 3;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isSuggestion) {
                        widget.onSuggestionTap();
                        setState(() {
                          _isCategoryExpanded = false;
                        });
                      } else {
                        setState(() {
                          _selectedMainCategory = index;
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green.shade50
                            : Colors.white,
                        border:
                        Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        mainCategoryMap[index]!,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.green
                                : Colors.black),
                      ),
                    ),
                  ),
                  if (isSelected && !isSuggestion)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: subCategoryMap.entries
                            .where((entry) =>
                        entry.value['mainIndex'] == index)
                            .map((entry) {
                          final subId = entry.key;
                          final subName = entry.value['name'];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedSubCategoryId = subId;
                                _isCategoryExpanded = false;
                              });
                              widget.onSubCategorySelected(subName);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey.shade50,
                              ),
                              child: Text(subName),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                ],
              );
            }),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
