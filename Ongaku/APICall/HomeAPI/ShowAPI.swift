//
//  ShowAPI.swift
//  Ongaku
//
//  Created by Ankit Yadav on 15/03/25.
//

import Foundation
import Alamofire

class ShowAPI {

  func getShow(with aToken: String, limit: Int, offset: Int,
               completionHandler: @escaping ([OngakuModel.Media]) -> Void) -> Void {

    let searchTerm = "spotify+exclusive"
    let type       = "show"
    let baseURL    = "https://api.spotify.com/v1/search?q=\(searchTerm)&type=\(type)&limit=\(limit)&offset=\(offset)"
    // ShowPageObject
    
    let URLRequest = Utility.createURLRequest(with: baseURL, accessToken: aToken)

    AF.request(URLRequest)
      .validate()
      .responseDecodable(of: ShowPageObject.self) { response in

        completionHandler(self.parseResponse(response))
      }
  }

  private func parseResponse(_ response: DataResponse<ShowPageObject, AFError>) -> [OngakuModel.Media] {

    var media: [OngakuModel.Media] = []
    let numOfShows = response.value!.shows.items.count

    for idx in 0 ..< numOfShows {
      
      if let show = response.value!.shows.items[idx] {
        
        let showID    = show.id
        let showName = show.name
        
        let imageURL      = show.images[0].url
        let publisher    = show.publisher
        let description   = show.description
        let explicit      = show.explicit
        let numOfEpisodes = show.total_episodes
        let availableMarkets = show.available_markets
        
        let showDetails = OngakuModel.Show(name: showName, description: description, explicitContent: explicit, availableCountries: availableMarkets, publisher: publisher, episodeCount: numOfEpisodes, id: showID)
        
        let podcastElem = OngakuModel.Media(title: showName, previewURL: "", imageURL: imageURL, authorName: [publisher], mediaType: .show, id: showID, details: OngakuModel.DetailTypes.shows(showDetails: showDetails))
        
        media.append(podcastElem)
      }
    }

    return media
  }
}
