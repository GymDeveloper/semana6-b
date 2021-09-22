//
//  WantedViewMode.swift
//  semana6-b
//
//  Created by Linder Hassinger on 22/09/21.
//

import Foundation

class AnimeViewModel {
    
    let urlAPI: String = "https://api.jikan.moe/v3/search/anime?q=naruto"
    
    var refeshData = {
        () -> () in
    }
    
    var dataArrayAnimes: [Results] = [] {
        didSet {
            refeshData()
        }
    }
    
    func getWantedPeople() {
        guard let url = URL(string: urlAPI) else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            guard let dataJSON = data else { return }
            
            do {
                let decoder = JSONDecoder()
                
                let wanteds = try decoder.decode(Animes.self, from: dataJSON)
                
                self.dataArrayAnimes = wanteds.results
         
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}
