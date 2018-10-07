//
//  BadSmartphoneHabitsViewController.swift
//  HelloBe
//
//  Created by Daniel Aguiar on 2/10/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit

class BadSmartphoneHabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sair(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func send(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
