//
//  FlightDetailsViewController.swift
//  WildberriesTest
//
//  Created by Админ on 05.06.2022.
//

import UIKit

var likeStorage = LikeStorage()

final class FlightDetailsViewController: UIViewController {
    
    weak var flowCoordinator: CheapListCollectionCoordinator?
    
    private let scrollView = UIScrollView()
    
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
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setTitle("I LIKE IT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.darkGray, for: .selected)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let wrapperView = UIView()
    
    private var flightToDetails: Flight
    
    init(flightToDetails: Flight) {
        self.flightToDetails = flightToDetails
        super.init(nibName: nil, bundle: nil)
     
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
    }
    
    /// Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func likeButtonPressed() {
        
        if flightToDetails.like == true {
            flightToDetails.like = false
            likeImageView.image = UIImage(systemName: "heart")
        } else {
            flightToDetails.like = true
            likeImageView.image = UIImage(systemName: "heart.fill")
            likeStorage.idArray.append(flightToDetails.searchToken)
        }
    }
    
    
    private func configure() {
        let customFormatter = CustomDateFormatter()
        
        startCityLabel.text = flightToDetails.startCity
        endCityLabel.text = flightToDetails.endCity
        startDateLabel.text = customFormatter.convertToDateAndTimeString(from: flightToDetails.startDate)
        endDateLabel.text = customFormatter.convertToDateAndTimeString(from: flightToDetails.endDate)
        priceLabel.text = "\(flightToDetails.price) ₽"
        
        if flightToDetails.like == false{
            likeImageView.image = UIImage(systemName: "heart")
        }
        for likeToken in likeStorage.idArray{
            if flightToDetails.searchToken == likeToken {
                likeImageView.image = UIImage(systemName: "heart.fill")
                flightToDetails.like = true
                break
            }
        }
        
    }
    
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .automatic
        
        view.addSubview(scrollView)
        scrollView.addSubview(wrapperView)
        wrapperView.addSubviews(startCityLabel,
                                 repeatImageView,
                                 endCityLabel,
                                 departureFlightLabel,
                                 returnFlightLabel,
                                 startDateLabel,
                                 endDateLabel,
                                 priceLabel,
                                 likeImageView,
                                 likeButton
         )
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            wrapperView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            wrapperView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            startCityLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 12),
            startCityLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            
            repeatImageView.bottomAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: -3),
            repeatImageView.leadingAnchor.constraint(equalTo: startCityLabel.trailingAnchor, constant: 5),
            repeatImageView.widthAnchor.constraint(equalToConstant: 20),
            repeatImageView.heightAnchor.constraint(equalToConstant: 15),

            endCityLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 12),
            endCityLabel.leadingAnchor.constraint(equalTo: repeatImageView.trailingAnchor, constant: 5),

            departureFlightLabel.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: 20),
            departureFlightLabel.leadingAnchor.constraint(equalTo: startCityLabel.leadingAnchor, constant: 0),

            returnFlightLabel.topAnchor.constraint(equalTo: departureFlightLabel.bottomAnchor, constant: 8),
            returnFlightLabel.leadingAnchor.constraint(equalTo: startCityLabel.leadingAnchor, constant: 0),

            startDateLabel.bottomAnchor.constraint(equalTo: departureFlightLabel.bottomAnchor, constant: 0),
            startDateLabel.leadingAnchor.constraint(equalTo: returnFlightLabel.trailingAnchor, constant: 5),

            endDateLabel.bottomAnchor.constraint(equalTo: returnFlightLabel.bottomAnchor, constant: 0),
            endDateLabel.leadingAnchor.constraint(equalTo: returnFlightLabel.trailingAnchor, constant: 5),

            priceLabel.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 10),
            priceLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor, constant: -10),

            likeImageView.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: -3),
            likeImageView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
            likeImageView.widthAnchor.constraint(equalToConstant: 30),
            likeImageView.heightAnchor.constraint(equalToConstant: 30),
            
            likeButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            likeButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 24),
            likeButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -24),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            likeButton.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension FlightDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("content offset: \(scrollView.contentOffset.y)")
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
