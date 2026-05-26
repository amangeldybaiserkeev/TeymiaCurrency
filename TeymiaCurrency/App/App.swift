import SwiftUI

@main
struct TeymiaCurrencyApp: App {
    @AppStorage("Theme") private var theme: Theme = .system
    @State private var container: DIContainer
    @State private var vm: CurrencyListViewModel

    init() {
        NavigationAppearance.configureFonts()

        let container = DIContainer()
        let vm = container.makeConverterViewModel()

        _container = State(initialValue: container)
        _vm = State(initialValue: vm)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CurrencyListView(vm: vm)
                    .preferredColorScheme(theme.colorScheme)
                    .fontDesign(.rounded)
                    .tint(.accent)
                    .environment(container)
            }
        }
    }
}
