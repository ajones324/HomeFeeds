//
//  ImageCell.swift
//  HomeFeeds
//
//  Created by Andrew Ikenna Jones on 1/12/23.
//

import UIKit

final class FeedCardCell: UITableViewCell {
    var card: Card! {
        didSet {
            switch card.cardType {
                
            case .text:
                switch card.card {
                case .singleText(let text):
                    self.renderTextCard(text: text)
                    return
                case .multi(_):
                    return
                }
            case .titleDescription:
                switch card.card {
                case .singleText(_):
                    return
                case .multi(let element):
                    self.renderTileDescCard(element: element)
                    return
                }
            case .imageTitleDescription:
                switch card.card {
                case .singleText(_):
                    return
                case .multi(let element):
                    self.renderImageCard(element: element)
                    return
                }
            case .other:
                return
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func renderTextCard(text: TextElement) {
        if !stackView.arrangedSubviews.isEmpty { return }
        let textLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(hexString: text.attributes.textColor)
            label.font = UIFont.systemFont(ofSize: text.attributes.font.size)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        textLabel.text = text.value
        stackView.addArrangedSubview(textLabel)
        
        let space: UIView = {
            let space = UIView()
            NSLayoutConstraint.activate([
                space.heightAnchor.constraint(equalToConstant: 20)
            ])
            space.translatesAutoresizingMaskIntoConstraints = false
            return space
        }()
        stackView.addArrangedSubview(space)
    }
    
    private func renderTileDescCard(element: CombinedElements) {
        if !stackView.arrangedSubviews.isEmpty { return }
        
        guard let title = element.title else { return }
        let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(hexString: title.attributes.textColor)
            label.font = UIFont.systemFont(ofSize: title.attributes.font.size)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        titleLabel.text = title.value
        stackView.addArrangedSubview(titleLabel)
        
        guard let desc = element.description else { return }
        let descLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(hexString: desc.attributes.textColor)
            label.font = UIFont.systemFont(ofSize: desc.attributes.font.size)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        descLabel.text = desc.value
        stackView.addArrangedSubview(descLabel)
        
        let space: UIView = {
            let space = UIView()
            NSLayoutConstraint.activate([
                space.heightAnchor.constraint(equalToConstant: 20)
            ])
            space.translatesAutoresizingMaskIntoConstraints = false
            return space
        }()
        stackView.addArrangedSubview(space)
    }
    
    private func renderImageCard(element: CombinedElements) {
        if !stackView.arrangedSubviews.isEmpty { return }
        guard let image = element.image else { return }
        
        let imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        imageView.loadImageURL(url: URL(string: image.url)!)
        let width = UIScreen.main.bounds.width
        let height = width * image.size.height / image.size.width
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        guard let title = element.title else { return }
        let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(hexString: title.attributes.textColor)
            label.font = UIFont.systemFont(ofSize: title.attributes.font.size)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        titleLabel.text = title.value
        
        guard let desc = element.description else { return }
        let descLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(hexString: desc.attributes.textColor)
            label.font = UIFont.systemFont(ofSize: desc.attributes.font.size)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        descLabel.text = desc.value
        
        lazy var textStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, descLabel])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        imageView.addSubview(textStackView)
        stackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            textStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
        ])
        
        let space: UIView = {
            let space = UIView()
            NSLayoutConstraint.activate([
                space.heightAnchor.constraint(equalToConstant: 20)
            ])
            space.translatesAutoresizingMaskIntoConstraints = false
            return space
        }()
        stackView.addArrangedSubview(space)
    }
    
    private func commonInit() {
        backgroundColor = .white
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}

