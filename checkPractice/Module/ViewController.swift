//
//  ViewController.swift
//  checkPractice
//
//  Created by mobile developer on 22.06.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Headline {
    var id : Int
    var date : Date
    var title : String
    var text : String
    var image : String
}

class ViewController: UIViewController, UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource, NavigationBarDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNavigationBar: NavigationBar!
    
    var forecastArray:[Weather] = [Weather]()
    var copyForecast:[Weather] = [Weather]()
    var flag = false
    let images: [UIImage] = [ #imageLiteral(resourceName: "newsletter"),
                              #imageLiteral(resourceName: "notification"),
                              #imageLiteral(resourceName: "activationCode"),
                              #imageLiteral(resourceName: "allNotifications")
    ]
    let sectionsTitles = ["Newsletter",
                          "Notifications",
                          "Activation code",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        customNavigationBar.delegate = self
    }
    
}

//MARK: Extension for table view
extension ViewController{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flag ? 1 : forecastArray.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! FirstViewCell
        if flag{
                headerView.headerImage.image = images[section]
                headerView.headerTitle.text = sectionsTitles[section]
        }
        else {
                headerView.headerImage.image = images[3]
                headerView.headerTitle.text = "All notifications"
            }
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstViewCell
        cell.textCell.numberOfLines = 0
        if !flag {
            cell.titleCell.text = forecastArray[indexPath.row].location
            cell.dateCell.text = forecastArray[indexPath.row].date
            let txt:String
                =   "Max temperature is " + forecastArray[indexPath.row].maxTemp.toString() + "\n" +
                    "Average temperature is " + forecastArray[indexPath.row].avgTemp.toString() + "\n" +
                    "Min temperature is " + forecastArray[indexPath.row].minTemp.toString()
            cell.textCell.text = txt
        }
        else{
            cell.titleCell.text = copyForecast[indexPath.section].location
            cell.dateCell.text = copyForecast[indexPath.section].date
            let txt:String
                =   "Max temperature is " + copyForecast[indexPath.section].maxTemp.toString() + "\n" + "Average temperature is " + copyForecast[indexPath.section].avgTemp.toString() + "\n" + "Min temperature is " + copyForecast[indexPath.section].minTemp.toString()
            cell.textCell.text = txt
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        flag ? sectionsTitles.count : 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
}

//MARK: Extensions for gestures
extension ViewController{
    func listTap() {
        flag = false
        reload()
    }
    func checkListTap() {
        flag = true
        reload()
    }
    
}
//MARK: Extenstion for HTTPRequests
extension ViewController{
    func fetchWeather(){
        let headers:HTTPHeaders = [
            "key":"c1a4b9e2e18f4eab90d83758212506",
        ]
        let params:[String:Any] = [
            "q":"Izhevsk",
            "days":3
        ]
        let request = AF.request("https://api.weatherapi.com/v1/forecast.json",parameters: params, headers: headers).responseJSON{ [self] response in
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
               // print(json)
                let dates = json["forecast"]["forecastday"].arrayValue.map{$0["date"].stringValue}
                    
                let maxTemps = json["forecast"]["forecastday"].arrayValue.map{$0["day"]["maxtemp_c"].doubleValue}
                let minTemps = json["forecast"]["forecastday"].arrayValue.map{$0["day"]["mintemp_c"].doubleValue}
                let avgTemps = json["forecast"]["forecastday"].arrayValue.map{$0["day"]["avgtemp_c"].doubleValue}
                let city = json["location"]["name"].stringValue
                
                for i in 0..<dates.count{
                    let tmp:Weather = Weather(location: city, date: dates[i], maxTemp: maxTemps[i], minTemp: minTemps[i], avgTemp: avgTemps[i])
                    forecastArray.append(tmp)
                    print(forecastArray[i])
                    
                }
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async{
                copyForecast = forecastArray
                copyForecast.sort(by: {$0.maxTemp > $1.maxTemp})
                reload()
            }
        }
    }
    func reload(){
        self.tableView.reloadData()
    }
    
}
extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}
struct Weather {
    var location:String = ""
    var date:String = ""
    var maxTemp:Double = 0.0
    var minTemp:Double = 0.0
    var avgTemp:Double = 0.0
    init(location: String, date: String, maxTemp: Double, minTemp: Double, avgTemp: Double){
        self.location = location
        self.date = date
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.avgTemp = avgTemp
    }
}
