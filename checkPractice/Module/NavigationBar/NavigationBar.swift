//
//  CustomBar.swift
//  checkPractice
//
//  Created by mobile developer on 22.06.2021.
//

import UIKit
@objc protocol NavigationBarDelegate: AnyObject {
    @objc optional func listTap()
    @objc optional func checkListTap()
}



class NavigationBar: UIView{
    weak var delegate: NavigationBarDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var checkListButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    
    override init (frame: CGRect){
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    private func customInit(){
        let bundle = Bundle(for: NavigationBar.self)
        bundle.loadNibNamed("NavigationBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func listTap(_ sender: UIButton) {
        delegate?.listTap?()
    }
    @IBAction func checkListTap(_ sender: UIButton) {
        delegate?.checkListTap?()
    }
}
