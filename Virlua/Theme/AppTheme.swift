//
//  AppTheme.swift
//  Virlua
//
//  Central theme entry point — mirrors Android Studio's Theme.kt pattern.
//  Inject via .appTheme() modifier; read with @Environment(\.appTheme).
//
//  Usage:
//      // Apply once at the root view:
//      ContentView().appTheme()
//
//      // Consume anywhere in the tree:
//      @Environment(\.appTheme) var theme
//      Text("Hello").foregroundColor(theme.colors.foreground)
//

import SwiftUI

// MARK: - AppTheme

struct AppTheme {
    let colors: AppColorScheme
    let typography = AppTypography.self

    // Radius scale (globals.css --radius: 0.625rem ≈ 10pt base)
    let radiusSm:  CGFloat = 6
    let radiusMd:  CGFloat = 8
    let radiusLg:  CGFloat = 10
    let radiusXl:  CGFloat = 14
    let radius2xl: CGFloat = 18
    let radius3xl: CGFloat = 22
    let radius4xl: CGFloat = 26

    static func resolve(for colorScheme: ColorScheme) -> AppTheme {
        AppTheme(colors: colorScheme == .dark ? .dark : .light)
    }
}

// MARK: - Environment key

private struct AppThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme(colors: .light)
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}

// MARK: - Root modifier

private struct AppThemeModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .environment(\.appTheme, AppTheme.resolve(for: colorScheme))
    }
}

extension View {
    /// Apply once at the root view to inject the theme into the environment.
    func appTheme() -> some View {
        modifier(AppThemeModifier())
    }
}

// MARK: - Styled component helpers
// Reusable themed building blocks, similar to shadcn's primitive components.

extension View {
    /// Full-screen background using theme background color.
    func themedBackground() -> some View {
        modifier(ThemedBackgroundModifier())
    }
}

private struct ThemedBackgroundModifier: ViewModifier {
    @Environment(\.appTheme) private var theme
    func body(content: Content) -> some View {
        content.background(theme.colors.background.ignoresSafeArea())
    }
}

// MARK: - Themed card modifier

struct CardStyle: ViewModifier {
    @Environment(\.appTheme) private var theme

    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(theme.colors.card)
            .foregroundColor(theme.colors.cardForeground)
            .cornerRadius(theme.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: theme.radiusLg)
                    .stroke(theme.colors.border, lineWidth: 1)
            )
    }
}

extension View {
    func cardStyle() -> some View { modifier(CardStyle()) }
}

// MARK: - Themed button styles

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.appTheme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.label)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(configuration.isPressed
                ? theme.colors.primary.opacity(0.85)
                : theme.colors.primary)
            .foregroundColor(theme.colors.primaryForeground)
            .cornerRadius(theme.radiusMd)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.appTheme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.label)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(configuration.isPressed
                ? theme.colors.secondary.opacity(0.75)
                : theme.colors.secondary)
            .foregroundColor(theme.colors.secondaryForeground)
            .cornerRadius(theme.radiusMd)
            .overlay(
                RoundedRectangle(cornerRadius: theme.radiusMd)
                    .stroke(theme.colors.border, lineWidth: 1)
            )
    }
}

struct DestructiveButtonStyle: ButtonStyle {
    @Environment(\.appTheme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.label)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(configuration.isPressed
                ? theme.colors.destructive.opacity(0.85)
                : theme.colors.destructive)
            .foregroundColor(.white)
            .cornerRadius(theme.radiusMd)
    }
}

// MARK: - Themed text field

struct ThemedTextFieldStyle: TextFieldStyle {
    @Environment(\.appTheme) private var theme

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(AppTypography.body)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(theme.colors.background)
            .foregroundColor(theme.colors.foreground)
            .cornerRadius(theme.radiusMd)
            .overlay(
                RoundedRectangle(cornerRadius: theme.radiusMd)
                    .stroke(theme.colors.border, lineWidth: 1)
            )
    }
}
