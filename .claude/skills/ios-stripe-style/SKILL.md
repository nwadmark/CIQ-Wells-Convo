---
name: ios-stripe-style
description: Build iOS apps with Stripe's signature design aesthetic featuring vibrant gradients, modern UI components, and accessible color systems. Use when creating SwiftUI apps that need elegant, minimalist interfaces with animated gradients and Stripe's characteristic purple-blue-pink color palette.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# iOS Stripe Style Design System

## Overview
This skill guides the creation of iOS applications using Stripe's distinctive design language: vibrant animated gradients, clean typography, accessible color systems, and modern, minimalist UI components.

Stripe's design philosophy emphasizes:
- **Vibrant, accessible colors** - Hand-picked colors that meet WCAG standards
- **Animated gradients** - Dynamic, wave-like gradient backgrounds
- **Clean hierarchy** - Clear visual organization and purposeful spacing
- **Elegant simplicity** - Minimalist components with maximum impact

## Color System

### Primary Brand Colors
```swift
// Stripe's signature gradient colors
struct StripeColors {
    // Core brand colors
    static let brandPurple = Color(hex: "#5E46BF")
    static let brandBlue = Color(hex: "#1CA8FF")

    // Gradient palette (for animated backgrounds)
    static let gradientPink = Color(hex: "#ef008f")
    static let gradientLightBlue = Color(hex: "#6ec3f4")
    static let gradientPurple = Color(hex: "#7038ff")
    static let gradientYellow = Color(hex: "#ffba27")

    // UI colors
    static let textPrimary = Color(hex: "#0A2540")
    static let textSecondary = Color(hex: "#425466")
    static let background = Color(hex: "#FFFFFF")
    static let backgroundSubtle = Color(hex: "#F6F9FC")

    // Semantic colors
    static let success = Color(hex: "#00D924")
    static let error = Color(hex: "#DF1B41")
    static let warning = Color(hex: "#FFB323")
}

// Helper extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
```

### Gradient Definitions
```swift
// Linear gradients for backgrounds and accents
struct StripeGradients {
    static let primary = LinearGradient(
        colors: [StripeColors.brandPurple, StripeColors.brandBlue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let vibrant = LinearGradient(
        colors: [
            StripeColors.gradientPurple,
            StripeColors.gradientPink,
            StripeColors.gradientLightBlue
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let sunset = LinearGradient(
        colors: [
            StripeColors.gradientPink,
            StripeColors.gradientYellow
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
}
```

## Typography

### Font System
```swift
struct StripeTypography {
    // Headings - using SF Pro (default iOS system font)
    static let largeTitle = Font.system(size: 34, weight: .bold)
    static let title1 = Font.system(size: 28, weight: .semibold)
    static let title2 = Font.system(size: 22, weight: .semibold)
    static let title3 = Font.system(size: 20, weight: .semibold)

    // Body text
    static let body = Font.system(size: 17, weight: .regular)
    static let bodyMedium = Font.system(size: 17, weight: .medium)
    static let bodyBold = Font.system(size: 17, weight: .semibold)

    // Supporting text
    static let callout = Font.system(size: 16, weight: .regular)
    static let subheadline = Font.system(size: 15, weight: .regular)
    static let footnote = Font.system(size: 13, weight: .regular)
    static let caption = Font.system(size: 12, weight: .regular)

    // Buttons
    static let button = Font.system(size: 17, weight: .semibold)
    static let buttonSmall = Font.system(size: 15, weight: .semibold)
}
```

## Spacing Scale

```swift
struct StripeSpacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64
}
```

## Component Library

### 1. Stripe Button
```swift
struct StripeButton: View {
    let title: String
    let action: () -> Void
    var style: ButtonStyle = .primary
    var isFullWidth: Bool = true
    var isLoading: Bool = false

    enum ButtonStyle {
        case primary
        case secondary
        case gradient
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: StripeSpacing.xs) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                }

                Text(title)
                    .font(StripeTypography.button)
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .frame(height: 50)
            .background(backgroundView)
            .cornerRadius(8)
        }
        .disabled(isLoading)
    }

    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .primary:
            StripeColors.brandPurple
        case .secondary:
            StripeColors.backgroundSubtle
        case .gradient:
            StripeGradients.primary
        }
    }

    private var textColor: Color {
        switch style {
        case .primary, .gradient:
            return .white
        case .secondary:
            return StripeColors.textPrimary
        }
    }
}
```

### 2. Stripe Card
```swift
struct StripeCard<Content: View>: View {
    let content: Content
    var hasShadow: Bool = true

    init(hasShadow: Bool = true, @ViewBuilder content: () -> Content) {
        self.hasShadow = hasShadow
        self.content = content()
    }

    var body: some View {
        content
            .padding(StripeSpacing.lg)
            .background(StripeColors.background)
            .cornerRadius(12)
            .shadow(
                color: hasShadow ? Color.black.opacity(0.06) : Color.clear,
                radius: 8,
                x: 0,
                y: 4
            )
    }
}
```

