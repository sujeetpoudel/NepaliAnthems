//
//  ViewController.swift
//  NepaliAnthems
//
//  Created by IMCS on 10/24/19.
//  Copyright © 2019 IMCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var NationalSongsButton: UIButton!
    
    @IBOutlet weak var ShareButton: UIButton!
    
    
    @IBOutlet weak var RateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        styleFilledButton(NationalSongsButton)
        styleFilledButton(ShareButton)
        styleFilledButton(RateButton)
        
    }
    
    @IBAction func ShareAction(_ sender: UIButton) {
        
        let activity = UIActivityViewController(
                   activityItems: ["Here is the link of this app : ..."],
                   applicationActivities: nil
               )
               present(activity, animated: true, completion: nil)
    }
    func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
       button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.blue
        button.titleLabel?.textColor = UIColor.blue
    }


}

