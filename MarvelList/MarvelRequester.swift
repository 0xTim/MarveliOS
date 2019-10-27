//
//  MarvelRequester.swift
//  MarvelList
//
//  Created by Tim Condon on 24/10/2019.
//  Copyright © 2019 Tim Condon. All rights reserved.
//

import Foundation

struct MarvelRequester {
    let publicKey = "889f4337d51d90ee30c6937ff2c441c6"
    let privateKey = "783172bf871b91753a790d7b323a0615225ae3d6"
    let marvelGateway = "https://gateway.marvel.com/v1/public/"
    
    func getHeroes(offset: Int, completion: @escaping ((HeroesResponse) -> Void)) {
        var urlComponent = URLComponents(string: marvelGateway)!
        urlComponent.path += "characters"
        let timestamp = UUID().uuidString
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5()
        urlComponent.queryItems = [
            URLQueryItem(name: "limit", value: "30"),
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        
        let urlRequest = URLRequest(url: urlComponent.url!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure)
                return
            }
            do {
                let response = try JSONDecoder().decode(CharacterResponse.self, from: jsonData)
                completion(.success(response.data.results))
            } catch {
                completion(.failure)
                return
            }
        }
        dataTask.resume() // asynchronous vs synchronous
    }
}

enum HeroesResponse {
    case failure
    case success([Character])
}


import CryptoKit

extension String {
    func md5() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
