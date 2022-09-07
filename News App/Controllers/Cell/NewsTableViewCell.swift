//
//  NewsTableViewCell.swift
//  News App
//
//  Created by Baris on 7.09.2022.
//

import UIKit

//MARK: - NewsTableViewCell Model
class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    var imageURL : URL?
    let imageData: Data? = nil
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?
        ) {
            
            self.title = title
            self.subtitle = subtitle
            self.imageURL = imageURL
        }
}

//MARK: - TableViewCell Properties
class NewsTableViewCell: UITableViewCell {
    
    //NewsTableViewCell identifier
    static let identifier = "NewsTableViewCell"
    
    //MARK: -UI Elements
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 23, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.tintColor = .systemGray
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    
    private let newsImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
        
    //MARK: -Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    //Life Cycle Error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsTitleLabel.frame = CGRect(x: 15, y: 0, width: contentView.frame.size.height + 50, height: 70)
        subtitleLabel.frame = CGRect(x: 15, y: 65, width: contentView.frame.size.height + 50, height: 70)
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 160, y: 5, width: 140, height: contentView.frame.size.height - 10 )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    //MARK: - Functions
    //Get data
    func configure(with viewModel: NewsTableViewCellViewModel ) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { data, _, error in                guard data == data, error == nil else  {
                return
            }
                     DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data!)
                }

            }.resume()
        }
    }
}
