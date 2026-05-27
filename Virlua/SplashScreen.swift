//
//  SplashScreen.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/26/26.
//

import SwiftUI

// MARK: - Navigation Destination

enum SplashDestination {
    case login
    case register
}

// MARK: - Splash Screen View

struct SplashScreenView: View {
    @Environment(\.appTheme) private var theme
    @Environment(SupabaseAuthManager.self) private var auth

    @State private var destination: SplashDestination?

    // Animation state
    @State private var showBadge = false
    @State private var showHeadline = false
    @State private var showSubheadline = false
    @State private var showCard = false
    @State private var showButtons = false
    @State private var showFooter = false
    @State private var typingIndex = 0

    private let taskItems = [
        "ship-landing-page",
        "fix-auth-redirect",
        "finish goals view",
        "publish weekly log"
    ]

    var body: some View {
        Group {
            if auth.isAuthenticated {
                MainContent()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                switch destination {
                case .login:
                    LoginView()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                case .register:
                    RegisterView()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                case nil:
                    splashContent
                        .transition(.opacity)
                }
            }
        }
        .animation(.easeInOut(duration: 0.4), value: auth.isAuthenticated)
        .animation(.easeInOut(duration: 0.4), value: destination)
    }

    // MARK: - Splash Content

    private var splashContent: some View {
        ZStack {
            theme.colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                    .padding(.top, 8)

                Spacer()

                heroSection

                Spacer()

                ctaSection

                Spacer()
                    .frame(height: 32)

                footerBar
                    .padding(.bottom, 8)
            }
            .padding(.horizontal, 24)
        }
        .onAppear { startAnimationSequence() }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            HStack(spacing: 8) {
                Circle()
                    .fill(theme.colors.foreground)
                    .frame(width: 8, height: 8)

                Text("Virlua")
                    .font(AppTypography.label)
                    .foregroundColor(theme.colors.foreground)

                Text("/")
                    .font(AppTypography.small)
                    .foregroundColor(theme.colors.mutedForeground)

                Text("v0.1")
                    .font(AppTypography.code)
                    .foregroundColor(theme.colors.mutedForeground)
            }
            .opacity(showBadge ? 1 : 0)
            .offset(y: showBadge ? 0 : -8)

            Spacer()

