import SwiftUI

@main
struct TeymiaCurrencyApp: App {
    @AppStorage("Theme") private var theme: Theme = .system
    @State private var container: AppContainer
    @State private var vm: ConverterViewModel

    init() {
        let container = AppContainer()
        let vm = container.makeConverterViewModel()

        _container = State(initialValue: container)
        _vm = State(initialValue: vm)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView(vm: vm)
                    .preferredColorScheme(theme.colorScheme)
                    .fontDesign(.rounded)
                    .tint(.accentColor)
                    .environment(container)
            }
        }
    }
}
