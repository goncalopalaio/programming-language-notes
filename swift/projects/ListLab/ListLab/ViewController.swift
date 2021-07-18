//
//  ViewController.swift
//  ListLab
//
//  Created by Goncalo Palaio on 16/07/2021.
//

import Cocoa

class ViewModel: NSObject {
    var idx = 0
    var items = [LineData]()
    var allItems = [LineData]()
    
    var searchQuery: String = "*"
    
    var lastRowIdx: Int {
        idx - 1
    }
    
    func start() {
        
    }
    
    /*func updateWithTimer() {
     idx += 1
     // items.append(LineData(content: "\(idx)"))
     items.insert(LineData(content: "\(idx)"), at: 0)
     print(items.count)
     }*/
    
    func updateWithMessage(message: String) {
        idx += 1
        
        let jsonData = message.data(using: .utf8)!
        let data: LineData = try! JSONDecoder().decode(LineData.self, from: jsonData)
        items.insert(data, at: 0)
    }
    
    func updateWithQuery(query: String) {
        self.searchQuery = query
        
        items = items.map({
            $0.highlighted = $0.content.contains(query)
            
            return $0
        })
    }
}

class ViewController: NSViewController {
    
    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var tableView: NSTableView!
    
    var viewModel = ViewModel()
    // var timer: Timer!
    
    var wst: URLSessionWebSocketTask!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear() {
        
        // Do any additional setup after loading the view.
        viewModel.start()
        
        // timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateWithTimer), userInfo: nil, repeats: true)
        
        let urlSession = URLSession(configuration: .default)
        let sc = "ws://0.0.0.0:8080/?device=G070VM1695041HB3"
        wst = urlSession.webSocketTask(with: URL(string: sc)!)
        wst.resume()
        readMessage()
    }
    
    override func viewWillDisappear() {
        // timer.invalidate()
        wst.cancel(with: .goingAway, reason: nil)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    /*@objc
     func updateWithTimer() {
     viewModel.updateWithTimer()
     
     self.tableView.reloadData()
     self.tableView.scrollRowToVisible(viewModel.lastRowIdx)
     }*/
    
    @IBAction func searchFieldAction(_ sender: NSSearchField) {
        print("searchFieldAction")

        let query = sender.stringValue
        
        viewModel.updateWithQuery(query: query)
        tableView.reloadData()
    }
    
    func readMessage() {
        wst.receive(completionHandler: { result in
            switch result {
            case .failure(let error):
                print("Failed to receive message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    // print("Received text message: \(text)")
                    DispatchQueue.main.async {
                        self.viewModel.updateWithMessage(message: text)
                        self.tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideUp)
                    }
                    
                case .data(let data):
                    print("Received binary message: \(data)")
                default:
                    fatalError()
                }
                
                // This API reads messages 1 by 1 so we need to call receive again
                self.readMessage()
            }
        })
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
            
            
            
            if currentItem.highlighted {
                cellView.textField?.stringValue = "->\(currentItem.content)"
            } else {
                cellView.textField?.stringValue = currentItem.content
            }
            
            return cellView
            
        } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "userInfoColumn") {
            
        } else {
            
        }
        
        return nil
    }
}