            Text("for builders who actually ship")
                .font(AppTypography.code)
                .foregroundColor(theme.colors.mutedForeground)
                .opacity(showBadge ? 1 : 0)
                .offset(y: showBadge ? 0 : -8)
        }
    }

    // MARK: - Hero Section

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Label
            HStack(spacing: 8) {
                Rectangle()
                    .fill(theme.colors.mutedForeground)
                    .frame(width: 24, height: 1)

                Text("PROJECT TRACKER FOR DEVELOPERS")
                    .font(AppTypography.caption)
                    .tracking(2)
                    .foregroundColor(theme.colors.mutedForeground)
            }
            .opacity(showHeadline ? 1 : 0)
            .offset(y: showHeadline ? 0 : 12)

            // Main headline and card row
            VStack(alignment: .leading, spacing: 20) {
                // Headline
                VStack(alignment: .leading, spacing: 0) {
                    Text("Stop planning.")
                        .font(.system(size: 38, weight: .bold))
                        .tracking(-1.5)
                        .foregroundColor(theme.colors.foreground)

                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("Start ")
                            .font(.system(size: 38, weight: .bold))
                            .tracking(-1.5)
                            .foregroundColor(theme.colors.foreground)

                        Text("shipping")
                            .font(.system(size: 38, weight: .bold).italic())
                            .tracking(-1.5)
                            .foregroundColor(theme.colors.foreground)
                            .underline(true, color: theme.colors.foreground)

                        Text(".")
                            .font(.system(size: 38, weight: .bold))
                            .tracking(-1.5)
                            .foregroundColor(theme.colors.foreground)
                    }
                }
                .opacity(showHeadline ? 1 : 0)
                .offset(y: showHeadline ? 0 : 20)

                // Task card
                taskCard
                    .opacity(showCard ? 1 : 0)
                    .offset(y: showCard ? 0 : 16)
                    .scaleEffect(showCard ? 1 : 0.96)
            }

            // Description
            Text("Virlua is a quiet workspace for the projects you keep meaning to finish. Track goals, log progress, and turn the side-project graveyard into a portfolio.")
                .font(AppTypography.small)
                .foregroundColor(theme.colors.mutedForeground)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
                .opacity(showSubheadline ? 1 : 0)
                .offset(y: showSubheadline ? 0 : 12)
        }
    }

    // MARK: - Task Card

    private var taskCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Text("~/today")
                    .font(AppTypography.code)
                    .foregroundColor(theme.colors.foreground)

                Spacer()

                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 6, height: 6)
                    Text("live")
                        .font(AppTypography.code)
                        .foregroundColor(theme.colors.mutedForeground)
                }
            }

            Divider()
                .background(theme.colors.border)

            // Task items
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(taskItems.enumerated()), id: \.offset) { index, item in
                    HStack(spacing: 10) {
                        Text("→")
                            .font(AppTypography.code)
                            .foregroundColor(theme.colors.mutedForeground)

                        Text(item)
                            .font(AppTypography.code)
                            .foregroundColor(theme.colors.foreground)
                            .opacity(index <= typingIndex ? 1 : 0.3)

                        if index == 2 {
                            // Blinking cursor on the active task
                            BlinkingCursor(color: theme.colors.foreground)
                        }
                    }
                }
            }

            Divider()
                .background(theme.colors.border)

            // Footer
            Text("2 OF 4 DONE  ·  STREAK 12D")
                .font(.system(size: 10, weight: .regular, design: .monospaced))
                .tracking(1)
                .foregroundColor(theme.colors.mutedForeground)
        }
        .padding(16)
        .background(theme.colors.card)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(theme.colors.border, lineWidth: 1)
        )
    }

    // MARK: - CTA Section

    private var ctaSection: some View {
        VStack(spacing: 14) {
            Button {
                destination = .register
            } label: {
                HStack(spacing: 8) {
                    Text("Create an account")
                        .font(AppTypography.label)
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 12, weight: .semibold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(theme.colors.primary)
                .foregroundColor(theme.colors.primaryForeground)
                .cornerRadius(theme.radiusMd)
            }

            Button {
                destination = .login
            } label: {
                HStack(spacing: 4) {
                    Text("already have one?")
                        .font(AppTypography.code)
                        .foregroundColor(theme.colors.mutedForeground)

                    Text("sign in →")
                        .font(AppTypography.code)
                        .foregroundColor(theme.colors.foreground)
                }
            }
        }
        .opacity(showButtons ? 1 : 0)
        .offset(y: showButtons ? 0 : 16)
    }

    // MARK: - Footer Bar

    private var footerBar: some View {
        HStack {
            Text("EST. 2026")
                .font(.system(size: 10, weight: .regular, design: .monospaced))
                .foregroundColor(theme.colors.mutedForeground)

            Spacer()

            Text("BUILT BY DEVELOPERS, FOR DEVELOPERS")
                .font(.system(size: 10, weight: .regular, design: .monospaced))
                .foregroundColor(theme.colors.mutedForeground)
        }
        .tracking(1)
        .opacity(showFooter ? 1 : 0)
    }

    // MARK: - Animation Sequence

    private func startAnimationSequence() {
        withAnimation(.easeOut(duration: 0.5).delay(0.2)) {
            showBadge = true
        }
        withAnimation(.easeOut(duration: 0.6).delay(0.4)) {
            showHeadline = true
        }
        withAnimation(.easeOut(duration: 0.5).delay(0.7)) {
            showSubheadline = true
        }
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.9)) {
            showCard = true
        }

        // Stagger task items appearing
        for i in 0..<taskItems.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2 + Double(i) * 0.2) {
                withAnimation(.easeOut(duration: 0.3)) {
                    typingIndex = i
                }
            }
        }

        withAnimation(.easeOut(duration: 0.5).delay(1.6)) {
            showButtons = true
        }
        withAnimation(.easeOut(duration: 0.4).delay(1.9)) {
            showFooter = true
        }
    }
}

// MARK: - Blinking Cursor

struct BlinkingCursor: View {
    let color: Color
    @State private var visible = true

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 2, height: 14)
            .opacity(visible ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                    visible = false
                }
            }
    }
}

// MARK: - Preview

#Preview {
    SplashScreenView()
        .environment(SupabaseAuthManager())
        .appTheme()
        .preferredColorScheme(.dark)
}
