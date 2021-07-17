//
//  ViewController.swift
//  RainbowTabs
//
//  Created by Goncalo Palaio on 16/07/2021.
//

import UIKit

class RedViewController: UIViewController {
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBarController?.tabBar.items?[0].badgeValue = "!"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarItem.badgeValue = String(count)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarItem.badgeValue = nil
        count += 1
    }

}

