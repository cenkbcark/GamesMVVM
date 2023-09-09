//
//  GameCell.swift
//  GamesVIPER
//
//  Created by Cenk Bahadır Çark on 5.09.2023.
//

import UIKit

final class GameCell: UICollectionViewCell {

    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var gameTitleLabel: UILabel!
    @IBOutlet weak private var gameDescriptionLabel: UILabel!
    @IBOutlet weak private var gameImageView: UIImageView!
    @IBOutlet weak private var gameGenreLabel: UILabel!
    @IBOutlet weak private var goButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    func setModels(_ model: GamesResponseModelElement?) {
        guard let model = model else { return }
        gameTitleLabel.text = model.title
        gameDescriptionLabel.text = model.shortDescription
        gameGenreLabel.text = model.developer
        
        guard let thumbnail = model.thumbnail else { return }
        ImageDownloader.downloadImage(from: thumbnail) { image in
            DispatchQueue.main.async {
                self.gameImageView.image = image
            }
        }
    }
    
    private func configureCell() {
        containerView.layer.cornerRadius = 30
        gameImageView.layer.cornerRadius = 30
        goButton.layer.cornerRadius = goButton.frame.height / 2
        goButton.layer.borderWidth = 3
        goButton.layer.borderColor = UIColor.white.cgColor
    }
}
//MARK: - FOR TEST
final class ImageCache {
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}

final class ImageDownloader {
    static func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            // Return cached image if available
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let downloadedImage = UIImage(data: data) {
                ImageCache.shared.setImage(downloadedImage, forKey: urlString)
                completion(downloadedImage)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
