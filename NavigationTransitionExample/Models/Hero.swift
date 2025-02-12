import Foundation

struct Hero: Hashable {
    let id = UUID()
    let name: String
    let imageName: String
    let description: String
}

extension Hero {
    static var mock: Hero {
        .init(
            name: "SPIDER-MAN",
            imageName: "peter_parker_1",
            description: "Just your friendly neighborhood Spider-Man! 🕷️ Swinging through life one web at a time. By day, I’m a photographer and student 📸, but when duty calls, I’m out there keeping the city safe. I love science, bad puns, and stopping bad guys. Looking for someone to share a slice of pizza 🍕 and a good conversation about superheroes."
        )
    }
    
    static var portfolioPicturesMock: [String] {
        var array: [String] = []
        for i in 2...5 {
            array.append("peter_parker_\(i)")
        }
        return array
    }
}
