//
//  FestivalDescriptionTableViewCell.swift
//  FestFriend02
//
//  Created by MySoftheaven BD on 11/10/18.
//  Copyright © 2018 MySoftheaven BD. All rights reserved.
//

import UIKit
import SimpleImageViewer

class FestivalDescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var container: UIStackView!
    @IBOutlet weak var lblArtistHeader: UILabel!
    @IBOutlet weak var lblArtists: UILabel!
    @IBOutlet weak var lblGenresHeader: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    
    var delegate: FestivalDetailsDelegate!
    var configuration: ImageViewerConfiguration!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configuration = ImageViewerConfiguration { (config) in
            config.imageView = imgPoster
        }
        
        let posterTapGesture = UITapGestureRecognizer(target: self, action: #selector(imgPosterAction(_:)))
        imgPoster.addGestureRecognizer(posterTapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func imgPosterAction(_ sender: UITapGestureRecognizer) {
        let imageViewerVC = ImageViewerController(configuration: configuration)
        delegate.posterImgClicked(viewer: imageViewerVC)
    }
    
}
