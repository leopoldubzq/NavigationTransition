import SwiftUI

struct MainScreen: View {
    
    @StateObject private var navigationManager = NavigationManager()
    @Namespace private var heroDetailsNamespace
    
    private let hero = Hero.mock
    
    var body: some View {
        NavigationStack(path: $navigationManager.route) {
            GeometryReader {
                let size = $0.size
                VStack {
                    Image(hero.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width * 0.8, height: size.height * 0.6)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [
                                        Color(.black).opacity(0.6),
                                        Color(.black).opacity(0.5),
                                        Color(.black).opacity(0.4),
                                        Color(.black).opacity(0.2),
                                        Color(.black).opacity(0.1)
                                    ], startPoint: .bottom, endPoint: .center)
                                )
                        }
                        .overlay(alignment: .bottomLeading) {
                            Text(hero.name)
                                .font(.title)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                        .contentShape(.rect)
                        .matchedTransitionSource(id: hero.id, in: heroDetailsNamespace)
                        .onTapGesture {
                            navigationManager.push(.details(hero: hero))
                        }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
            }
            .navigationDestination(for: Route.self) { destination in
                switch destination {
                case .details(let hero):
                    ImageDetailsScreen(hero: hero)
                        .navigationTransition(
                            .zoom(
                                sourceID: hero.id,
                                in: heroDetailsNamespace
                            )
                        )
                }
            }
        }
    }
}

#Preview {
    MainScreen()
}
