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
  String? _selectedSubCategory;

  static const List<String> mainCategories = [
    '올바른 분리배출',
    '다회용품 사용',
    '자원 절약 및 재활용',
    '건의하기',
  ];

  static const List<List<String>> subCategories = [
    [
      '페트병 라벨 제거',
      '택배 상자 테이프/송장 제거',
      '내용물이 비워진 우유갑/주스팩',
      '깨끗한 스티로폼 박스'
    ],
    [
      '카페/식당에서의 텀블러 사용',
      '다회용기(용기내) 포장',
      '장바구니 사용'
    ],
    [
      '이면지 활용',
      '전자영수증 발급 화면',
      '사용하지 않는 플러그 뽑기'
    ],
    [] // 건의하기는 서브카테고리 없음
  ];

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
                  _selectedSubCategory ?? '카테고리',
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
            children: List.generate(mainCategories.length, (index) {
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
                        mainCategories[index],
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
                        children: List.generate(
                            subCategories[index].length, (subIndex) {
                          final selected =
                          subCategories[index][subIndex];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedSubCategory = selected;
                                _isCategoryExpanded = false;
                              });
                              widget
                                  .onSubCategorySelected(selected);
                            },
                            child: Container(
                              margin:
                              const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey.shade50,
                              ),
                              child: Text(selected),
                            ),
                          );
                        }),
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
