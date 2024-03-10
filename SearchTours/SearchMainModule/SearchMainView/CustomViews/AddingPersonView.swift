//
//  AddingPersonView.swift
//  SearchTours
//
//  Created by Наталья on 07.03.2024.
//

import UIKit
import SwiftyMenu

protocol AddingPersonViewDelegate {
    func changedPersonCount(adultsCount: Int, kidsCount: Int, kidsAges: [Int])
    func clickedDoneButton()
}

final class AddingPersonView: UIView {
    var delegateView: AddingPersonViewDelegate?
    
    private var currentAgeKid = 0
    private var ageKids: [Int] = []
    
    private var adultsCount = 1 {
        didSet { changedAdultsCount() }
    }
    private var kidsCount = 0 {
        didSet { changedKidsCount() }
    }
    
    // MARK: UI components
    
    private lazy var titleLabel               = createTitleLabel()
    private lazy var adultsCountLabel         = createAdultsCountLabel()
    private lazy var kidsCountLabel           = createKidsCountLabel()
    private lazy var imagesStack              = createImagesStack()
    private lazy var addAdultButton           = createAddAdultButton()
    private lazy var addKidButton             = createAddKidButton()
    private lazy var ageKidTitle              = createAgeKidTitle()
    private lazy var ageKidButton             = ButtonWithMenuView(elements: getAgesElements())
    private lazy var ageKidDoneButton         = createAgeKidDoneButton()
    private lazy var ageKidStackView          = createAgeKidStackView()
    private lazy var doneButton               = DoneButton()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup settings
    
    private func setupSettings() {
        backgroundColor = .customColor(.lightGrayColor)
        addSubviews()
        setupConstraints()
        addAdultInStack()
    }
    
    // MARK: Private functions
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(adultsCountLabel)
        addSubview(kidsCountLabel)
        addSubview(imagesStack)
        addSubview(addAdultButton)
        addSubview(addKidButton)
        addSubview(ageKidStackView)
        addSubview(doneButton)
        
        doneButton.addTarget(self,
                             action: #selector(doneButtonAction),
                             for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            adultsCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            adultsCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            kidsCountLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            kidsCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            imagesStack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            imagesStack.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -16),
            imagesStack.topAnchor.constraint(equalTo: adultsCountLabel.bottomAnchor, constant: 16),
            imagesStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            addAdultButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addAdultButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            addAdultButton.topAnchor.constraint(equalTo: imagesStack.bottomAnchor, constant: 16),
            
            addKidButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addKidButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            addKidButton.topAnchor.constraint(equalTo: addAdultButton.bottomAnchor, constant: 16),
            
            ageKidStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ageKidStackView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -16),
            ageKidStackView.topAnchor.constraint(equalTo: addKidButton.bottomAnchor, constant: 16),
            ageKidStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            doneButton.leadingAnchor.constraint(equalTo: centerXAnchor),
            doneButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            doneButton.topAnchor.constraint(greaterThanOrEqualTo: ageKidStackView.bottomAnchor, constant: 32),
            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
    
    private func addAdultInStack() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.pngImage(.peopleIcon), for: .normal)
        button.addTarget(self, 
                         action: #selector(deleteAdultButtonAction),
                         for: .touchUpInside)
        button.tag = 0
        imagesStack.addArrangedSubview(button)
    }
    
    private func addKidInStack(age: Int) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.pngImage(.peopleIcon), for: .normal)
        button.setTitleColor(.customColor(.blackColor), for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(0.6, 0.6, 0.6)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, 
                                              left: -(button.imageView?.image?.size.width ?? 0) - 10,
                                              bottom: -(button.imageView?.image?.size.height ?? 0) - 2,
                                              right: 0)
        button.addTarget(self, 
                         action: #selector(deleteKidButtonAction),
                         for: .touchUpInside)
        button.setTitle("\(age)", for: .normal)
        button.tag = age
        imagesStack.addArrangedSubview(button)
    }
    
    private func deleteAdultFromStack() {
        imagesStack.subviews.first{ $0.tag == 0 }?.removeFromSuperview()
    }
    
    private func deleteKidFromStack(age: Int) {
        imagesStack.subviews.first{ $0.tag == age }?.removeFromSuperview()
    }
    
    private func changedAdultsCount() {
        adultsCountLabel.text = .searchMain(.adultsCountText(count: adultsCount))
        delegateView?.changedPersonCount(adultsCount: adultsCount,
                                         kidsCount: kidsCount,
                                         kidsAges: ageKids)
    }
    
    private func changedKidsCount() {
        kidsCountLabel.text = .searchMain(.kidsCountText(count: kidsCount))
        delegateView?.changedPersonCount(adultsCount: adultsCount,
                                         kidsCount: kidsCount,
                                         kidsAges: ageKids)
    }
    
    private func getAgesElements() -> [UIMenuElement] {
        var ages: [UIMenuElement] = []
        for index in 0...14 {
            let title = index == 0 ? "< 1 года" : "\(index)"
            let action = UIAction(title: title,
                                  state: .off,
                                  handler: { [weak self] _ in
                guard let self = self else { return }
                self.ageKids.append(index)
            })
            ages.append(action)
        }
        return ages
    }
    
    // MARK: Creating UI components
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = .searchMain(.personCountTitle)
        label.textColor = .customColor(.blackColor)
        label.font = .customFont(.semiBold, size: 20)
        return label
    }
    
    private func createAdultsCountLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = .searchMain(.adultsCountText(count: adultsCount))
        label.textColor = .customColor(.blackColor)
        label.font = .customFont(.semiBold, size: 16)
        return label
    }
    
    private func createKidsCountLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = .searchMain(.kidsCountText(count: kidsCount))
        label.textColor = .customColor(.blackColor)
        label.font = .customFont(.semiBold, size: 16)
        return label
    }
    
    private func createImagesStack() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }
    
    private func createAddAdultButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.searchMain(.addAdultButtonTitle), for: .normal)
        button.addTarget(self, 
                         action: #selector(addAdultButtonAction),
                         for: .touchUpInside)
        button.backgroundColor = .customColor(.orangeColor)
        button.layer.cornerRadius = 5
        return button
    }
    
    private func createAddKidButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.searchMain(.addKidButtonTitle), for: .normal)
        button.addTarget(self, 
                         action: #selector(selectAgeKidAction),
                         for: .touchUpInside)
        button.backgroundColor = .customColor(.orangeColor)
        button.layer.cornerRadius = 5
        return button
    }
    
    private func createAgeKidTitle() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = .searchMain(.ageKidTitle)
        label.textColor = .customColor(.blackColor)
        label.font = .customFont(.semiBold, size: 16)
        return label
    }
    
    private func createAgeKidDoneButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.searchMain(.addButtonTitle), for: .normal)
        button.addTarget(self, 
                         action: #selector(addKidButtonAction),
                         for: .touchUpInside)
        button.backgroundColor = .customColor(.orangeColor)
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return button
    }
    
    private func createAgeKidStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.isHidden = true
        
        stackView.addArrangedSubview(ageKidTitle)
        stackView.addArrangedSubview(ageKidButton)
        stackView.addArrangedSubview(ageKidDoneButton)
        return stackView
    }
    
    // MARK: Button actions
    
    @objc private func addAdultButtonAction() {
        adultsCount += 1
        addAdultInStack()
    }
    
    @objc private func addKidButtonAction() {
        ageKidStackView.isHidden = true
        kidsCount += 1
        addKidInStack(age: ageKids.last ?? 0)
    }
    
    @objc private func deleteAdultButtonAction() {
        adultsCount -= 1
        deleteAdultFromStack()
    }
    
    @objc private func deleteKidButtonAction(_ sender: UIButton) {
        kidsCount -= 1
        deleteKidFromStack(age: sender.tag)
        
        guard let index = ageKids.firstIndex(where: { $0 == sender.tag }) else { return }
        ageKids.remove(at: index)
        print(ageKids)
    }
    
    @objc private func selectAgeKidAction() {
        ageKidStackView.isHidden = false
    }
    
    @objc private func doneButtonAction() {
        delegateView?.clickedDoneButton()
    }
}
