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
    
    
//    var titleText = [String]()
//    var contentText = [String]()
//    var dateText = [String]()
    
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
        
        //タップ選択できるように
        titleTable.allowsSelectionDuringEditing = true
        
//        titleTable.isEditing = true
        
        //realmのデータ取得．後で整理
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
    
    @IBAction func edit() {
        //編集モードをオンに
        titleTable.isEditing = true
    }
    
    //並べ替えを許可
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Results型だとremoveとinsertが使えないのでArray型に変換
//        let titleText = Array(titleText)
        //varにしないとダメだった
        var titleTextRow = Array(titleText)
        //元はsourceIndexPath
        let movedText = titleText[sourceIndexPath.row]
//        let itemToMove = titleText.remove(at: sourceIndexPath.row)
        titleTextRow.remove(at: sourceIndexPath.row)
//        titleText.insert(itemToMove, at: destinationIndexPath.row)
        //遷移先はdestinationIndexPath(引数見ればわかる)
        titleTextRow.insert(movedText, at: destinationIndexPath.row)
//        let movedText = titleText[sourceIndexPath.row]
//        titleText.removeAtIndex(sourceIndexPath)
//        titleText.insert(movedText, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    

}

