//
//  CollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Mehmet Yumurtacı on 7/7/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    func setImage(state: CurrentWeatherMain?) {
        switch state {
        case .Clear:
            imageView.image = UIImage(named: "sun")
        case .Clouds, .Atmosphere:
            imageView.image = UIImage(named: "cloud")
        case .Drizzle, .Rain:
            imageView.image = UIImage(named: "rain")
        case .Snow:
            imageView.image = UIImage(named: "snow")
        case .Thunderstorm:
            imageView.image = UIImage(named: "thunderstorm")
        default:
            imageView.image = UIImage(named: "cloud")

        }
    }
    
    
}
