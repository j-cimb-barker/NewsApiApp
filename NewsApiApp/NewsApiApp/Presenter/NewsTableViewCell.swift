//
//  NewsTableViewCell.swift
//  NewsApiApp
//
//  Created by Josh Barker on 08/12/2020.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var headingLabel: UILabel!
    
    @IBOutlet var contentLabel: UILabel!
    
    @IBOutlet var storyImgView: UIImageView!
    
    @IBOutlet var byLineLabel: UILabel!
    
    @IBOutlet var sourceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate (article: Article) {

        self.headingLabel.text = article.title
        self.contentLabel.text = article.content
        
        self.byLineLabel.text = article.pubDate.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        self.byLineLabel.text = dateFormatter.string(from: article.pubDate)
        self.sourceLabel.text = article.source
        
        if article.imageUrl != nil {
            self.setStoryImageUrl(url: article.imageUrl!)
        }
    }
    
    func setStoryImageUrl (url: URL) {
        
        self.storyImgView.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
            
            
        })
        
    }
    
}
