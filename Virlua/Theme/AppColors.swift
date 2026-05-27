//
//  AppColors.swift
//  Virlua
//
//  Color tokens converted from globals.css (shadcn black & white theme).
//  oklch(L 0 0) achromatic values → sRGB hex via standard OKLCH→sRGB pipeline.
//
//  Light / dark variants mirror :root and .dark in globals.css.
//

import SwiftUI

// MARK: - Hex initializer

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double( int        & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Raw palette
// Each constant name reflects the CSS lightness value for traceability.

enum AppPalette {
    // Grays (oklch chroma = 0, hue = 0 → pure gray)
    static let white        = Color(hex: "FFFFFF") // oklch(1 0 0)
    static let gray50       = Color(hex: "FAFAFA") // oklch(0.985 0 0)
    static let gray100      = Color(hex: "F5F5F5") // oklch(0.97 0 0)
    static let gray200      = Color(hex: "E5E5E5") // oklch(0.922 0 0)
    static let gray300      = Color(hex: "D4D4D4") // oklch(0.87 0 0)
    static let gray400      = Color(hex: "A1A1A1") // oklch(0.708 0 0)
    static let gray500      = Color(hex: "737373") // oklch(0.556 0 0)
    static let gray600      = Color(hex: "525252") // oklch(0.439 0 0)
    static let gray700      = Color(hex: "404040") // oklch(0.371 0 0)
    static let gray800      = Color(hex: "262626") // oklch(0.269 0 0)
    static let gray900      = Color(hex: "171717") // oklch(0.205 0 0)
    static let gray950      = Color(hex: "0A0A0A") // oklch(0.145 0 0)

    // Accents
    static let redLight     = Color(hex: "E7000B") // oklch(0.577 0.245 27.325) — light destructive
    static let redDark      = Color(hex: "FF6467") // oklch(0.704 0.191 22.216) — dark destructive
    static let blueAccent   = Color(hex: "1248E6") // oklch(0.488 0.243 264.376) — dark sidebar-primary
}

// MARK: - Semantic color scheme

struct AppColorScheme {
    let background:              Color
    let foreground:              Color
    let card:                    Color
    let cardForeground:          Color
    let popover:                 Color
    let popoverForeground:       Color
    let primary:                 Color
    let primaryForeground:       Color
    let secondary:               Color
    let secondaryForeground:     Color
    let muted:                   Color
    let mutedForeground:         Color
    let accent:                  Color
    let accentForeground:        Color
    let destructive:             Color
    let border:                  Color
    let input:                   Color
    let ring:                    Color
    let chart1:                  Color
    let chart2:                  Color
    let chart3:                  Color
    let chart4:                  Color
    let chart5:                  Color
    let sidebar:                 Color
    let sidebarForeground:       Color
    let sidebarPrimary:          Color
    let sidebarPrimaryForeground:Color
    let sidebarAccent:           Color
    let sidebarAccentForeground: Color
    let sidebarBorder:           Color
    let sidebarRing:             Color

    // MARK: Light — mirrors :root in globals.css
    static let light = AppColorScheme(
        background:               AppPalette.white,
        foreground:               AppPalette.gray950,
        card:                     AppPalette.white,
        cardForeground:           AppPalette.gray950,
        popover:                  AppPalette.white,
        popoverForeground:        AppPalette.gray950,
        primary:                  AppPalette.gray900,
        primaryForeground:        AppPalette.gray50,
        secondary:                AppPalette.gray100,
        secondaryForeground:      AppPalette.gray900,
        muted:                    AppPalette.gray100,
        mutedForeground:          AppPalette.gray500,
        accent:                   AppPalette.gray100,
        accentForeground:         AppPalette.gray900,
        destructive:              AppPalette.redLight,
        border:                   AppPalette.gray200,
        input:                    AppPalette.gray200,
        ring:                     AppPalette.gray400,
        chart1:                   AppPalette.gray300,
        chart2:                   AppPalette.gray500,
        chart3:                   AppPalette.gray600,
        chart4:                   AppPalette.gray700,
        chart5:                   AppPalette.gray800,
        sidebar:                  AppPalette.gray50,
        sidebarForeground:        AppPalette.gray950,
        sidebarPrimary:           AppPalette.gray900,
        sidebarPrimaryForeground: AppPalette.gray50,
        sidebarAccent:            AppPalette.gray100,
        sidebarAccentForeground:  AppPalette.gray900,
        sidebarBorder:            AppPalette.gray200,
        sidebarRing:              AppPalette.gray400
    )

    // MARK: Dark — mirrors .dark in globals.css
    // border/input/sidebarBorder use white with opacity (oklch(1 0 0 / 10%) and 15%)
    static let dark = AppColorScheme(
        background:               AppPalette.gray950,
        foreground:               AppPalette.gray50,
        card:                     AppPalette.gray900,
        cardForeground:           AppPalette.gray50,
        popover:                  AppPalette.gray900,
        popoverForeground:        AppPalette.gray50,
        primary:                  AppPalette.gray200,
        primaryForeground:        AppPalette.gray900,
        secondary:                AppPalette.gray800,
        secondaryForeground:      AppPalette.gray50,
        muted:                    AppPalette.gray800,
        mutedForeground:          AppPalette.gray400,
        accent:                   AppPalette.gray800,
        accentForeground:         AppPalette.gray50,
        destructive:              AppPalette.redDark,
        border:                   Color.white.opacity(0.10), // oklch(1 0 0 / 10%)
        input:                    Color.white.opacity(0.15), // oklch(1 0 0 / 15%)
        ring:                     AppPalette.gray500,
        chart1:                   AppPalette.gray300,
        chart2:                   AppPalette.gray500,
        chart3:                   AppPalette.gray600,
        chart4:                   AppPalette.gray700,
        chart5:                   AppPalette.gray800,
        sidebar:                  AppPalette.gray900,
        sidebarForeground:        AppPalette.gray50,
        sidebarPrimary:           AppPalette.blueAccent, // oklch(0.488 0.243 264.376)
        sidebarPrimaryForeground: AppPalette.gray50,
        sidebarAccent:            AppPalette.gray800,
        sidebarAccentForeground:  AppPalette.gray50,
        sidebarBorder:            Color.white.opacity(0.10),
        sidebarRing:              AppPalette.gray500
    )
}
