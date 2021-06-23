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
                              #imageLiteral(resourceName: "activationCode")
    ]
    let sectionsTitles = ["Newsletter",
                          "Notifications",
                          "Activation code"
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
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        if(flag){
        
        let image = UIImageView(image: images[section])
        image.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        view.addSubview(image)
        
        let label = UILabel()
        label.text = sectionsTitles[section]
        label.frame = CGRect(x: 45, y: 5, width: 150, height: 35)
        view.addSubview(label)
        
        }
        else {
            let label = UILabel()
            label.text = "All notifications"
            label.frame = CGRect(x: 5, y: 5, width: 150, height: 35)
            view.addSubview(label)
        }
        return view
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
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        if(velocity.y>0) {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.navigationController?.setToolbarHidden(true, animated: true)
            }, completion: nil)

        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.navigationController?.setToolbarHidden(false, animated: true)
            }, completion: nil)
          }
       }
}
