//
//  AppTypography.swift
//  Virlua
//
//  Typography scale mirroring shadcn's text conventions.
//  Maps shadcn text roles to SwiftUI Font values.
//

import SwiftUI

enum AppTypography {
    // Display / headings
    static let display  = Font.system(size: 36, weight: .bold)
    static let h1       = Font.system(size: 30, weight: .semibold)
    static let h2       = Font.system(size: 24, weight: .semibold)
    static let h3       = Font.system(size: 20, weight: .semibold)
    static let h4       = Font.system(size: 18, weight: .semibold)

    // Body
    static let large    = Font.system(size: 18, weight: .semibold)
    static let body     = Font.system(size: 16, weight: .regular)
    static let lead     = Font.system(size: 20, weight: .regular)

    // Small / supporting
    static let small    = Font.system(size: 14, weight: .regular)
    static let muted    = Font.system(size: 14, weight: .regular)

    // Inline
    static let code     = Font.system(size: 14, weight: .regular, design: .monospaced)
    static let blockquote = Font.system(size: 18, weight: .regular).italic()

    // Labels / captions
    static let label    = Font.system(size: 14, weight: .medium)
    static let caption  = Font.system(size: 12, weight: .regular)
}

// MARK: - Convenience modifiers

struct HeadingStyle: ViewModifier {
    let font: Font
    func body(content: Content) -> some View {
        content
            .font(font)
            .tracking(-0.5)
    }
}

extension View {
    func displayStyle()   -> some View { modifier(HeadingStyle(font: AppTypography.display)) }
    func h1Style()        -> some View { modifier(HeadingStyle(font: AppTypography.h1)) }
    func h2Style()        -> some View { modifier(HeadingStyle(font: AppTypography.h2)) }
    func h3Style()        -> some View { modifier(HeadingStyle(font: AppTypography.h3)) }
    func h4Style()        -> some View { modifier(HeadingStyle(font: AppTypography.h4)) }
    func bodyStyle()      -> some View { font(AppTypography.body) }
    func smallStyle()     -> some View { font(AppTypography.small) }
    func mutedStyle()     -> some View { font(AppTypography.muted) }
    func codeStyle()      -> some View { font(AppTypography.code) }
    func labelStyle_()    -> some View { font(AppTypography.label) }
}
