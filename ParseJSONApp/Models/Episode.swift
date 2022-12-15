
struct Episode: Decodable {
    let data: Data
}

struct Data: Decodable {
    let id: Int
    let name: String
    let season: Int
    let episode: Int
    let air_date: String
    let thumbnail_url: String
    let description: String
    let characters: [String]
    let locations: [String]
}
