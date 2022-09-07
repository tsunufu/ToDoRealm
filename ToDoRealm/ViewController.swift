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
        
        //nil回避
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
     
        //nil回避
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
    
    // スワイプしてセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Realmのデータ削除
        try! realm.write {
            realm.delete(self.titleText[indexPath.row])
        }
        
        self.titleTable.deleteRows(at: [indexPath], with: .automatic)
    }
    //indexpath.rowの取得がおかしくなった時の確認用
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
         // タップされたセルの行番号を出力
         print("\(indexPath.row)番目の行が選択されました。")
     }

    

}

