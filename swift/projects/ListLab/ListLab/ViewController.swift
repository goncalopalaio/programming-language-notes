//
//  ViewController.swift
//  ListLab
//
//  Created by Goncalo Palaio on 16/07/2021.
//

import Cocoa

class ViewModel: NSObject {
    var idx = 0
    var items = [String]()
    
    var lastRowIdx: Int {
        idx - 1
    }
    
    func start() {
    }
    
    func updateWithTimer() {
        idx += 1
        items.append("\(idx)")
        print(items.count)
    }
}

class ViewController: NSViewController {
    

    @IBOutlet weak var tableView: NSTableView!
    
    var viewModel = ViewModel()
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewModel.start()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear() {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateWithTimer), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear() {
        timer.invalidate()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc
    func updateWithTimer() {
        viewModel.updateWithTimer()
        
        self.tableView.reloadData()
        //self.tableView.reloadData(forRowIndexes: IndexSet(integersIn: (0)...(viewModel.items.count)), columnIndexes: IndexSet(integer: 0))
        
        self.tableView.scrollRowToVisible(viewModel.lastRowIdx)
    }
}

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.items.count
    }
}

extension ViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let currentItem = viewModel.items[row]

        if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "idColumn") {
            let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "idCell")
            guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else {return nil}
            cellView.textField?.stringValue = currentItem
            return cellView

        } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "userInfoColumn") {
            
        } else {
            
        }
        
        return nil
    }
}
