import SwiftUI

enum RowIcon: String {
    case appIcon = "app"
    case language = "globe"
    case rate = "star"
    case share = "square.and.arrow.up"
    case privacy = "lock"
    case terms = "document"

    var image: Image {
        Image(systemName: rawValue)
    }
}

extension Label where Title == Text, Icon == Image {
    init(_ title: LocalizedStringKey, icon: RowIcon) {
        self.init(title: { Text(title) }, icon: { icon.image })
    }
}
