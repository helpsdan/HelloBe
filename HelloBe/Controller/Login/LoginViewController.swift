//
//  LoginViewController.swift
//  HelloBe
//
//  Created by Daniel Aguiar on 25/9/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit
import MapKit
import AVKit

class LoginViewController: UIViewController {

    enum PlaceMessage{
        case message(String)
    }
    
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func previewVideo(_ sender: UIButton) {
        if let path = Bundle.main.path(forResource: "video1", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion:{
                video.play()
            })
        }
    }
    
    
    @IBAction func Login(_ sender: UIButton) {
        if valida() != false{
            dismiss(animated: true, completion: nil)
        }else{
            showMessage(type: .message("Senha ou usuário incorretos!"))
        }
    }
    
    func valida() -> Bool{
        let usuario = self.user.text!
        let senha = self.pass.text!
        
        if usuario == "FIAP" || senha == "abc123"{
            return true
        }else{
            return false
        }
    }

    func showMessage(type: PlaceMessage){
        let title: String
        var message: String
        switch type {
        case .message(let name):
            title = "Senha ou usuário incorretos!"
            message = ""
            let _ = name
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tentar novamente", style: .cancel, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil )
    }
    
}
