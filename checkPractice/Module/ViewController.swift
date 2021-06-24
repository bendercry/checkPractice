//
//  ViewController.swift
//  checkPractice
//
//  Created by mobile developer on 22.06.2021.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource, NavigationBarDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNavigationBar: NavigationBar!
    
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
    var example = [
        "afahgfsi af aih fhi ashk fsbaih ihfb abosi bfohb abhsf abkf blab jlf beo b",
        "a\nb",
        "a\nb\nc",
        "a\nb\nc\nd",
        "a\nb\nc\nd\ne",
        "a\nb\nc\nd\ne\nf",
        "a\nb\nc\nd\ne\nf\ng",
        "a\nb\nc\nd\ne\nf\ng\nh",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        customNavigationBar.delegate = self
    }
}

//MARK: Extension for table view
extension ViewController{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return example.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! FirstViewCell
        if(flag){
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
        cell.titleCell.text = "Title"
        cell.textCell.text = example[indexPath.row]
        cell.textCell.numberOfLines = 0
        cell.dateCell.text = "01/01/2000"
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
        tableView.reloadData()
    }
    func checkListTap() {
        flag = true
        tableView.reloadData()
    }
   
}
