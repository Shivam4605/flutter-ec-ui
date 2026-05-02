import 'package:e_c_app/home_page.dart';
import 'package:flutter/material.dart';

const kBg = Color(0xFFF5F5F0);
const kDark = Color(0xFF1A1A2E);
const kAccent = Color(0xFFFF6B35);
const kGold = Color(0xFFFFB830);

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  // int _selectedSize = 1;
  // int _selectedColor = 0;
  bool _isWishlisted = false;
  int _quantity = 1;

  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.elasticOut,
    );
    _fabController.forward();
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(context),
              SliverToBoxAdapter(child: _buildBody()),
              const SliverToBoxAdapter(child: SizedBox(height: 110)),
            ],
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 360,
      pinned: true,
      backgroundColor: widget.product.tagColor,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kDark,
              size: 18,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 10, bottom: 10),
          child: GestureDetector(
            onTap: () => setState(() => _isWishlisted = !_isWishlisted),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                _isWishlisted
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: _isWishlisted ? Colors.redAccent : kDark,
                size: 20,
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Container(color: widget.product.tagColor),

            Positioned(
              right: -40,
              top: -40,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: 20,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),

            Positioned(
              top: 100,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "ZelOx".toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                  bottom: 20,
                  right: 20,
                  left: 100,
                ),
                child: Image.asset(
                  widget.product.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 100,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: kGold, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      widget.product.rating.toString(),
                      style: const TextStyle(
                        color: kDark,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "  (${widget.product.rating * 20} reviews)",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        color: kBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: kDark,
                          height: 1.1,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.product.subtitle,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.45),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.product.price,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: kAccent,
                      ),
                    ),
                    Text(
                      "2000",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.3),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Color",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: kDark,
              ),
            ),
            const SizedBox(height: 12),

            // Row(
            //   children: widget.product.colors.asMap().entries.map((e) {
            //     final selected = e.key == _selectedColor;
            //     return GestureDetector(
            //       onTap: () => setState(() => _selectedColor = e.key),
            //       child: AnimatedContainer(
            //         duration: const Duration(milliseconds: 200),
            //         margin: const EdgeInsets.only(right: 10),
            //         width: 36,
            //         height: 36,
            //         decoration: BoxDecoration(
            //           color: e.value,
            //           shape: BoxShape.circle,
            //           border: Border.all(
            //             color: selected ? kAccent : Colors.transparent,
            //             width: 2.5,
            //           ),
            //           boxShadow: [
            //             BoxShadow(
            //               color: e.value.withOpacity(0.4),
            //               blurRadius: 8,
            //               offset: const Offset(0, 3),
            //             ),
            //           ],
            //         ),
            //         child: selected
            //             ? const Icon(
            //                 Icons.check_rounded,
            //                 color: Colors.white,
            //                 size: 18,
            //               )
            //             : null,
            //       ),
            //     );
            //   }).toList(),
            // ),
            // const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Size",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: kDark,
                  ),
                ),
                Text(
                  "Size Guide",
                  style: TextStyle(
                    fontSize: 13,
                    color: kAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row(
            //   children: widget.product.sizes.asMap().entries.map((e) {
            //     final selected = e.key == _selectedSize;
            //     return GestureDetector(
            //       onTap: () => setState(() => _selectedSize = e.key),
            //       child: AnimatedContainer(
            //         duration: const Duration(milliseconds: 200),
            //         margin: const EdgeInsets.only(right: 10),
            //         width: 52,
            //         height: 52,
            //         decoration: BoxDecoration(
            //           color: selected ? kDark : Colors.white,
            //           borderRadius: BorderRadius.circular(14),
            //           border: Border.all(
            //             color: selected ? kDark : Colors.black.withOpacity(0.1),
            //           ),
            //           boxShadow: selected
            //               ? [
            //                   BoxShadow(
            //                     color: kDark.withOpacity(0.3),
            //                     blurRadius: 10,
            //                     offset: const Offset(0, 4),
            //                   ),
            //                 ]
            //               : [],
            //         ),
            //         child: Center(
            //           child: Text(
            //             e.value,
            //             style: TextStyle(
            //               color: selected ? Colors.white : kDark,
            //               fontWeight: FontWeight.w700,
            //               fontSize: 14,
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   }).toList(),
            // ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: kDark,
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black.withOpacity(0.08)),
                  ),
                  child: Row(
                    children: [
                      _QtyButton(
                        icon: Icons.remove_rounded,
                        onTap: () {
                          if (_quantity > 1) {
                            setState(() => _quantity--);
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          "$_quantity",
                          style: const TextStyle(
                            color: kDark,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      _QtyButton(
                        icon: Icons.add_rounded,
                        onTap: () => setState(() => _quantity++),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              " The Avoine Hooded Quilted Jacket combines warmth and luxury. "
              "Crafted from premium materials with a water-resistant finish, "
              "this jacket is perfect for the urban explorer who demands both "
              "style and function in every season.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.55),
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Reviews",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: kDark,
                  ),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                    fontSize: 13,
                    color: kAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _ReviewCard(
              name: "Priya S.",
              rating: 5,
              comment:
                  "Absolutely stunning jacket. The quality is outstanding and fits perfectly. Would definitely buy again!",
              date: "Apr 20",
              avatarColor: const Color(0xFF5C6BC0),
            ),
            const SizedBox(height: 10),
            _ReviewCard(
              name: "Rahul M.",
              rating: 4,
              comment:
                  "Great quality product. The material feels premium and the stitching is top notch.",
              date: "Mar 15",
              avatarColor: const Color(0xFF26A69A),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            ScaleTransition(
              scale: _fabAnimation,
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: kBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withOpacity(0.08)),
                ),
                child: const Icon(Icons.share_outlined, color: kDark, size: 22),
              ),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: ScaleTransition(
                scale: _fabAnimation,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Added to cart!"),
                        backgroundColor: kDark,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: kDark,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: kDark.withOpacity(0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.shopping_bag_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            ScaleTransition(
              scale: _fabAnimation,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: kAccent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: kAccent.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.bolt_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: kBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: kDark, size: 18),
      ),
    );
  }
}

// ─── Review Card ──────────────────────────────────────────────────────────────
class _ReviewCard extends StatelessWidget {
  final String name;
  final int rating;
  final String comment;
  final String date;
  final Color avatarColor;

  const _ReviewCard({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: avatarColor,
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: kDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < rating
                              ? Icons.star_rounded
                              : Icons.star_border_rounded,
                          color: kGold,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.35),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(0.55),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (_) => ProductDetailPage(
//       product: ProductDetail(
//         name: "Avoine Hooded",
//         subtitle: "Quilted Jacket",
//         brand: "ZelOx",
//         price: "\$1,500",
//         originalPrice: "\$2,100",
//         rating: 4.7,
//         reviewCount: 128,
//         imagePath: "assets/fe719fa1e2921309a5540b5cc15fe195-removebg-preview.png",
//         bgColor: Color(0xFFE8D5B7),
//         description:
//             "The Avoine Hooded Quilted Jacket combines warmth and luxury. "
//             "Crafted from premium materials with a water-resistant finish, "
//             "this jacket is perfect for the urban explorer who demands both "
//             "style and function in every season.",
//         sizes: ["XS", "S", "M", "L", "XL"],
//         colors: [
//           Color(0xFFE8D5B7),
//           Color(0xFF1A1A2E),
//           Color(0xFF795548),
//           Color(0xFF455A64),
//         ],
//       ),
//     ),
//   ),
// );
