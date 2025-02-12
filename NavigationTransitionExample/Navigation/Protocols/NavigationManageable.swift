import Foundation

protocol NavigationManageable: AnyObject {
    var route: [Route] { get set }
    func push(_ destination: Route)
    func pop()
    func popToRoot()
}

extension NavigationManageable {
    func push(_ destination: Route) {
        route.append(destination)
    }
    
    func pop() {
        guard !route.isEmpty else { return }
        route.removeLast()
    }
    
    func popToRoot() {
        route.removeAll()
    }
}
