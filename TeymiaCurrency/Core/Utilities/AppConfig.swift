import Foundation

enum AppConfig {
    static let appStoreURL = createURL("https://apps.apple.com/app/id6752235997")
    static let rateAppURL = createURL("https://apps.apple.com/app/id6752235997?action=write-review")
    static let privacyURL = createURL("https://www.notion.so/Privacy-Policy-267d5178e65a8017ad5afda2e3f004fc")
    static let termsURL = createURL("https://www.notion.so/Terms-of-Service-267d5178e65a804a9e80d8660c798b57")

    private static func createURL(_ string: String) -> URL {
        URL(string: string)!
    }
}
