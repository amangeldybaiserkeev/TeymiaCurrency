import SwiftUI

struct CurrencyBadge: View {
    let currency: Currency
    var iconName: String? = nil

    private let iconSize = IconSize.xl
    private var icon: String { iconName ?? currency.code }

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: iconSize, height: iconSize)
                .clipShape(.circle)
                .overlay(
                    Circle()
                        .stroke(.secondary.opacity(0.2), lineWidth: 0.5)
                )

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(currency.code)
                    .font(.headline)
                    .fontWeight(.semibold)

                Text(currency.name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
    }
}