### 3. Animated Gradient Background
```swift
struct StripeAnimatedGradient: View {
    @State private var animateGradient = false

    var body: some View {
        LinearGradient(
            colors: [
                StripeColors.gradientPurple,
                StripeColors.gradientPink,
                StripeColors.gradientLightBlue,
                StripeColors.gradientYellow
            ],
            startPoint: animateGradient ? .topLeading : .bottomLeading,
            endPoint: animateGradient ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(
                .easeInOut(duration: 3.0)
                .repeatForever(autoreverses: true)
            ) {
                animateGradient.toggle()
            }
        }
    }
}
```

### 4. Stripe Text Field
```swift
struct StripeTextField: View {
    let label: String
    @Binding var text: String
    var placeholder: String = ""
    var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: StripeSpacing.xs) {
            Text(label)
                .font(StripeTypography.subheadline)
                .foregroundColor(StripeColors.textSecondary)

            TextField(placeholder, text: $text)
                .font(StripeTypography.body)
                .padding(StripeSpacing.md)
                .background(StripeColors.backgroundSubtle)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor, lineWidth: 1)
                )

            if let error = errorMessage {
                Text(error)
                    .font(StripeTypography.caption)
                    .foregroundColor(StripeColors.error)
            }
        }
    }

    private var borderColor: Color {
        if errorMessage != nil {
            return StripeColors.error
        }
        return Color.clear
    }
}
```

### 5. Stripe Badge
```swift
struct StripeBadge: View {
    let text: String
    var color: Color = StripeColors.brandPurple

    var body: some View {
        Text(text)
            .font(StripeTypography.caption)
            .foregroundColor(.white)
            .padding(.horizontal, StripeSpacing.sm)
            .padding(.vertical, StripeSpacing.xxs)
            .background(color)
            .cornerRadius(4)
    }
}
```

### 6. Stripe Section Header
```swift
struct StripeSectionHeader: View {
    let title: String
    var subtitle: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: StripeSpacing.xs) {
            Text(title)
                .font(StripeTypography.title2)
                .foregroundColor(StripeColors.textPrimary)

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(StripeTypography.callout)
                    .foregroundColor(StripeColors.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
```

## Layout Patterns

### 1. Stripe Form Layout
```swift
struct StripeFormView: View {
    @State private var email = ""
    @State private var name = ""

    var body: some View {
        ScrollView {
            VStack(spacing: StripeSpacing.lg) {
                StripeSectionHeader(
                    title: "Create Account",
                    subtitle: "Get started with your free account"
                )

                VStack(spacing: StripeSpacing.md) {
                    StripeTextField(
                        label: "Email",
                        text: $email,
                        placeholder: "you@example.com"
                    )

                    StripeTextField(
                        label: "Full Name",
                        text: $name,
                        placeholder: "John Doe"
                    )
                }

                StripeButton(title: "Continue") {
                    // Handle action
                }

                Spacer()
            }
            .padding(StripeSpacing.lg)
        }
        .background(StripeColors.backgroundSubtle)
    }
}
```

### 2. Stripe Card Grid
```swift
struct StripeCardGrid: View {
    let items = ["Analytics", "Payments", "Billing", "Reports"]

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: StripeSpacing.md),
                    GridItem(.flexible(), spacing: StripeSpacing.md)
                ],
                spacing: StripeSpacing.md
            ) {
                ForEach(items, id: \.self) { item in
                    StripeCard {
                        VStack(alignment: .leading, spacing: StripeSpacing.sm) {
                            Image(systemName: "chart.bar.fill")
                                .font(.system(size: 24))
                                .foregroundColor(StripeColors.brandPurple)

                            Text(item)
                                .font(StripeTypography.title3)
                                .foregroundColor(StripeColors.textPrimary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 120)
                    }
                }
            }
            .padding(StripeSpacing.lg)
        }
        .background(StripeColors.backgroundSubtle)
    }
}
```

### 3. Stripe Hero Section
```swift
struct StripeHeroSection: View {
    var body: some View {
        ZStack {
            StripeAnimatedGradient()

            VStack(spacing: StripeSpacing.xl) {
                VStack(spacing: StripeSpacing.md) {
                    Text("Financial infrastructure")
                        .font(StripeTypography.largeTitle)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Text("for the internet")
                        .font(StripeTypography.largeTitle)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }

                Text("Millions of businesses use Stripe to accept payments and manage their business online")
                    .font(StripeTypography.body)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, StripeSpacing.xl)

                StripeButton(title: "Start now", style: .secondary) {
                    // Handle action
                }
                .padding(.horizontal, StripeSpacing.xl)
            }
        }
        .frame(height: 500)
    }
}
```

## Animation Guidelines

