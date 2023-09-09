//
//  MainResponses.swift
//  GamesMVVM
//
//  Created by Cenk Bahadır Çark on 10.09.2023.
//

import Foundation

struct GamesResponseModelElement: Codable {
    let id: Int?
    let title: String?
    let thumbnail: String?
    let shortDescription: String?
    let gameURL: String?
    let genre: Genre?
    let platform: Platform?
    let publisher, developer, releaseDate: String?
    let profileURL: String?

    enum CodingKeys: String, CodingKey {
        case id, title, thumbnail
        case shortDescription = "short_description"
        case gameURL = "game_url"
        case genre, platform, publisher, developer
        case releaseDate
        case profileURL
    }
}

enum Genre: String, Codable {
    case actionRPG = "Action RPG"
    case arpg = "ARPG"
    case battleRoyale = "Battle Royale"
    case cardGame = "Card Game"
    case fantasy = "Fantasy"
    case fighting = "Fighting"
    case genreMMORPG = " MMORPG"
    case mmo = "MMO"
    case mmoarpg = "MMOARPG"
    case mmofps = "MMOFPS"
    case mmorpg = "MMORPG"
    case moba = "MOBA"
    case racing = "Racing"
    case shooter = "Shooter"
    case social = "Social"
    case sports = "Sports"
    case strategy = "Strategy"
}

enum Platform: String, Codable {
    case pcWindows = "PC (Windows)"
    case pcWindowsWebBrowser = "PC (Windows), Web Browser"
    case webBrowser = "Web Browser"
}
