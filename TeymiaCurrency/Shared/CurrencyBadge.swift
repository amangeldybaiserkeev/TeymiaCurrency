import SwiftUI
import Kingfisher

struct CurrencyBadge: View {
    let currency: Currency

    private let iconSize = IconSize.xl

    var body: some View {
        HStack(spacing: Spacing.sm) {
            KFImage(currency.iconURL)
                .placeholder {
                    Circle()
//                        .fill(.secondary.opacity(0.1))
                        .frame(width: iconSize, height: iconSize)
                        .overlay {
                            Text(String(currency.code.prefix(1)))
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary.opacity(0.7))
                        }
                        .shimmer(.init())
                }
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: iconSize, height: iconSize)))
                .scaleFactor(UIScreen.main.scale)
                .cacheOriginalImage()
                .fade(duration: 0.2)
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
                    .foregroundStyle(.primary)

                Text(currency.name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
    }
}
