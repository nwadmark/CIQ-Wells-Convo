import SwiftUI

/// Example dashboard view using Stripe design system
/// Features gradient header, card grid, and metric displays
struct StripeDashboardView: View {
    @State private var selectedPeriod = "Month"
    let periods = ["Day", "Week", "Month", "Year"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Gradient header section
                    ZStack(alignment: .top) {
                        StripeGradients.primary
                            .frame(height: 220)
                            .ignoresSafeArea(edges: .top)

                        VStack(spacing: StripeSpacing.lg) {
                            // Header
                            HStack {
                                VStack(alignment: .leading, spacing: StripeSpacing.xs) {
                                    Text("Dashboard")
                                        .font(StripeTypography.largeTitle)
                                        .foregroundColor(.white)

                                    Text("Track your metrics")
                                        .font(StripeTypography.callout)
                                        .foregroundColor(.white.opacity(0.8))
                                }

                                Spacer()

                                Button(action: {}) {
                                    Image(systemName: "bell.fill")
                                        .foregroundColor(.white)
                                        .frame(width: 44, height: 44)
                                        .background(Color.white.opacity(0.2))
                                        .clipShape(Circle())
                                }
                            }
                            .padding(.top, StripeSpacing.lg)
                            .padding(.horizontal, StripeSpacing.lg)

                            // Period selector
                            HStack(spacing: StripeSpacing.xs) {
                                ForEach(periods, id: \.self) { period in
                                    PeriodButton(
                                        title: period,
                                        isSelected: selectedPeriod == period
                                    ) {
                                        withAnimation(StripeAnimations.quick) {
                                            selectedPeriod = period
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, StripeSpacing.lg)
                        }
                    }

                    // Metrics section
                    VStack(spacing: StripeSpacing.lg) {
                        // Main metric card
                        StripeCard {
                            VStack(alignment: .leading, spacing: StripeSpacing.md) {
                                HStack {
                                    Text("Total Revenue")
                                        .font(StripeTypography.subheadline)
                                        .foregroundColor(StripeColors.textSecondary)

                                    Spacer()

                                    StripeBadge(text: "+12.5%", color: StripeColors.success)
                                }

                                Text("$45,231.89")
                                    .font(StripeTypography.largeTitle)
                                    .foregroundColor(StripeColors.textPrimary)

                                Text("+$2,350.00 from last month")
                                    .font(StripeTypography.footnote)
                                    .foregroundColor(StripeColors.textSecondary)
                            }
                        }

                        // Metric grid
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: StripeSpacing.md),
                                GridItem(.flexible(), spacing: StripeSpacing.md)
                            ],
                            spacing: StripeSpacing.md
                        ) {
                            MetricCard(
                                title: "Customers",
                                value: "2,345",
                                change: "+180",
                                icon: "person.2.fill",
                                color: StripeColors.brandPurple
                            )

                            MetricCard(
                                title: "Transactions",
                                value: "12,234",
                                change: "+823",
                                icon: "arrow.left.arrow.right",
                                color: StripeColors.brandBlue
                            )

                            MetricCard(
                                title: "Avg. Order",
                                value: "$48.52",
                                change: "+2.5%",
                                icon: "chart.line.uptrend.xyaxis",
                                color: StripeColors.gradientPink
                            )

                            MetricCard(
                                title: "Success Rate",
                                value: "98.2%",
                                change: "+0.3%",
                                icon: "checkmark.circle.fill",
                                color: StripeColors.success
                            )
                        }

                        // Recent activity section
                        VStack(alignment: .leading, spacing: StripeSpacing.md) {
                            StripeSectionHeader(
                                title: "Recent Activity",
                                subtitle: "Latest transactions"
                            )

                            StripeCard {
                                VStack(spacing: StripeSpacing.md) {
                                    ForEach(0..<3) { index in
                                        ActivityRow(
                                            title: "Payment received",
                                            amount: "$142.50",
                                            time: "\(index + 1)h ago",
                                            isPositive: true
                                        )

                                        if index < 2 {
                                            Divider()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(StripeSpacing.lg)
                    .background(StripeColors.backgroundSubtle)
                }
            }
            .background(StripeColors.backgroundSubtle)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Supporting Components

struct PeriodButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(StripeTypography.buttonSmall)
                .foregroundColor(isSelected ? StripeColors.brandPurple : .white)
                .padding(.horizontal, StripeSpacing.md)
                .padding(.vertical, StripeSpacing.xs)
                .background(isSelected ? .white : Color.white.opacity(0.2))
                .cornerRadius(8)
        }
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let change: String
    let icon: String
    let color: Color

    var body: some View {
        StripeCard {
            VStack(alignment: .leading, spacing: StripeSpacing.sm) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.system(size: 20))

                    Spacer()
                }

                Text(value)
                    .font(StripeTypography.title2)
                    .foregroundColor(StripeColors.textPrimary)

                Text(title)
                    .font(StripeTypography.caption)
                    .foregroundColor(StripeColors.textSecondary)

                Text(change)
                    .font(StripeTypography.caption)
                    .foregroundColor(StripeColors.success)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 140)
    }
}

struct ActivityRow: View {
    let title: String
    let amount: String
    let time: String
    let isPositive: Bool

    var body: some View {
        HStack {
            Circle()
                .fill(isPositive ? StripeColors.success : StripeColors.error)
                .frame(width: 8, height: 8)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(StripeTypography.subheadline)
                    .foregroundColor(StripeColors.textPrimary)

                Text(time)
                    .font(StripeTypography.caption)
                    .foregroundColor(StripeColors.textSecondary)
            }

            Spacer()

            Text(amount)
                .font(StripeTypography.bodyMedium)
                .foregroundColor(isPositive ? StripeColors.success : StripeColors.error)
        }
    }
}

#Preview {
    StripeDashboardView()
}
