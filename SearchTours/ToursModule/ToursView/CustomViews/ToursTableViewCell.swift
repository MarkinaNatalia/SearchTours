//
//  ToursTableViewCell.swift
//  SearchTours
//
//  Created by Наталья on 05.03.2024.
//

import UIKit

final class ToursTableViewCell: UITableViewCell {
    
    // MARK: UI components
    
    private lazy var imageHotel               = createHotelImageView()
    private lazy var ratingView               = createRatingStackView()
    private lazy var nameLabel                = createNameHotelLabel()
    private lazy var lineTagLabel             = TagItemLabel(leftInset: 8, topInset: 4, rightInset: 8, bottomInset: 4)
    private lazy var distanceBeachTagLabel    = TagItemLabel(leftInset: 8, topInset: 4, rightInset: 8, bottomInset: 4)
    private lazy var freeWifiTagLabel         = TagItemLabel(leftInset: 8, topInset: 4, rightInset: 8, bottomInset: 4)
    private lazy var tagsView                 = createTagsStackView()
    private lazy var datesLabel               = createDatesLabel()
    private lazy var priceLabel               = createPriceLabel()

    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup settings
    
    private func setupSettings() {
        selectionStyle = .none
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        backgroundColor = .clear
        
        addSubviews()
        addConstraints()
    }
    
    // MARK: Reuse cell
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageHotel.image = nil
        imageHotel.cancelImageLoad()
        
        nameLabel.text = ""
        datesLabel.text = ""
        priceLabel.text = ""
        lineTagLabel.text = ""
        distanceBeachTagLabel.text = ""
        lineTagLabel.text = ""
        
        ratingView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: Updating data
    
    func updateData(tour: TourModel) {
        nameLabel.text = tour.originalName ?? ""
        lineTagLabel.text = .tours(.lineTitle)
        distanceBeachTagLabel.text = .tours(.distanceBeachrTitle)
        freeWifiTagLabel.text = .tours(.freeWifiTitle)
        priceLabel.text = .tours(.priceText(price: tour.price.total,
                                            adultsCount: tour.adults,
                                            kidsCount: tour.kids))
        updateRating()
    }
    
    func loadHotelImage(url: String) {
        imageHotel.loadImage(imageUrl: url)
    }
    
    func updateDates(departureDate: Date?, nightsCount: Int?) {
        guard let departureDate = departureDate,
              let nightsCount = nightsCount,
              let arrivalDate = Calendar.current.date(byAdding: .day, value: nightsCount, to: departureDate) 
        else { return }
        
        updateDatesLabel(departureDate: .tours(.departureDateTitle(date: departureDate)),
                         arrivalDate: .tours(.arrivalDateTitle(date: arrivalDate)),
                         nightsCount: nightsCount)
    }
    
    // MARK: Private functions
    
    private func addSubviews() {
        contentView.addSubview(imageHotel)
        contentView.addSubview(ratingView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(tagsView)
        contentView.addSubview(datesLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageHotel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageHotel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            imageHotel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            imageHotel.heightAnchor.constraint(equalToConstant: 160),
            
            ratingView.topAnchor.constraint(equalTo: imageHotel.bottomAnchor, constant: 8),
            ratingView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            ratingView.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -16),
            
            nameLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            tagsView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            tagsView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            tagsView.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -16),
            tagsView.heightAnchor.constraint(equalToConstant: 24),
            
            datesLabel.topAnchor.constraint(equalTo: tagsView.bottomAnchor, constant: 8),
            datesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            datesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: datesLabel.bottomAnchor, constant: 16),
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func updateRating() {
        let starsCount = Int.random(in: 1...5)
        
        for _ in 0..<starsCount {
            let starImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
            starImageView.contentMode = .scaleAspectFit
            starImageView.clipsToBounds = true
            starImageView.image = .pngImage(.starIcon)
            
            ratingView.addArrangedSubview(starImageView)
        }
    }
    
    private func updateDatesLabel(departureDate: String, arrivalDate: String, nightsCount: Int) {
        let titleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.customColor(.grayColor),
            NSAttributedString.Key.font: UIFont.customFont(.medium, size: 14)
        ]
        let valueAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.customColor(.darkGreenColor),
            NSAttributedString.Key.font: UIFont.customFont(.semiBold, size: 14)
        ]
        
        let datesString = NSMutableAttributedString(string: .tours(.departureDateTourTitle), 
                                                    attributes: titleAttributes)
        let departureDateValueString = NSAttributedString(string: departureDate, 
                                                          attributes: valueAttributes)
        let arrivalDateTitleString = NSAttributedString(string: .tours(.arrivalDateTourTitle),
                                                        attributes: titleAttributes)
        let arrivalDateValueString = NSAttributedString(string: arrivalDate, 
                                                        attributes: valueAttributes)
        let nightsCountTitleString = NSAttributedString(string: .tours(.nightsCountTourTitle),
                                                        attributes: titleAttributes)
        let nightsCountValueString = NSAttributedString(string: .tours(.nightsCountValue(count: nightsCount)),
                                                        attributes: valueAttributes)

        datesString.append(departureDateValueString)
        datesString.append(arrivalDateTitleString)
        datesString.append(arrivalDateValueString)
        datesString.append(nightsCountTitleString)
        datesString.append(nightsCountValueString)
        
        datesLabel.attributedText = datesString
    }
    
    // MARK: Creating UI components
    
    private func createHotelImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14
        return imageView
    }
    
    private func createRatingStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 1
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    
    private func createNameHotelLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.extraBold, size: 18)
        label.textColor = .customColor(.nameHotelColor)
        return label
    }
    
    private func createTagsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 8
        
        stackView.addArrangedSubview(lineTagLabel)
        stackView.addArrangedSubview(distanceBeachTagLabel)
        stackView.addArrangedSubview(freeWifiTagLabel)
        return stackView
    }
    
    private func createDatesLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.medium, size: 18)
        label.textColor = .customColor(.grayColor)
        return label
    }
    
    private func createPriceLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.extraBold, size: 20)
        label.textColor = .customColor(.priceTourColor)
        return label
    }
}
