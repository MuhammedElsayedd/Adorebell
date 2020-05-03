//
//  ViewController2.swift
//  AdoreBell
//
//  Created by Muhammed Elsayed on 3/1/18.
//  Copyright © 2018 Muhammed Elsayed All rights reserved.
//

import UIKit
import FirebaseDatabase
import Pulsator

class ViewController2: UIViewController {

    var ref: DatabaseReference!
    let pulsator = Pulsator()
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var motionStateLabel: UILabel!
    @IBOutlet weak var numberOfPassengers: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        ref.observe(DataEventType.value) { (dataSnapShot) in
            if dataSnapShot.childSnapshot(forPath: "motion").value as? Bool == true{
                self.pulsator.backgroundColor=UIColor.red.cgColor
                self.motionStateLabel.text="Somebody is standing in front of your door now!"
            }else{
                self.pulsator.backgroundColor=self.openButton.backgroundColor?.cgColor
                self.motionStateLabel.text="Nobody is standing in front of your door"
            }
            self.numberOfPassengers.text=String(describing: dataSnapShot.childSnapshot(forPath: "passengers").value!)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        pulsator.backgroundColor=openButton.backgroundColor?.cgColor
        pulsator.position=imageView.center
        pulsator.radius=150
        pulsator.numPulse=6
        pulsator.animationDuration=7
        view.layer.insertSublayer(pulsator, below: imageView.layer)
        pulsator.start()

    }
    
    @IBAction func openDoor(_ sender: Any) {
       
        pulsator.stop()
        let alert = UIAlertController(title: "Open Door", message: "Are you sure you want open the door ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .`default`, handler: { _ in
            self.ref.child("doorCommand").setValue(true)
            self.pulsator.start()
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: { _ in
            self.pulsator.start()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func clearPassengersButton(_ sender: Any) {
        numberOfPassengers.text="0"
        ref.child("passengers").setValue(0)
    }
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
