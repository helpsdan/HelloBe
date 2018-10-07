//
//  BadEatingHabitsViewController.swift
//  HelloBe
//
//  Created by Daniel Aguiar on 20/9/18.
//  Copyright © 2018 Daniel Aguiar. All rights reserved.
//

import UIKit
import CoreData

class BadEatingHabitsViewController: UIViewController {
    
    @IBOutlet weak var swFastFood: UISwitch!
    @IBOutlet weak var swFriedFood: UISwitch!
    @IBOutlet weak var swSalads: UISwitch!
    @IBOutlet weak var swTime: UISwitch!
    @IBOutlet weak var swFuits: UISwitch!
    @IBOutlet weak var swNutri: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func btSend(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


