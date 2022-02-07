//
//  DayForcastTableViewCell.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import UIKit

class DayForcastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var forcastedHighLabel: UILabel!
    
    func updateViews(day: Day) {
        dayNameLabel.text = Date().dayOfWeek(day: day)
        forcastedHighLabel.text = "\(day.highTemp)"
        iconImageView.image = UIImage(named: day.weather.iconString)
    }
}

extension Date {
    func dayOfWeek(day: Day) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let date = dateFormatter.date(from: day.validDate)
        
        dateFormatter.dateFormat = "EEEE"
        guard let date = date else { return nil }
        return dateFormatter.string(from: date)
    }
}
