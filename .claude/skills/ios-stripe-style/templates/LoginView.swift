import SwiftUI

/// Example login view using Stripe design system
/// Features animated gradient background, branded components, and accessible form design
struct StripeLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String? = nil

    var body: some View {
        ZStack {
            // Animated gradient background
            StripeAnimatedGradient()

            ScrollView {
                VStack(spacing: StripeSpacing.xl) {
                    Spacer()
                        .frame(height: StripeSpacing.xxxl)

                    // Hero section
                    VStack(spacing: StripeSpacing.md) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.white)

                        Text("Welcome back")
                            .font(StripeTypography.largeTitle)
                            .foregroundColor(.white)

                        Text("Sign in to continue")
                            .font(StripeTypography.callout)
                            .foregroundColor(.white.opacity(0.8))
                    }

                    // Login card
                    StripeCard {
                        VStack(spacing: StripeSpacing.lg) {
                            VStack(spacing: StripeSpacing.md) {
                                StripeTextField(
                                    label: "Email",
                                    text: $email,
                                    placeholder: "you@example.com"
                                )
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)

                                StripeTextField(
                                    label: "Password",
                                    text: $password,
                                    placeholder: "Enter your password",
                                    errorMessage: errorMessage
                                )
                                .textContentType(.password)
                            }

                            StripeButton(
                                title: "Sign in",
                                action: handleLogin,
                                isLoading: isLoading
                            )

                            Button("Forgot password?") {
                                // Handle forgot password
                            }
                            .font(StripeTypography.subheadline)
                            .foregroundColor(StripeColors.brandPurple)
                        }
                    }
                    .padding(.horizontal, StripeSpacing.lg)

                    // Sign up section
                    HStack(spacing: StripeSpacing.xs) {
                        Text("Don't have an account?")
                            .font(StripeTypography.subheadline)
                            .foregroundColor(.white.opacity(0.8))

                        Button("Sign up") {
                            // Handle sign up
                        }
                        .font(StripeTypography.subheadline)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    }

                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }

    private func handleLogin() {
        // Dismiss keyboard
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )

        isLoading = true
        errorMessage = nil

        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            // Handle login logic here
        }
    }
}

#Preview {
    StripeLoginView()
}
