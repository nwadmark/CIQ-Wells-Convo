# Stripe iOS Design - Quick Reference

## 🎨 Color Palette

### Primary Colors
```
Brand Purple: #5E46BF
Brand Blue:   #1CA8FF
```

### Gradient Colors
```
Pink:       #ef008f
Light Blue: #6ec3f4
Purple:     #7038ff
Yellow:     #ffba27
```

### UI Colors
```
Text Primary:   #0A2540
Text Secondary: #425466
Background:     #FFFFFF
BG Subtle:      #F6F9FC
Success:        #00D924
Error:          #DF1B41
Warning:        #FFB323
```

## 📏 Spacing Scale

```swift
xxs:  4pt
xs:   8pt
sm:   12pt
md:   16pt  // Most common
lg:   24pt  // Section spacing
xl:   32pt
xxl:  48pt
xxxl: 64pt
```

## 🔤 Typography

```swift
// Headings
largeTitle: 34pt, bold
title1:     28pt, semibold
title2:     22pt, semibold
title3:     20pt, semibold

// Body
body:       17pt, regular
bodyMedium: 17pt, medium
callout:    16pt, regular

// Small text
subheadline: 15pt, regular
footnote:    13pt, regular
caption:     12pt, regular

// Buttons
button:      17pt, semibold
buttonSmall: 15pt, semibold
```

## 🧩 Key Components

### 1. Button
- Height: 50pt
- Border radius: 8pt
- Font: semibold, 17pt
- Styles: primary, secondary, gradient

### 2. Card
- Padding: 24pt
- Border radius: 12pt
- Shadow: black 6% opacity, 8pt radius

### 3. Text Field
- Height: auto (min 44pt for touch target)
- Border radius: 8pt
- Background: #F6F9FC
- Font: 17pt regular

### 4. Badge
- Padding: 4pt vertical, 12pt horizontal
- Border radius: 4pt
- Font: 12pt, regular

## 🎬 Animations

```swift
standard: .easeInOut(duration: 0.3)  // Default
quick:    .easeOut(duration: 0.15)   // Micro-interactions
slow:     .easeInOut(duration: 0.5)  // Big transitions
spring:   .spring(response: 0.3, dampingFraction: 0.7)
```

## ✅ Accessibility Checklist

- [ ] All touch targets minimum 44x44pt
- [ ] Text contrast meets WCAG AA (4.5:1)
- [ ] VoiceOver labels on all interactive elements
- [ ] Support Dynamic Type scaling
- [ ] Respect Reduce Motion preference
- [ ] Test with VoiceOver enabled

## 🏗️ Common Patterns

### Gradient Header + Content
```
ZStack {
    gradient (height: ~200-250pt)
    ScrollView {
        content below gradient
    }
}
```

### Card Grid
```
LazyVGrid(columns: [flexible, flexible], spacing: 16) {
    cards...
}
```

### Form Layout
```
ScrollView {
    VStack(spacing: 24) {
        header
        fields (spacing: 16)
        button
    }
    .padding(24)
}
```

## 🚀 Quick Start Checklist

1. Copy these to your project:
   - [ ] `StripeColors` struct
   - [ ] `StripeTypography` struct
   - [ ] `StripeSpacing` struct
   - [ ] `Color.init(hex:)` extension

2. Add core components:
   - [ ] `StripeButton`
   - [ ] `StripeCard`
   - [ ] `StripeTextField`

3. Optional enhancements:
   - [ ] `StripeAnimatedGradient`
   - [ ] `StripeBadge`
   - [ ] `StripeSectionHeader`

4. Configure:
   - [ ] Dark mode colors
   - [ ] Accessibility labels
   - [ ] Preview providers

## 💡 Design Principles

1. **Vibrant but Professional** - Use gradients purposefully, not everywhere
2. **Generous Spacing** - Let content breathe
3. **Clear Hierarchy** - Use size and weight to guide attention
4. **Subtle Shadows** - Prefer light shadows over heavy borders
5. **Purposeful Animation** - Enhance UX, don't distract
6. **Accessible First** - Design for everyone from the start

## 🎯 When to Use What

### Gradients
- ✅ Hero sections
- ✅ Large backgrounds
- ✅ Feature headers
- ❌ Small buttons
- ❌ Text fields
- ❌ Tiny elements

### Cards
- ✅ Grouped content
- ✅ Clickable items
- ✅ Form containers
- ✅ Metric displays

### Badges
- ✅ Status indicators
- ✅ Small labels
- ✅ Count indicators
- ❌ Primary actions

## 📱 Device Testing

Test on:
- [ ] iPhone SE (small screen)
- [ ] iPhone 15 (standard)
- [ ] iPhone 15 Pro Max (large)
- [ ] iPad (tablet layout)

Test with:
- [ ] Light mode
- [ ] Dark mode
- [ ] Dynamic Type at different sizes
- [ ] VoiceOver
- [ ] Reduce Motion

## 🔗 Resources

- Template: `templates/LoginView.swift` - Complete login screen
- Template: `templates/DashboardView.swift` - Metrics dashboard
- Main Guide: `SKILL.md` - Full design system documentation
