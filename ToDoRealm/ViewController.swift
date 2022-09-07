//
//  ViewController.swift
//  ToDoRealm
//
//  Created by ryo on 2022/09/05.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var titleTable: UITableView!
    
    var titleText: Results<Post>!
    var contentText: Results<Post>!
    var dateText: Results<Post>!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let realm = try! Realm()
        
        if let titleTable = titleTable {
            titleTable.dataSource = self
            titleTable.delegate = self
        }
        
        //realmのデータ取得
        self.titleText = realm.objects(Post.self)
        self.contentText = realm.objects(Post.self)
        self.dateText = realm.objects(Post.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        if titleTable != nil {
            self.titleTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleText.count
//        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post: Post = self.titleText[indexPath.row]
        cell.textLabel?.text = post.title
        
//        cell.textLabel?.text = "テスト"
        
        return cell
        
    }

    

}

