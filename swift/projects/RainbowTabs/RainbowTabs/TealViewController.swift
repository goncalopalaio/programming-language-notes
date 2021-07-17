//
//  TealViewController.swift
//  RainbowTabs
//
//  Created by Goncalo Palaio on 16/07/2021.
//

import UIKit

struct NewScreenData {
    var test: String
}

class TealViewController: UIViewController {
    var data: NewScreenData!

    @IBOutlet weak var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textLabel.text = NSDate().description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textLabel.text = NSDate().description
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
