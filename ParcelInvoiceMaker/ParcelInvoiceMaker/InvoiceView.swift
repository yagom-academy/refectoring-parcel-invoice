//
//  ParcelInvoiceMaker - InvoiceView.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class InvoiceView: UIView {
    let parcelInformation: ParcelInformation
    
    init(parcelInformation: ParcelInformation) {
        self.parcelInformation = parcelInformation
        super.init(frame: .zero)
        backgroundColor = .systemBrown
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        let nameLabel: UILabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .preferredFont(forTextStyle: .largeTitle)
        nameLabel.text = "이름 : \(parcelInformation.receiver.name)"
        
        let mobileLabel: UILabel = UILabel()
        mobileLabel.textColor = .black
        mobileLabel.font = .preferredFont(forTextStyle: .largeTitle)
        mobileLabel.text = "전화 : \(parcelInformation.receiver.mobile)"
        
        let addressLabel: UILabel = UILabel()
        addressLabel.textColor = .black
        addressLabel.font = .preferredFont(forTextStyle: .largeTitle)
        addressLabel.text = "주소 : \(parcelInformation.receiver.address)"
        
        let costLabel: UILabel = UILabel()
        costLabel.textColor = .black
        costLabel.font = .preferredFont(forTextStyle: .largeTitle)
        costLabel.text = "요금 : \(parcelInformation.discountedCost)"
                
        let mainStackView: UIStackView = .init(arrangedSubviews: [nameLabel, mobileLabel, addressLabel, costLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 16
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        
        let stampImageView: UIImageView = UIImageView(image: UIImage(named: "stamp"))
        stampImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stampImageView)
        
        let safeArea: UILayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -22),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -32),
            stampImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.2),
            stampImageView.widthAnchor.constraint(equalTo: stampImageView.heightAnchor),
            stampImageView.centerXAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            stampImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -30)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let height = bounds.height
        let width = bounds.width
        
        context.move(to: CGPoint(x: width * 0.08, y: height * 0.15))
        context.addRect(bounds.insetBy(dx: width * 0.08,
                                       dy: height * 0.15))
        context.setLineWidth(5)
        context.setStrokeColor(UIColor.red.cgColor)
        context.drawPath(using: .stroke)
    }
}
