//
//  DayDetailsViewController.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
    //Api key cab12b2293ff4dbe83068be7f0ded509
    
    //MARK: - Outlets
    @IBOutlet weak var dayForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    
    var days: [Day]?
    var forecastData: TopLevelDictionary?
    
    //MARK: - Properties
    
    //MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        dayForcastTableView.delegate = self
        dayForcastTableView.dataSource = self
        
        NetworkController.fetchDays { forecastData in
            guard let forecastData = forecastData else { return }
            self.forecastData = forecastData
            self.days = forecastData.days
            
            DispatchQueue.main.async {
                self.updateViews()
                self.dayForcastTableView.reloadData()
            }
        }
    }
    
    func updateViews() {
        guard let days = days else { return }
        let day = days[0]
        cityNameLabel.text = "Salt Lake City"
        currentTempLabel.text = "\(day.currentTemp)"
        currentHighLabel.text = "\(day.highTemp)"
        currentLowLabel.text = "\(day.lowTemp)"
        currentDescriptionLabel.text = "\(day.weather.description)"
    }
}

//MARK: - Extenstions
extension DayDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let days = days else { return 0 }
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as? DayForcastTableViewCell else {return UITableViewCell()}
        guard let days = days else { return cell }
        let day = days[indexPath.row]
        cell.updateViews(day: day)
        return cell
    }
}

