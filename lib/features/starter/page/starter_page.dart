import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tere_mood/core/enum/listening_enum.dart';
import 'package:tere_mood/core/theme/app_theme.dart';
import 'package:tere_mood/core/widget/avatar_widget.dart';
import 'package:tere_mood/core/widget/button.dart';
import 'package:tere_mood/core/widget/listen_badge.dart';
import 'package:tere_mood/features/starter/bloc/starter_bloc.dart';
import 'package:tere_mood/l10n/app_localizations.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StarterPage();
  }
}

class _StarterPage extends StatefulWidget {
  const _StarterPage();

  @override
  State<_StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<_StarterPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AppLocalizations appLocalizations;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => StarterPageBloc()..add(StarterPageEventSetup(
        greetingMessage: appLocalizations.textHelloBeautiful,
        subtitleMessage: appLocalizations.textStarterDescription,
      )),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8FC),
        body: SafeArea(
          child: BlocConsumer<StarterPageBloc, StarterPageState>(
            listener: (context, state) {
              if (state.status == ListeningStatus.checkingIn) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Starting your check-in session 🌸'),
                    backgroundColor: const Color(0xFFE85C93),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            builder: (context, state) {
              final isListening = state.status == ListeningStatus.listening;
              final isCheckingIn = state.status == ListeningStatus.checkingIn;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => context.read<StarterPageBloc>().add(
                            StarterPageEventHeartTapped(context: context, appLocalizations: appLocalizations),
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.elasticOut,
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: state.isHeartFilled
                                  ? AppTheme.softPink
                                  : AppTheme.softPink,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              state.isHeartFilled
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: state.isHeartFilled
                                  ? AppTheme.pink
                                  : AppTheme.pink,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 20),
                                Stack(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.none,
                                  children: [
                                    AvatarWidget(
                                      isListening: isListening,
                                      avatarImageProvider:
                                          const AssetImage('assets/images/il_kitty.jpg'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                ListeningBadge(isListening: isListening),
                                const SizedBox(height: 96),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                  child: Column(
                                    key: ValueKey(state.greetingMessage),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/ic_spark_line.svg',
                                            width: 20,
                                            height: 20,
                                            colorFilter: const ColorFilter.mode(
                                              AppTheme.idleBadgeColor,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            state.greetingMessage,
                                            style: GoogleFonts.openSans(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF1A1A2E),
                                              height: 1.2,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          SvgPicture.asset(
                                            'assets/icons/ic_spark_line.svg',
                                            width: 20,
                                            height: 20,
                                            colorFilter: const ColorFilter.mode(
                                              AppTheme.idleBadgeColor,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        state.subtitleMessage,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF888888),
                                          height: 1.6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 67),
                                CheckInButton(
                                  onPressed: () {
                                    context.read<StarterPageBloc>().add(
                                      StarterPageEventCheckIn(
                                        greetingMessage: appLocalizations
                                            .textHelloBeautifulListening,
                                        subtitleMessage: appLocalizations
                                            .textStarterDescriptionListening,
                                      ),
                                    );
                                  },
                                  isLoading: isCheckingIn,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  appLocalizations.textStarterFootText,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    color: const Color(0xFFBBBBBB),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FloatingHeart extends StatefulWidget {
  const _FloatingHeart({required this.animate});

  final bool animate;

  @override
  State<_FloatingHeart> createState() => _FloatingHeartState();
}

class _FloatingHeartState extends State<_FloatingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -4,
      end: 4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, widget.animate ? _floatAnimation.value : 0),
          child: const Icon(
            Icons.favorite_border,
            color: Color(0xFFE85C93),
            size: 24,
          ),
        );
      },
    );
  }
}
