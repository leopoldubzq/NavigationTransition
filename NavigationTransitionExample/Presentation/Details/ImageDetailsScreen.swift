import SwiftUI

struct ImageDetailsScreen: View {
    
    let hero: Hero
    
    @State private var offsetY: CGFloat = .zero
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeAreaInsets = $0.safeAreaInsets
            ScrollView {
                VStack {
                    image(with: size)
                    VStack(spacing: 16) {
                        Text(hero.description)
                            .foregroundStyle(.secondary)
                        Text("Portfolio pictures")
                            .font(.title2)
                            .bold()
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 24) {
                                ForEach(Hero.portfolioPicturesMock, id: \.self) { picture in
                                    Image(picture)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 250)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .scrollTransition { content, phase in
                                            content
                                                .opacity(phase.isIdentity ? 1 : 0.7)
                                                .blur(radius: phase.isIdentity ? 0 : 2)
                                                .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                        }
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollClipDisabled()
                        .scrollIndicators(.hidden)
                        .scrollTargetBehavior(.viewAligned)
                    }
                    .padding()
                }
                .padding(.bottom, safeAreaInsets.bottom)
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                    }
                    .tint(colorScheme == .light ? (offsetY > 15 ? .black : .white) : .white)
                    .fontWeight(.semibold)
                    .animation(.easeIn(duration: 0.1), value: offsetY)
                    Spacer()
                }
                .overlay {
                    Text(hero.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .animation(.easeIn(duration: 0.1), value: offsetY)
                        .frame(height: 45)
                        .opacity(min(1, max(0, offsetY * 0.08)))
                }
                .padding([.horizontal, .bottom])
                .padding(.top, 8)
                .background(
                    Rectangle()
                        .fill(colorScheme == .dark ? .ultraThinMaterial : .thinMaterial)
                        .opacity(offsetY > 0 ? min(1, offsetY * 0.08) : 0.001)
                        .contentShape(Rectangle())
                        .ignoresSafeArea()
                )
            }
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                geometry.contentOffset.y
            } action: { _, offsetY in
                self.offsetY = offsetY
            }

        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func image(with size: CGSize) -> some View {
        GeometryReader { proxy in
            Image(hero.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height + max(0, -offsetY)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .contentShape(.rect)
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
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .offset(y: min(0, offsetY))
        }
        .frame(
            width: size.width,
            height: size.height * 0.7
        )
    }
}

#Preview {
    ImageDetailsScreen(hero: Hero.mock)
}
