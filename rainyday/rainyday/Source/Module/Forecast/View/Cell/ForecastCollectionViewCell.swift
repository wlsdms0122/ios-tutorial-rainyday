//
//  ForecastCollectionViewCell.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    // MARK: - Layout
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dayTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    // MARK: - Property
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    // MARK: - Lifecycle
    override func prepareForReuse() {
        dateLabel.text = nil
        weatherLabel.text = nil
        dayTemperatureLabel.text = nil
        minTemperatureLabel.text = nil
        maxTemperatureLabel.text = nil
        humidityLabel.text = nil
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func setupLayout() {
        clipsToBounds = false
        layer.cornerRadius = 10
        
        layer.shadowColor = R.black.withAlphaComponent(0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
    }
}
