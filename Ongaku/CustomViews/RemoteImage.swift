//
//  RemoteImage.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

struct RemoteImage: View {

  @ObservedObject var remoteImageModel: RemoteImageModel

  var placeholderImageURL: String

  init(for URLString: String, withPlaceholderImageURL placeholderImageURL: String = "https://bit.ly/3lx16mQ") {

    remoteImageModel = RemoteImageModel(URLString: URLString)
    self.placeholderImageURL = placeholderImageURL
  }

  var body: some View {

    if remoteImageModel.image == nil {

      if remoteImageModel.noImageFound == true {

        RemoteImage(for: placeholderImageURL)
      } else {

        ProgressView()
          .withOngakuStyle(useDiscreetColors: false)
          .padding()
      }
    } else {
      
      Image(uiImage: remoteImageModel.image!)
        .resizable()
        .scaledToFill()
    }
  }
}

class RemoteImageModel: ObservableObject {

  @Published var image: UIImage?
  @Published var noImageFound: Bool = false

  var URLString: String?
  var imageCache: ImageCache = ImageCache.getImageCache()

  init(URLString: String) {

    self.URLString = URLString
    LoadImage()
  }

  private func LoadImage() {

    if LoadImageFromCache() {
      return
    }

    LoadImageFromURL()
  }

  private func LoadImageFromCache() -> Bool {

    guard let URLString = URLString else {
      return false
    }

    guard let cacheImage = imageCache.get(forKey: URLString) else {
      return false
    }

    image = cacheImage
    return true
  }

  private func LoadImageFromURL() -> Void {

    guard let URLString = URLString else {

      DispatchQueue.main.async {
        self.noImageFound = true
      }
      return
    }

    guard URLString != "" else {

      DispatchQueue.main.async {
        self.noImageFound = true
      }
      return
    }

    let task = URLSession.shared.dataTask(with: URL(string: URLString)!, completionHandler: getImageFromResponse(data: response:error:))

    task.resume()
  }

  private func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) -> Void {

    guard error == nil else {

      print(error!)
      DispatchQueue.main.async {
        self.noImageFound = true
      }
      return
    }

    guard let data = data else {

      print("Image not loaded")
      DispatchQueue.main.async {
        self.noImageFound = true
      }
      return
    }

    if let response = response as? HTTPURLResponse {

      if response.statusCode != 200 {

        DispatchQueue.main.async {
          self.noImageFound = true
        }
      }
    }

    DispatchQueue.main.async {

      guard let loadedImage = UIImage(data: data) else {
        return
      }

      self.imageCache.set(forKey: self.URLString!, image: loadedImage)
      self.image = loadedImage
    }
  }
}

#Preview {
//  RemoteImage(for: "https://imageio.forbes.com/specials-images/imageserve/6564ebe53ad9456b10c8e3c8/kendall-jenner-by-jamel-toppin-for-forbes-127-header/0x0.jpg?format=jpg&height=2700&width=2160")

  RemoteImage(for: "https://assets.vogue.in/photos/64b64292ee82e0e973db970d/3:4/w_2240,c_limit/L'Oreal%20Paris%20Kendall%20Jenner%20.jpg")
    .ignoresSafeArea(.all)
}