### Standard Animations
```swift
// Use these standard animation configurations
struct StripeAnimations {
    // Smooth, natural animations
    static let standard = Animation.easeInOut(duration: 0.3)

    // Quick micro-interactions
    static let quick = Animation.easeOut(duration: 0.15)

    // Slow, deliberate transitions
    static let slow = Animation.easeInOut(duration: 0.5)

    // Spring animations for interactive elements
    static let spring = Animation.spring(response: 0.3, dampingFraction: 0.7)
}
```

### Common Animation Patterns
```swift
// Button press animation
.scaleEffect(isPressed ? 0.96 : 1.0)
.animation(StripeAnimations.quick, value: isPressed)

// Fade in animation
.opacity(isVisible ? 1 : 0)
.animation(StripeAnimations.standard, value: isVisible)

// Slide in animation
.offset(y: isPresented ? 0 : 20)
.opacity(isPresented ? 1 : 0)
.animation(StripeAnimations.spring, value: isPresented)
```

## Accessibility Guidelines

1. **Color Contrast**: All text meets WCAG AA standards (4.5:1 for normal text, 3:1 for large text)
2. **Touch Targets**: Minimum 44x44pt for all interactive elements
3. **Dynamic Type**: Support system font scaling with `@ScaledMetric`
4. **VoiceOver**: Add meaningful labels to all interactive elements
5. **Reduce Motion**: Respect `AccessibilityReduceMotion` for animations

### Example: Accessible Button
```swift
struct AccessibleStripeButton: View {
    let title: String
    let action: () -> Void
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(StripeTypography.button)
        }
        .accessibilityLabel(title)
        .accessibilityHint("Double tap to activate")
        .frame(minHeight: 44) // Minimum touch target
    }
}
```

## Best Practices

### DO:
- ✅ Use the defined color palette consistently
- ✅ Implement smooth, purposeful animations
- ✅ Maintain minimum 44pt touch targets
- ✅ Use the spacing scale for consistent layouts
- ✅ Follow iOS Human Interface Guidelines
- ✅ Test on multiple device sizes
- ✅ Support dark mode with appropriate color adaptations
- ✅ Use SF Symbols for icons
- ✅ Keep gradients subtle and purposeful

### DON'T:
- ❌ Create custom colors outside the palette
- ❌ Use overly complex or distracting animations
- ❌ Mix inconsistent spacing values
- ❌ Ignore accessibility requirements
- ❌ Use gradients on small UI elements
- ❌ Override system fonts unnecessarily
- ❌ Add borders when shadows suffice
- ❌ Create overly busy layouts

## Dark Mode Support

```swift
// Extend colors for dark mode
extension StripeColors {
    static let textPrimaryDark = Color(hex: "#E3E8EF")
    static let textSecondaryDark = Color(hex: "#A3ACB9")
    static let backgroundDark = Color(hex: "#0A2540")
    static let backgroundSubtleDark = Color(hex: "#1A365D")
}

// Auto-adapting color
static var adaptiveBackground: Color {
    Color(UIColor { traitCollection in
        traitCollection.userInterfaceStyle == .dark
            ? UIColor(StripeColors.backgroundDark)
            : UIColor(StripeColors.background)
    })
}
```

## Implementation Checklist

When building a new iOS app with Stripe style:

- [ ] Copy the StripeColors struct to your project
- [ ] Copy the StripeTypography struct
- [ ] Copy the StripeSpacing struct
- [ ] Add the Color hex initializer extension
- [ ] Import component files you need
- [ ] Configure dark mode color adaptations
- [ ] Set up accessibility labels
- [ ] Test on iPhone and iPad
- [ ] Verify touch targets are 44pt minimum
- [ ] Test with VoiceOver enabled
- [ ] Test with Dynamic Type at various sizes
- [ ] Verify gradient performance on older devices

## Example App Structure

```
MyStripeStyleApp/
├── App/
│   └── MyApp.swift
├── Core/
│   ├── Design/
│   │   ├── StripeColors.swift
│   │   ├── StripeTypography.swift
│   │   ├── StripeSpacing.swift
│   │   └── StripeGradients.swift
│   └── Components/
│       ├── StripeButton.swift
│       ├── StripeCard.swift
│       ├── StripeTextField.swift
│       └── StripeAnimatedGradient.swift
├── Features/
│   ├── Home/
│   ├── Profile/
│   └── Settings/
└── Resources/
    └── Assets.xcassets
```

## When to Use This Skill

Invoke this skill when you need to:
- Build a new iOS app with modern, vibrant design
- Create payment or financial interfaces
- Implement animated gradient backgrounds
- Design forms and input flows
- Build dashboard or analytics screens
- Create onboarding experiences
- Ensure consistent design system implementation
- Need guidance on Stripe-style components and patterns

The skill provides production-ready SwiftUI code that can be copied directly into your iOS project.
