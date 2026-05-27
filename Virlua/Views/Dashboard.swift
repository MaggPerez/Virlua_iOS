//
//  Dashboard.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/26/26.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    @Environment(\.appTheme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // Page header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Dashboard")
                        .h2Style()
                        .foregroundColor(theme.colors.foreground)
                    Text("Welcome back!")
                        .smallStyle()
                        .foregroundColor(theme.colors.mutedForeground)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Stat cards row
                HStack(spacing: 12) {
                    StatCard(label: "Total", value: "—")
                    StatCard(label: "Active", value: "—")
                    StatCard(label: "Pending", value: "—")
                }

                // Content card placeholder
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recent Activity")
                        .h4Style()
                        .foregroundColor(theme.colors.foreground)

                    Text("Nothing here yet.")
                        .bodyStyle()
                        .foregroundColor(theme.colors.mutedForeground)
                }
                .cardStyle()
            }
            .padding(16)
        }
        .themedBackground()
    }
}

// MARK: - Stat card

private struct StatCard: View {
    let label: String
    let value: String

    @Environment(\.appTheme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .labelStyle_()
                .foregroundColor(theme.colors.mutedForeground)
            Text(value)
                .h3Style()
                .foregroundColor(theme.colors.foreground)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

#Preview {
    DashboardView()
        .appTheme()
}
