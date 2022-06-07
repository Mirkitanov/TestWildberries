//
//  CheapListCollectionViewCell.swift
//  WildberriesTest
//
//  Created by Админ on 07.06.2022.
//

import UIKit

class CheapListCollectionViewCell: UICollectionViewCell {
    
    //Перелет
    var flight: Flight? {
        didSet {
            cellLoyoutRefresh()
        }
    }
    
    private func cellLoyoutRefresh(){
        // Защита тела метода
        // Перелет задан?
        guard let flight = flight else { return }
        
        let customFormatter = CustomDateFormatter()
        
        startCityLabel.text = flight.startCity
        endCityLabel.text = flight.endCity
        startDateLabel.text = customFormatter.convertToDateAndTimeString(from: flight.startDate)
        endDateLabel.text = customFormatter.convertToDateAndTimeString(from: flight.endDate)
        priceLabel.text = "\(flight.price) ₽"
        
        if flight.like == false{
            likeImageView.image = UIImage(systemName: "heart")
        }
        for likeToken in likeStorage.idArray{
            if flight.searchToken == likeToken {
                likeImageView.image = UIImage(systemName: "heart.fill")
                break
            }
        }
        
    }
    
    private let startCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let endCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .brown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .brown
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let repeatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "repeat")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let departureFlightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .blue
        label.text = "Туда:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let returnFlightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .blue
        label.text = "Обратно:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        contentView.backgroundColor = .white
        contentView.roundCornersWithRadius(12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        contentView.addSubviews(startCityLabel,
                                repeatImageView,
                                endCityLabel,
                                departureFlightLabel,
                                returnFlightLabel,
                                startDateLabel,
                                endDateLabel,
                                priceLabel,
                                likeImageView
        )
        
        let constraints = [
            
            startCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            startCityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            repeatImageView.bottomAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: -3),
            repeatImageView.leadingAnchor.constraint(equalTo: startCityLabel.trailingAnchor, constant: 5),
            repeatImageView.widthAnchor.constraint(equalToConstant: 20),
            repeatImageView.heightAnchor.constraint(equalToConstant: 15),

            endCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            endCityLabel.leadingAnchor.constraint(equalTo: repeatImageView.trailingAnchor, constant: 5),

            departureFlightLabel.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: 20),
            departureFlightLabel.leadingAnchor.constraint(equalTo: startCityLabel.leadingAnchor, constant: 0),

            returnFlightLabel.topAnchor.constraint(equalTo: departureFlightLabel.bottomAnchor, constant: 8),
            returnFlightLabel.leadingAnchor.constraint(equalTo: startCityLabel.leadingAnchor, constant: 0),

            startDateLabel.bottomAnchor.constraint(equalTo: departureFlightLabel.bottomAnchor, constant: 0),
            startDateLabel.leadingAnchor.constraint(equalTo: returnFlightLabel.trailingAnchor, constant: 5),

            endDateLabel.bottomAnchor.constraint(equalTo: returnFlightLabel.bottomAnchor, constant: 0),
            endDateLabel.leadingAnchor.constraint(equalTo: returnFlightLabel.trailingAnchor, constant: 5),

            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            likeImageView.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: -3),
            likeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            likeImageView.widthAnchor.constraint(equalToConstant: 30),
            likeImageView.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

