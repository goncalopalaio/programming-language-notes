//
//  ViewController.swift
//  CommonInputControls
//
//  Created by Goncalo Palaio on 15/07/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var buttonProgrammaticAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        buttonProgrammaticAction.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }


    @IBAction func buttonTapped(_ sender: Any) {
        print("Button was tapped: \(sender)")
        
        if toggle.isOn {
            print("Switch is on")
        } else {
            print("Switch is off")
        }
        
        print("Slider value is \(slider.value)")
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        print("Switch is \(sender.isOn)")
    }
    
    @IBAction func sliderValueWasChanged(_ sender: UISlider) {
        print("Slider has \(sender.value)")
    }
    
    @IBAction func keyboardReturnKeyTapped(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }
    @IBAction func textChanged(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }

    @IBAction func respondToTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        print(location)
    }
}

