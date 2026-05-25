import SwiftUI

struct CurrencySection: Identifiable {
    let id: String
    let letter: String
    let currencies: [Currency]
}

struct CurrencySelectionView: View {
    @State private var selectedType: CurrencyType = .fiat
    @State private var searchText = ""

    let vm: ConverterViewModel
    private let pickerWidth: CGFloat = 200

    var body: some View {
        let currentSections = vm.buildSections(searchText: searchText, selectedType: selectedType)

        ScrollViewReader { proxy in
            ZStack(alignment: .trailing) {
                if currentSections.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                        .padding(.top, Spacing.xxl)
                } else {
                    List {
                        ForEach(currentSections) { section in
                            Section(section.letter) {
                                ForEach(section.currencies) { currency in
                                    CurrencySelectionRowView(
                                        currency: currency,
                                        isSelected: vm.selectedCurrencies.contains(where: { $0.code == currency.code }),
                                        onTap: { vm.toggleCurrency(currency) }
                                    )
                                }
                            }
                            .id(section.letter)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(.plain)
                    .padding(.trailing, searchText.isEmpty ? Spacing.sm : 0)

                    if searchText.isEmpty {
                        SectionIndexTitles(proxy: proxy, titles: currentSections.map(\.letter))
                            .frame(maxHeight: .infinity, alignment: .center)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .adaptiveSearchable(text: $searchText)
        .toolbar { toolbarContent }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        CloseToolbarButton()

        ToolbarItem(placement: .principal) {
            Picker("", selection: $selectedType) {
                Text("Fiat").tag(CurrencyType.fiat)
                Text("Crypto").tag(CurrencyType.crypto)
            }
            .pickerStyle(.segmented)
            .frame(width: pickerWidth)
        }
    }
}

private struct SectionIndexTitles: View {
    let proxy: ScrollViewProxy
    let titles: [String]

    @State private var currentTitle: String? = nil
    private let itemSize: CGFloat = 14

    var body: some View {
        VStack(spacing: 0) {
            ForEach(titles, id: \.self) { title in
                Text(title)
                    .font(.system(size: IconSize.xxs, weight: .medium))
                    .frame(height: itemSize)
            }
        }
        .background(.clear)
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { value in
                    let index = Int(value.location.y / itemSize)
                        .clamped(to: 0...(titles.count - 1))
                    let title = titles[index]
                    if title != currentTitle {
                        currentTitle = title
                        proxy.scrollTo(title, anchor: .top)
                    }
                }
                .onEnded { _ in
                    currentTitle = nil
                }
        )
        .sensoryFeedback(.selection, trigger: currentTitle)
        .frame(width: itemSize)
    }
}

private struct CurrencySelectionRowView: View {
    let currency: Currency
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                CurrencyBadge(currency: currency, iconName: currency.iconName)

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(isSelected ? .primary : .tertiary)
                    .contentTransition(.symbolEffect(.replace))
            }
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: isSelected)
    }
}

private extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

private extension View {
    @ViewBuilder
    func adaptiveSearchable(text: Binding<String>) -> some View {
        if #available(iOS 26.0, *) {
            self
                .searchable(text: text, placement: .automatic)
        } else {
            self
                .searchable(text: text, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
