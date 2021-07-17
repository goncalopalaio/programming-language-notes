//
//  MainViewController.swift
//  RainbowTabs
//
//  Created by Goncalo Palaio on 16/07/2021.
//

import UIKit

extension UIColor {
    static let awesomeRed = UIColor(named: "Awesome Red")
}

class MainViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .awesomeRed
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
