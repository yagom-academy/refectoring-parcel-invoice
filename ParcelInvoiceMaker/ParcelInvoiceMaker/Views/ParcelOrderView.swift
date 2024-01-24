//
//  ParcelInvoiceMaker - ParcelOrderView.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

protocol ParcelOrderViewDelegate {
    func parcelOrderMade(_ parcelInformation: ParcelInformationProvider)
}

class ParcelOrderView: UIView {
    
    private var delegate: ParcelOrderViewDelegate!
    
    private let receiverNameField: UITextField = {
        let field: UITextField = .init()
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let receiverMobileField: UITextField = {
        let field: UITextField = .init()
        field.borderStyle = .roundedRect
        field.keyboardType = .phonePad
        return field
    }()
    
    private let addressField: UITextField = {
        let field: UITextField = .init()
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let costField: UITextField = {
        let field: UITextField = .init()
        field.borderStyle = .roundedRect
        field.keyboardType = .decimalPad
        return field
    }()
    
    private let discountSegmented: UISegmentedControl = {
        let control: UISegmentedControl = .init()
        control.insertSegment(withTitle: "없음", at: 0, animated: false)
        control.insertSegment(withTitle: "VIP", at: 1, animated: false)
        control.insertSegment(withTitle: "쿠폰", at: 2, animated: false)
        control.selectedSegmentIndex = 0
        return control
    }()
    
    init(delegate: ParcelOrderViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        backgroundColor = .systemBrown
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func touchUpOrderButton(_ sender: UIButton) {
        
        guard let name: String = receiverNameField.text,
              let mobile: String = receiverMobileField.text,
              let address: String = addressField.text,
              let costString: String = costField.text,
              name.isEmpty == false,
              mobile.isEmpty == false,
              address.isEmpty == false,
              costString.isEmpty == false,
              let cost: Double = Double(costString)
        else {
            return
        }
        
        // 객체 미용 체조, 8원칙 일급 콜렉션 사용
        let discountStrategyManager = DiscountStrategyManager(items: [
            NoDiscountStrategy(discountRate: 1),
            VIPDiscountStrategy(discountRate: 0.8),
            CouponDiscountStrategy(discountRate: 0.5)
        ])
        
        let selectedDiscountStrategy = discountStrategyManager
            .getStrategies()[
                discountSegmented.selectedSegmentIndex
            ]
        
        do {
            // 객체미용체조 7원칙 '2개 이상의 원시타입 프로퍼티를 갖는 타입 금지'를 적용하면서 변경
            let parcelInformation: ParcelInformationProvider = ParcelInformation(
                parcelInfo: ParcelInfo(
                    address: address,
                    receiver: ReceiverInfo(
                        receiverName: try Name(name),
                        receiverMobile: try Mobile(mobile)),
                    cost: ParcelCost(
                        deliveryCost: try Cost(cost),
                        discountStrategy: selectedDiscountStrategy)))
            
            delegate.parcelOrderMade(parcelInformation)
        } catch let error {
            // 에러 처리
            print("Error: \(error)")
        }
    }
    
    private func layoutView() {
        
        let logoImageView: UIImageView = UIImageView(image: UIImage(named: "post_office_logo"))
        logoImageView.contentMode = .scaleAspectFit
        
        let nameLabel: UILabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.text = "이름"
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let mobileLabel: UILabel = UILabel()
        mobileLabel.textColor = .black
        mobileLabel.text = "전화"
        mobileLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let addressLabel: UILabel = UILabel()
        addressLabel.textColor = .black
        addressLabel.text = "주소"
        addressLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let costLabel: UILabel = UILabel()
        costLabel.textColor = .black
        costLabel.text = "요금"
        costLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let discountLabel: UILabel = UILabel()
        discountLabel.textColor = .black
        discountLabel.text = "할인"
        discountLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let notificationLabel: UILabel = UILabel()
        notificationLabel.textColor = .black
        notificationLabel.text = "알림"
        notificationLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let nameStackView: UIStackView = .init(arrangedSubviews: [nameLabel, receiverNameField])
        nameStackView.distribution = .fill
        nameStackView.spacing = 8
        nameStackView.axis = .horizontal
        
        let mobileStackView: UIStackView = .init(arrangedSubviews: [mobileLabel, receiverMobileField])
        mobileStackView.spacing = 8
        mobileStackView.axis = .horizontal
        
        let addressStackView: UIStackView = .init(arrangedSubviews: [addressLabel, addressField])
        addressStackView.spacing = 8
        addressStackView.axis = .horizontal
        
        let costStackView: UIStackView = .init(arrangedSubviews: [costLabel, costField])
        costStackView.spacing = 8
        costStackView.axis = .horizontal
        
        let discountStackView: UIStackView = .init(arrangedSubviews: [discountLabel, discountSegmented])
        discountStackView.spacing = 8
        discountStackView.axis = .horizontal
        
        let makeOrderButton: UIButton = UIButton(type: .system)
        makeOrderButton.backgroundColor = .white
        makeOrderButton.setTitle("택배 보내기", for: .normal)
        makeOrderButton.addTarget(self, action: #selector(touchUpOrderButton), for: .touchUpInside)
        
        let mainStackView: UIStackView = .init(arrangedSubviews: [logoImageView, nameStackView, mobileStackView, addressStackView, costStackView, discountStackView, makeOrderButton])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 8
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        
        let safeArea: UILayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.1),
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -16)
        ])
    }
}
