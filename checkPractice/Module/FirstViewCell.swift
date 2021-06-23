//
//  FirstViewCell.swift
//  Practice
//
//  Created by mobile developer on 21.06.2021.
//

import UIKit

struct Notification{
    var id:String?
    var text:String?
    var title:String?
    var length:Int?
    var date: Date?
    
    enum operationType {
        case newsletter
        case notification
        case activationCode
    }
    
}

class FirstViewCell : UITableViewCell{
    
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var textCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    
    func showNotification(){
        dateCell?.text = "01/01/2000"
        textCell?.text = "aaaa\n\n\naaaa"
        titleCell?.text = "Title"
    }
    override func awakeFromNib() {
            super.awakeFromNib()
        }
     
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
    }
}
