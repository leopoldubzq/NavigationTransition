import SwiftUI

final class NavigationManager: NavigationManageable & ObservableObject {
    @Published var route: [Route] = []
}
